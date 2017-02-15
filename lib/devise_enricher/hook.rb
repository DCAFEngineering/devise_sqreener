# After each sign in, update sign in time, sign in count and sign in IP.
# # This is only triggered when the user is explicitly set (with set_user)
# # and on authentication. Retrieving the user from session (:fetch) does
# # not trigger it.
Warden::Manager.after_set_user :except => :fetch do |record, warden, options|
  if warden.authenticated?(options[:scope]) &&
     record.respond_to?(:enrich_block_sign_in?) && record.enrich_block_sign_in?
    scope = options[:scope]
    warden.logout(scope)
    throw :warden, :scope => scope, :message => record.inactive_message
  end
end
