Return-Path: <pbellino@mrv.com>
Received: from mailman.xyplex.com (mailman.xyplex.com [140.179.176.116])
	by ozlabs.org (Postfix) with ESMTP id 621BB67A6F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 18 Apr 2005 23:50:56 +1000 (EST)
Received: from ltnmail.xyplex.com (ltnmail.xyplex.com [140.179.176.25])
	by mailman.xyplex.com (8.9.3+Sun/8.9.3) with ESMTP id JAA27473
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 18 Apr 2005 09:35:49 -0400 (EDT)
Message-ID: <19EE6EC66973A5408FBE4CB7772F6F0A02899377@ltnmail.xyplex.com>
From: "Bellino, Phil" <pbellino@mrv.com>
To: LinuxPPC <linuxppc-embedded@ozlabs.org>
Date: Mon, 18 Apr 2005 09:20:39 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_000_01C54419.6A1BB8C0"
Subject: 2.6.11 kernel, PPC, and IPv6
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C54419.6A1BB8C0
Content-Type: text/plain;
	charset="windows-1252"

Hello,
I do not know if this email is appropriate for this mailing list, but I
thought I would give it a try.

Is there anyone out there who is using(or attempting to use) IPv6 with PPC
and a 2.6.11 kernel with whom I could email directly with some specific
questions?

One of my questions is at boot time, my eth0 device does not have it's
link-local address.  I must issue an "ifconfig eth0 down" and then an
"ifconfig eth0 up" to get this work work.

Also, it does not auto-configure the info for a link-global prefix/address
that is provided by the router announcements.

There are PCs in my network on i686 athlons, i386 running 2.6.5 kernels that
do in fact handle the above IPv6 correctly.

I do understand that there are IPv6 mailing list and I do belong to them,
but thus far no one has been able to assist me in these issues.

I apologize if this is not the correct forum for these types of questions.

Thank you,
Phil Bellino

============================
Phil Bellino
MRV Communications, Inc.
Boston Product Division
295 Foster St.
Littleton,MA 01460
Tel: (978)952-4807
Email: pbellino@mrv.com
============================


------_=_NextPart_000_01C54419.6A1BB8C0
Content-Type: application/ms-tnef
Content-Transfer-Encoding: base64

