# infrastructure-squid
A container for running squid proxy. This should run in a pod with a DNS server
as the second container as otherwise this will overwhelm CoreDNS. The example
configuration does not do caching. You will have to enable that for yourself.
