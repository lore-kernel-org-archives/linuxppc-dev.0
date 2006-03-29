Return-Path: <ivan@vmfacility.fr>
Received: from postfix1-c.free.fr (postfix1-c.free.fr [213.228.0.79])
	by ozlabs.org (Postfix) with ESMTP id 380FE67A3F
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 05:43:05 +1100 (EST)
Received: from smtp2-g19.free.fr (smtp2-g19.free.fr [212.27.42.28])
	by postfix1-c.free.fr (Postfix) with ESMTP id 1E20F188EFFE
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2006 20:43:04 +0200 (CEST)
Message-ID: <442AD531.2040702@vmfacility.fr>
Date: Wed, 29 Mar 2006 20:42:57 +0200
From: Ivan Warren <ivan@vmfacility.fr>
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
Subject: Re: [OT] ppc64 serialization problem
References: <1143597506.3075.53.camel@localhost.localdomain>	<17450.2061.510951.479016@cargo.ozlabs.ibm.com>	<1143656433.3075.108.camel@localhost.localdomain>
	<20060329183259.GA18514@suse.de>
In-Reply-To: <20060329183259.GA18514@suse.de>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="------------ms030701090102010901090103"
Cc: Greg Smith <gsmith@nc.rr.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a cryptographically signed message in MIME format.

--------------ms030701090102010901090103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Olaf Hering wrote:
>  On Wed, Mar 29, Greg Smith wrote:
>
>   
>> So it is clear between .A and .B -> value of b was read then written. If
>> anything happens between .A and .B to ->b, then it is lost.
>>     
>
> Even gcc4.1 does it that way with -O0
Yeah.. Noticed that..gcc 3.3.3 and gcc 4.0.3 also do this

Even declaring the field volatile has no effect..

Question :
Is this *NORMAL* behavior ? I discussed this with some C folks and they 
seem to think (at least some of them) that it's broken per standards.. 
(volatile fields should be only read/written IFF read/written explicitly 
- pretty much what section 6.3.7 of the C std says).

Anyway I can produce perfectly valid sample code (to my understanding 
anyway) that produces incorrect result.. YUCK !

This is also possibly a problem with the powerpc64 back end of gcc..

Anyway.. It's OT.. Sorry to have bothered you guys ! (And thanks Greg 
for pointing me here).

--Ivan

--------------ms030701090102010901090103
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
MCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3Rl
IFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJ
AoGBAMSmPFVzVftOucqZWh5owHUEcJ3f6f+jHuy9zfVb8hp2vX8MOmHyv1HOAdTlUAow1wJj
WiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYkKhPPK9Xzgnc9A74r/rsYPge/QIACZNenpruf
ZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGjgZQwgZEwEgYDVR0TAQH/BAgwBgEB/wIB
ADBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLnRoYXd0ZS5jb20vVGhhd3RlUGVyc29u
YWxGcmVlbWFpbENBLmNybDALBgNVHQ8EBAMCAQYwKQYDVR0RBCIwIKQeMBwxGjAYBgNVBAMT
EVByaXZhdGVMYWJlbDItMTM4MA0GCSqGSIb3DQEBBQUAA4GBAEiM0VCD6gsuzA2jZqxnD3+v
rL7CF6FDlpSdf0whuPg2H6otnzYvwPQcUCCTcDz9reFhYsPZOhl+hLGZGwDFGguCdJ4lUJRi
x9sncVcljd2pnDmOjCBPZV+V2vf3h9bGCE6u9uo05RAaWzVNd+NWIXiC3CEZNd4ksdMdRv9d
X2VPMYIDOzCCAzcCAQEwaTBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1
bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElz
c3VpbmcgQ0ECAw8zMzAJBgUrDgMCGgUAoIIBpzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0wNjAzMjkxODQyNTdaMCMGCSqGSIb3DQEJBDEWBBQ+oUsk3qtm
lC4LbHx5OvPqpl4sJjBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMC
AgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDB4BgkrBgEEAYI3
EAQxazBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5
KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQID
DzMzMHoGCyqGSIb3DQEJEAILMWugaTBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3Rl
IENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVt
YWlsIElzc3VpbmcgQ0ECAw8zMzANBgkqhkiG9w0BAQEFAASCAQA76CEui4yYOeL6G7AFO43G
3+Hhv+X5cZyUnRUfLpVzafhQuyf1RZ+Rz2xC7V+sYnkbbmqkuoRgTH/vQ04Ryu6/oLb8jrVu
/NUajr/pJK8T0lnnEDH/iKZjc8UgL8p424CDh/F6iqu2HYNGaciP0s8F4sA/or1k5xLZBviq
Dl3Y8gCsjGa5A6XbKhs+Xk/ir6KIao2ptkxjl0eSGyTdvl+wLBwlxLokOaobyRACh1wRPQ+q
ot5gXg3to7fysa13HZhsouxXngKiP387938k/pON6AChI+DA6NidbJWGPzdDRWOhqvs1ph41
9d2y994yMzy2YFemT7aip6PmGTlNr6GlAAAAAAAA
--------------ms030701090102010901090103--
