class PdsConsent < ApplicationRecord
  # Encryption for IP address using Lockbox (same key pattern as LegalConsent)
  lockbox_key = lambda do
    key_hex = ENV.fetch('LOCKBOX_MASTER_KEY') { Digest::SHA256.hexdigest('fallback_key_for_dev') }
    [key_hex].pack('H*')
  end

  has_encrypted :ip_address, key: lockbox_key, encrypted_attribute: :ip_address_ciphertext

  validates :did, presence: true
  validates :pds_host, presence: true
  validates :accepted_at, presence: true
  validate :must_have_at_least_one_url

  scope :for_did, ->(did) { where(did: did) }
  scope :for_pds, ->(host) { where(pds_host: host) }

  private

  def must_have_at_least_one_url
    if tos_url.blank? && privacy_policy_url.blank?
      errors.add(:base, :no_legal_urls)
    end
  end
end