eJ8+IisNAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQWAAwAOAAAA1QcEABIACQAUACcAAQA3AQEggAMADgAAANUHBAAS
AAkAFAApAAEAOQEBCYABACEAAAAwQTREMTc4MkQ1QUZEOTExQjJGOTAwMDEwMzJCRERFNgAoBwEE
gAEAHQAAADIuNi4xMSBrZXJuZWwsIFBQQywgYW5kIElQdjYA2gcBDYAEAAIAAAACAAIAAQOQBgCE
CAAALAAAAAsAAgABAAAAQAA5AMC4G2oZRMUBHgBwAAEAAAAdAAAAMi42LjExIGtlcm5lbCwgUFBD
LCBhbmQgSVB2NgAAAAACAXEAAQAAABYAAAABxUQbtfuCF00Rr9UR2bL5AAEDK93mAAAeADFAAQAA
AAoAAABQQkVMTElOTzEAAAADABpAAAAAAB4AMEABAAAACgAAAFBCRUxMSU5PMQAAAAMAGUAAAAAA
AgEJEAEAAAD8AwAA+AMAAOMFAABMWkZ1OjIETQMACgByY3BnMTI1FjIA+Atgbg4QMDMzTwH3AqQD
YwIAY2gKwHPwZXQwIAdtAoMAUAPUHxDJBxMCgw5QEtZwcnErFIETXn0KgXYIkHdr6QuAZDQMYGMA
UAsDC7SgNCBIZWwJACwKogEKgEkgZG8gbm8dBUBrGYAH4AaQIHRoOQQAIGUAwAMRGmFhcI0VIG8V
IAcwdGUgAhBPBcAaQxqiC4BnIBygc+B0LCBidQVAGTAaQCkIYGdoHXJ3CGBsZFAgZ2l2G8BpBUBh
8RowcnkuGNQY1QQgGkD3BJAbwABweQIgG8AIYAVAbSCEdx3AGuJ1AJAPICi3BbEboBuwbQUwHLJ0
GWCJImBlKR2AUHY2HkDBHwBoIFBQQyDRHpCBHzAyLjYuMTEZsO8EkRiAJGQh8W0dgQWgHnIJGpRk
aQlwY3Rsec0kZHMDcBvAc3AFkAaQWQ3gIHEKUB0QaQIgc9o/H5pPISIaIG0oMCmH/xrjBUAG4BmR
I1AHgB0wK1HdETBoEVABABbAYxvAGVBvB5EZghDwHtMnBCAcoWuaLQkAYwdAGxBkZAlw6QQQLiAd
gW0iYAVABAGzClAg0SAiBpAFoG4pQOcc0C1kGeBuIiTzIIEDoNsxfyJQcDLQI6FnETAaNJkeUHJr
NZMfi0FsKKCXHTAfAS4nYR1gby0x1P8IcBvAIIEaADHwGWAb4h8wdS9TZwkAYi/RFSABEGn8eC8w
BRoxLFEaYRtBFsD7AQAekGIoMDkSA2AdYASQ8yDRGYB1bi3wB4ACMDBg/R+aVCCUILEk0CwBA6Ar
UZ0hIHQ1owIgGgA2OCRQXRugaAkAAIA3QTNBUXLvPeADABzBJWI1JcU7lRlR3UAhZgDQLpIXIGw4
9AGg/zxQG8AkIwWhJ+QfjBlCPeD/BIEdEDL0LFEghSCxJCMcensk8xkzYhiAAiAjgyCBbf8dNBpA
ImBEYQXAGYBA8RvA/xDwBCBLIDNSAmA48RlgTXD/AJAw4SjBQCEggREgMQQ+bO8ZMBsgCPEesHoe
4RolGmHvGYI5EkYlG9J1JsAb5E9i/HR5KQAEICshKYc+fQBwazXQIQB1GMVQGlADIEI7GIELgG8f
mhKUAdAgPQ9ZT1n4Vt9X5U1SViB9CFBtMMADAC/AKcMdMEljPfAfhmV4cBcgQKAttjUUYVdwbx0Q
QQFQA2D2ZBdgBUBEHsAEACnRGNQ0MjlDIEZfUT1xU3Q9H4VMHwAoEBEwAiAsTcBBIDAxNDYBQF51
DwLRF4M/IRiAOiAoOQg3OClhIDItNDi0MDcY1EUaomTAcEshQVeyQG1ydi4FoG2/GNRZ/1pfF+YY
1BaBAGsgAwDeP+QEAAADAAlZAwAAAAMABoAIIAYAAAAAAMAAAAAAAABGAAAAABCFAAAAAAAAAwAA
gAggBgAAAAAAwAAAAAAAAEYAAAAAUoUAACdqAQAeAAGACCAGAAAAAADAAAAAAAAARgAAAABUhQAA
AQAAAAQAAAA5LjAACwACgAggBgAAAAAAwAAAAAAAAEYAAAAABoUAAAAAAAADAAOACCAGAAAAAADA
AAAAAAAARgAAAAABhQAAAAAAAAsABIAIIAYAAAAAAMAAAAAAAABGAAAAAAOFAAAAAAAACwAFgAgg
BgAAAAAAwAAAAAAAAEYAAAAADoUAAAAAAAADAAeACCAGAAAAAADAAAAAAAAARgAAAAARhQAAAAAA
AAMACIAIIAYAAAAAAMAAAAAAAABGAAAAABiFAAAAAAAAHgAMgAggBgAAAAAAwAAAAAAAAEYAAAAA
NoUAAAEAAAABAAAAAAAAAB4ADYAIIAYAAAAAAMAAAAAAAABGAAAAADeFAAABAAAAAQAAAAAAAAAe
AA6ACCAGAAAAAADAAAAAAAAARgAAAAA4hQAAAQAAAAEAAAAAAAAAAwDxPwkEAAADAP0/5AQAAAMA
JgAAAAAAAwA2AAAAAAADAIAQ/////wIBRwABAAAALwAAAGM9VVM7YT0gO3A9WFlQTkVUO2w9TFRO
TUFJTC0wNTA0MTgxMzIwMzlaLTI3MTMAAB4AOEABAAAACgAAAFBCRUxMSU5PMQAAAB4AOUABAAAA
CgAAAFBCRUxMSU5PMQAAAEAABzDAuBtqGUTFAUAACDCISTBrGUTFAR4APQABAAAAAQAAAAAAAAAe
AB0OAQAAAB0AAAAyLjYuMTEga2VybmVsLCBQUEMsIGFuZCBJUHY2AAAAAB4ANRABAAAAPgAAADwx
OUVFNkVDNjY5NzNBNTQwOEZCRTRDQjc3NzJGNkYwQTAyODk5Mzc3QGx0bm1haWwueHlwbGV4LmNv
bT4AAAALACkAAAAAAAsAIwAAAAAAAwAGELiW75ADAAcQlwMAAAMAEBAAAAAAAwAREAAAAAAeAAgQ
AQAAAGUAAABIRUxMTyxJRE9OT1RLTk9XSUZUSElTRU1BSUxJU0FQUFJPUFJJQVRFRk9SVEhJU01B
SUxJTkdMSVNULEJVVElUSE9VR0hUSVdPVUxER0lWRUlUQVRSWUlTVEhFUkVBTllPTkVPAAAAAAIB
fwABAAAAPgAAADwxOUVFNkVDNjY5NzNBNTQwOEZCRTRDQjc3NzJGNkYwQTAyODk5Mzc3QGx0bm1h
aWwueHlwbGV4LmNvbT4AAAAM7g==

------_=_NextPart_000_01C54419.6A1BB8C0--
