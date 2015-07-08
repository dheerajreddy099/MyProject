saas_sssd Cookbook
==================
Joins SAAS instance to SAAS AD

Attributes
----------
| Attribute | Description| Default
| --------|---------|-------|
[:saas_sssd][:domain]   | AD Domain | SAAS-AD.SAP.CORP
[:saas_sssd][:server]   | AD Domain server | mo-c4eaa033f.saas-ad.sap.corp
[:saas_sssd][:user]     | Service user | joindom
[:saas_sssd][:password] | Service user password | Start123!


Usage
-----
#### saas_sssd::default

Just include `saas_sssd` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[saas_sssd]"
  ]
}
```
