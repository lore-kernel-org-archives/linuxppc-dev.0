Message-ID: <38C580BE.26157A00@claudio.ch>
Date: Tue, 07 Mar 2000 23:20:46 +0100
From: Claudio Nieder <private@claudio.ch>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.15pre11 on PB Lombard
References: <Pine.SOL.3.95.1000307220928.20594A-100000@juliet>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------msACADB76140A5FD2141460307"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a cryptographically signed message in MIME format.

--------------msACADB76140A5FD2141460307
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

> has anyone got the latest kernel from paulus's stable tree running on

$ uname -a
Linux localhost 2.2.15pre11 #4 Mon Mar 6 16:17:02 CET 2000 ppc unknown

compiled with

$ gcc --version
egcs-2.91.66

and used the .config as it was rsynced from linuxcare.

> a 1999 powerbook? It panicks invariably after hda and hcd are initialized.

I have a 400MHz Lombard with 128MB Ram.

No panics for me.

$ dmesg
...
hda: TOSHIBA MK6409MAV, ATA DISK drive
hdc: MATSHITADVD-ROM SR-8171, ATAPI CDROM drive
ide0 at 0x82820000-0x82820007,0x82820160 on irq 13
ide1 at 0x82821000-0x82821007,0x82821160 on irq 14
hda: Enabling MultiWord DMA 2
hda: TOSHIBA MK6409MAV, 6194MB w/0kB Cache, CHS=13424/15/63, (U)DMA
hdc: Enabling MultiWord DMA 2
ohci-control thread code for 0xc04cd020 code at 0xc016f264
New USB bus registered, assigned bus number 1
hdc: ATAPI 20X DVD-ROM drive, 512kB Cache
Uniform CDROM driver Revision: 2.56
scsi0 : MESH
...
hda: Enabling MultiWord DMA 2
hdc: Enabling MultiWord DMA 2
ide1: unexpected interrupt, status=0x00, count=1
phy registers:
 3500 7849 2000 5c10 01e1 0000 0004 2001
 0000 0000 0000 0000 0000 0000 0000 0000
 0200 0000 0000 0000 0000 0000 0020 0000
 0000 0000 002b 0100 0006 0f00 0000 0000
adb devices: [2]: 2 c4 [3]: 3 1 [7]: 7 1f
...
			claudio
--
Claudio Nieder, Kanalweg 1, CH-8610 Uster ,'`.,'`.,'`.,'`.,'`.,'`.,'`
mailto:private@claudio.ch http://www.claudio.ch phone:+41 79 357 6743
--------------msACADB76140A5FD2141460307
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature
Content-Transfer-Encoding: base64

