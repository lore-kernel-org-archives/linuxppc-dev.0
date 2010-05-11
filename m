Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 550ACB7D94
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 May 2010 17:07:45 +1000 (EST)
Received: from LPSC0173W (lpsc0173w.in2p3.fr [134.158.40.173])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with SMTP id o4B6Jm6h019392
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 May 2010 08:19:49 +0200
Message-ID: <44001372909D4EAD8181655EEA5E416C@LPSC0173W>
From: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: Curious serial slowdown
Date: Tue, 11 May 2010 08:18:25 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=SHA1; boundary="----=_NextPart_000_003A_01CAF0E2.87C41450"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_003A_01CAF0E2.87C41450
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

Hello all,
I'm looking for hints on a curious problem.
I have a working kernel on a custom embedded device and it works fine.
We came up with a variation of the device with a few hardware changes, one 
of them being the number of serial ports that goes from 4 to 2.

In order to save time I tried my current kernel. When I boot the custom 
bootlader behaves the same, then the kernel boot behaves the same, but then 
once usermode is reached (the message "init started: BusyBox..."), the new 
card console display crawls to a halt (about one character per second 
instead of 115000 bauds !!!). But the card goes at normal speed as an ssh 
connection shows.

So my question is: is it caused by the fact that there are 2 missing serial 
ports ? Will making a new kernel with the correct hardware definition solve 
it ?
-- 
Guillaume Dargaud
http://www.gdargaud.net/ 

------=_NextPart_000_003A_01CAF0E2.87C41450
Content-Type: application/x-pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

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
DQYJKoZIhvcNAQEFBQAwNDELMAkGA1UEBhMCRlIxDTALBgNVBAoTBENOUlMxFjAUBgNVBAMTDUNO
UlMtU3RhbmRhcmQwHhcNMDgxMTA1MTE0NDM3WhcNMTAxMTA1MTE0NDM3WjBwMQswCQYDVQQGEwJG
UjENMAsGA1UEChMEQ05SUzEQMA4GA1UECxMHVU1SNTgyMTEaMBgGA1UEAxMRR3VpbGxhdW1lIERh
cmdhdWQxJDAiBgkqhkiG9w0BCQEWFWRhcmdhdWRAbHBzYy5pbjJwMy5mcjCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAMC4HJkLqqp0DhpSVFjneK0kabmNTxKhdLZ7iNyNyI5pviepn+4j
4gJNkj188swskTDQ3QKwh5ukRa7Lxzcfz7fMtLd2lzwTuOcz3LOemwGp3TM6ctcOzl/HBBCoTrZi
Hj3lQZUirfzeazGjWeRP4D+Utr0bH6B9Q8EriKbsh815EiU11V/KhoSiayPVHoeL+XrmQz3A8v5t
Ibs0lcmC+MzjhQcmvGcCfwQuLc0yl0cg4Pp6bkn1XL7QlfafvwYdOske0LgJktWBxNYQmm97xTCo
3IjJ2+FijR2M9Vp67OcDzSwNGkLRerAqBwnnWiGKEs/xUZmutvkoVQ38/nzONkUCAwEAAaOCAY0w
ggGJMAwGA1UdEwEB/wQCMAAwEQYJYIZIAYb4QgEBBAQDAgSwMA4GA1UdDwEB/wQEAwIF4DB4Bglg
hkgBhvhCAQ0EaxZpQ2VydGlmaWNhdCBDTlJTLVN0YW5kYXJkLiBQb3VyIHRvdXRlIGluZm9ybWF0
aW9uIHNlIHJlcG9ydGVyIOAgaHR0cDovL2lnYy5zZXJ2aWNlcy5jbnJzLmZyL0NOUlMtU3RhbmRh
cmQvMB0GA1UdDgQWBBTokjByrre7NhuZQ06XlpNjg1b1BDBTBgNVHSMETDBKgBRnWaXlB3RJA+8F
z8wupBjVEMiePKEvpC0wKzELMAkGA1UEBhMCRlIxDTALBgNVBAoTBENOUlMxDTALBgNVBAMTBENO
UlOCAQIwIAYDVR0RBBkwF4EVZGFyZ2F1ZEBscHNjLmluMnAzLmZyMEYGA1UdHwQ/MD0wO6A5oDeG
NWh0dHA6Ly9jcmxzLnNlcnZpY2VzLmNucnMuZnIvQ05SUy1TdGFuZGFyZC9nZXRkZXIuY3JsMA0G
CSqGSIb3DQEBBQUAA4IBAQAPJMyYbojt/U1jJZJD49QroZGWHYgD9OK+qKH6CRYcsa8z018tBosr
QaGEKt0U5yRWj60cp55fVeEPZsyGRyAeDhbBZNmByVF6UpYTtGHM3DvKIQEvwPXL0cfV4AWnQp12
vkSZTv2Jr0HZ7RUTTBscC6rdEGG5bIwJkqjuPiEkIPOZ5mrITOT+H8crA7Z4HHlQbOhWmxjT3rfV
4S14ecMT4Fc8WrEN/iRw1rMHtVY+eEL7opvdoiPS4CBEBUw0YL/+mcRDTc7LdJ43vbA4Wp0N4Ttz
/mKS8oC+hQfi2nB2P6MWWW0uE9CRZTg2uJiUQ99aXVm6VMi5uFXesQ48vbChMYICHzCCAhsCAQEw
OzA0MQswCQYDVQQGEwJGUjENMAsGA1UEChMEQ05SUzEWMBQGA1UEAxMNQ05SUy1TdGFuZGFyZAID
AJC4MAkGBSsOAwIaBQCggbowGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUx
DxcNMTAwNTExMDYxODI1WjAjBgkqhkiG9w0BCQQxFgQUOVTBpR7sZw/8pEXHqSJrjjNe0vQwWwYJ
KoZIhvcNAQkPMU4wTDAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAw
BwYFKw4DAgcwDQYIKoZIhvcNAwICASgwBwYFKw4DAh0wDQYJKoZIhvcNAQEBBQAEggEAkArbc0qK
PoRkPLM64JFgyKisBeJLc58yFZ8gRTb8/a3t2oVP0AOSOLNOGYfRvBXXf3HtflX/mKQH7+6R643a
su4X4Q6I3y4q6ipSGisQOSL3hTVO9kWf3nr+8eAbwFzYQpEfwbx059UFw5gWiEjjPE7VtQ+lbQ7P
LLP9SKsd2PJE32q3xEXGY3iheQsxWfRRzm1/yb3wlAXeW/jd7S9ICf06UH139Op0NNxIII4hmuHb
d7q8nF3AwZOhu0Q3Isd2lBGo9FpOItROUNOAMAldzU8Os3lcnGWF9jabhIY1Cz/Bx4JF3d2z1JqP
nszyR28hzgwD1cnuDC0ygKUQwKNmggAAAAAAAA==

------=_NextPart_000_003A_01CAF0E2.87C41450--