MIIIEgYJKoZIhvcNAQcCoIIIAzCCB/8CAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3DQEHAaCC
BjEwggOwMIIDGaADAgECAgIBHjANBgkqhkiG9w0BAQQFADBwMQswCQYDVQQGEwJDSDEUMBIG
A1UEChMLU3dpc3NrZXkgQUcxGzAZBgNVBAsTElB1YmxpYyBDQSBTZXJ2aWNlczEQMA4GA1UE
BxMHWnVlcmljaDEcMBoGA1UEAxMTU3dpc3NrZXkgSUQgQ0EgMTAyNDAeFw05OTAyMTIxNTE5
MjdaFw0wMTAyMTIxNTE5MDBaMIGbMRswGQYDVQQKExJQcml2YXRlIEluZGl2aWR1YWwxHjAc
BgNVBAsTFTAwODUxMDAwMDE2NDQwMDAwMDExNjETMBEGA1UECxMKMDguMDYuMTk2MTELMAkG
A1UEBhMCQ0gxFzAVBgNVBAMTDkNsYXVkaW8gTmllZGVyMSEwHwYJKoZIhvcNAQkBFhJwcml2
YXRlQGNsYXVkaW8uY2gwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAL2ywpCiFGF31kXc
IQmM+WLS8maGiwvaM80L8Do/vrPSJp4Rp9PHjXIi2nAhMLtoRqLLvHs39qMnNL/j10gZo0fK
wmCu86sGIL9o4s/nocEmohhIp2V+//fZkzevDWUw3fvv79JzHuDoldrzCkq1IKvZ01fbkqsj
UcogmdbNkEvPAgMBAAGjggErMIIBJzARBglghkgBhvhCAQEEBAMCBaAwgdcGCWCGSAGG+EIB
DQSByRaBxlRoaXMgY2VydGlmaWNhdGUgaGFzIGJlZW4gaXNzdWVkIGJ5IFN3aXNza2V5IEFH
IGdvdmVybmVkIGJ5IGl0cyBDZXJ0aWZpY2F0ZSBQcmFjdGljZSBTdGF0ZW1lbnQgKENQUyku
IENQUyBhbmQgZnVydGhlciBpbmZvcm1hdGlvbiBhYm91dCBTd2lzc2tleSBjZXJ0aWZpY2F0
ZXMgYXJlIGF2YWlsYWJsZSBhdCBodHRwOi8vd3d3LnN3aXNza2V5LmNoLjALBgNVHQ8EBAMC
BaAwKwYDVR0QBCQwIoAPMTk5OTAyMTIxNTE5MjdagQ8yMDAxMDIxMjE1MTkwMFowDQYJKoZI
hvcNAQEEBQADgYEAhph9dwEU8qBBqauQt3egz5VqEnuK4d/C2Nz8ZYdKsdOZ5CN6kCxE3G/d
ThLcCxMDoG7LfSq01Nz2CS3fzLYz2PgqsXtBOC1cQ5MRMfh7SYtYtz+TXp10LgHy+muPQ32n
Cb4FEs9rLeGtk4UhkD1Ftu8MFOxZJRPq2vqQkU9+P4kwggJ5MIIB4qADAgECAgEFMA0GCSqG
SIb3DQEBBAUAMG0xCzAJBgNVBAYTAkNIMRQwEgYDVQQKEwtTd2lzc2tleSBBRzEbMBkGA1UE
CxMSUHVibGljIENBIFNlcnZpY2VzMRAwDgYDVQQHEwdadWVyaWNoMRkwFwYDVQQDExBTd2lz
c2tleSBSb290IENBMB4XDTk4MDcwNjEzNDg0OVoXDTA1MTIzMTIzNTkwMFowcDELMAkGA1UE
BhMCQ0gxFDASBgNVBAoTC1N3aXNza2V5IEFHMRswGQYDVQQLExJQdWJsaWMgQ0EgU2Vydmlj
ZXMxEDAOBgNVBAcTB1p1ZXJpY2gxHDAaBgNVBAMTE1N3aXNza2V5IElEIENBIDEwMjQwgZ8w
DQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAKvpH+mt/1OfcXA1bfj4THa090PoGYDdqQrWTmDC
/Uh7Q/ZuvlPQDmLwNSdvLlUi8oJALiFbXX4YFsqHMS4ScUxfkoqrNmGckTi8vZWIv34MSteg
Evn6/w+E+Fdu3q60A/x3z3zlszN5YTFOznAD53PY6BvT6xX/abNMtgmb4e6PAgMBAAGjJjAk
MBIGA1UdEwEB/wQIMAYBAf8CAQAwDgYDVR0PAQH/BAQDAgEGMA0GCSqGSIb3DQEBBAUAA4GB
AA4PZyKq0op7vz1Hqx9ejPMsMj6r00hgobpJ/YEoaiZpg5cpH+iAFJYwK8MYlzts8/Ci1uAw
7/YsOB/AN36eRf1iOGcHJ76BB+kSYOi+a+0UjmEXUpnC/jO3Icpe/m20HrmMVDZCVR5z2YHe
XSWtcjkVr2jpREVVfy4u+W/vRLDgMYIBqTCCAaUCAQEwdjBwMQswCQYDVQQGEwJDSDEUMBIG
A1UEChMLU3dpc3NrZXkgQUcxGzAZBgNVBAsTElB1YmxpYyBDQSBTZXJ2aWNlczEQMA4GA1UE
BxMHWnVlcmljaDEcMBoGA1UEAxMTU3dpc3NrZXkgSUQgQ0EgMTAyNAICAR4wCQYFKw4DAhoF
AKCBijAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wMDAzMDcy
MjIwNDdaMCMGCSqGSIb3DQEJBDEWBBS+dcg0YIMiXqnf5hpWdbH1BCbNGDArBgkqhkiG9w0B
CQ8xHjAcMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBgkqhkiG9w0BAQEFAASBgIKZ
2p65yM/d37G+7JMU4xz4SKH2OfPOwIgoyWakodLdOe8AcIYDFvBwBXDo9rI+RgoOgdf5oXFL
u+3Hg8VWvn0lqFD8alWu9Dfq2Pjww9E4MBOvyY3j1Cn5bRY7fDic3L158C3Avt6NECTWTjcJ
6j9xTrA/r+DoPzQwry672SXY
--------------msACADB76140A5FD2141460307--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
