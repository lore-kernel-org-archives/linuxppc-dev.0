From: hagopiar@vuser.vu.union.edu
Date: Mon, 7 Dec 1998 23:28:30 -0500 (EST)
To: Ralf Weidemann <RalfW@Scalar.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: EGCS 1.1.1 FYI 
In-Reply-To: <13932.21810.162591.80793@onyx.nowhere.net>
Message-ID: <Pine.LNX.4.05.9812072324540.2601-200000@sequoia.hagopian.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="133632-692083590-913091310=:2601"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--133632-692083590-913091310=:2601
Content-Type: TEXT/PLAIN; charset=US-ASCII

FYI, I get the same problem with glibc-2.0.104... I have an strace, last
50 lines are attached... No time to do anything anymore... <sigh>
								-Rob

On Mon, 7 Dec 1998, Ralf Weidemann wrote:

> Date: Mon, 7 Dec 1998 23:22:42 +0100 (CET)
> From: Ralf Weidemann <RalfW@Scalar.de>
> To: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
> Subject: Re: EGCS 1.1.1 FYI 
> 
> 
> >>>>> "David" == David Edelsohn <dje@watson.ibm.com> writes:
> >>>>> "Paul J Schinder" writes:
>     Paul> So are Gary Thomas' patches still necessary?
> 
>     David> 	The trampoline patch now has become a shared library
>     David> compatibility issue for glibc-1.99 support.  It only is
>     David> necessary until LinuxPPC cuts over to glibc-2.1 which will
>     David> require other binary incompatible changes at the same time.
> 
> Can someone clarify where the problem is exact with native
> egcs and libc-1.99 ? I use egcs-1.1.1 since the weekend and
> it seems to work fine. I had no trouble to build some shared
> lib stuff like in the latest jade or sgml-tools. This packages
> didn't compile with older version I tried (also Gary's egcs-1.1b),
> but that were generell compiler issues, I think.
> 
> But on the other side I also tried to run the SeaMonkeyBrowser
> (Mozilla) from recent cvs-sources. Building went fine, but the
> beast didn't run. I get only a simple "Aborted" message on the
> console and it seems to crash somewhere in the startup code.
> So maybe this is somehow related ?
> 
> Had someone luck to run a recent version of Mozilla at all on
> LinuxPPC ?
> 
> Thanks,
> Ralf
> 
> 
> 
> 

--133632-692083590-913091310=:2601
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=seamonkeytrace
Content-ID: <Pine.LNX.4.05.9812072328300.2601@sequoia.hagopian.net>
Content-Description: 
Content-Disposition: attachment; filename=seamonkeytrace
Content-Transfer-Encoding: BASE64

ZmNudGwoNCwgRl9TRVRGTCwgT19SRE9OTFl8T19OT05CTE9DSykgID0gMA0K
ZmNudGwoNSwgRl9HRVRGTCkgICAgICAgICAgICAgICAgICAgICAgID0gMHgx
IChmbGFncyBPX1dST05MWSkNCmZjbnRsKDUsIEZfU0VURkwsIE9fV1JPTkxZ
fE9fTk9OQkxPQ0spICA9IDANCmJyaygwKSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICA9IDB4MTg3NzAwMA0KYnJrKDB4MTg3ODAwMCkgICAg
ICAgICAgICAgICAgICAgICAgICAgID0gMHgxODc4MDAwDQpTWVNfMTczKDB4
ZCwgMHg3ZmZmZTQwOCwgMCwgMHg4LCAweDIwKSAgPSAwDQpTWVNfMTczKDB4
ZSwgMHg3ZmZmZTQwOCwgMCwgMHg4LCAweDIwKSAgPSAwDQpvcGVuKCIvcm9v
dC8ubW96aWxsYS9jb29raWVzIiwgT19SRE9OTFkpID0gLTEgRU5PRU5UIChO
byBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5KQ0Kc3RhdCgiL3Jvb3QvLm1vemls
bGEvaW5kZXguZGIiLCAweDdmZmZmMjk4KSA9IC0xIEVOT0VOVCAoTm8gc3Vj
aCBmaWxlIG9yIGRpcmVjdG9yeSkNCnN0YXQoIi9yb290Ly5tb3ppbGxhL2lu
ZGV4LmRiIiwgMHg3ZmZmZjI5OCkgPSAtMSBFTk9FTlQgKE5vIHN1Y2ggZmls
ZSBvciBkaXJlY3RvcnkpDQpicmsoMCkgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgPSAweDE4NzgwMDANCmJyaygweDE4NzkwMDApICAgICAg
ICAgICAgICAgICAgICAgICAgICA9IDB4MTg3OTAwMA0KYnJrKDApICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgID0gMHgxODc5MDAwDQpicmso
MHgxODdhMDAwKSAgICAgICAgICAgICAgICAgICAgICAgICAgPSAweDE4N2Ew
MDANCmJyaygwKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA9
IDB4MTg3YTAwMA0KYnJrKDB4MTg3YjAwMCkgICAgICAgICAgICAgICAgICAg
ICAgICAgID0gMHgxODdiMDAwDQpicmsoMCkgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgPSAweDE4N2IwMDANCmJyaygweDE4N2MwMDApICAg
ICAgICAgICAgICAgICAgICAgICAgICA9IDB4MTg3YzAwMA0KYnJrKDApICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID0gMHgxODdjMDAwDQpi
cmsoMHgxODdkMDAwKSAgICAgICAgICAgICAgICAgICAgICAgICAgPSAweDE4
N2QwMDANCmJyaygwKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICA9IDB4MTg3ZDAwMA0KYnJrKDB4MTg3ZTAwMCkgICAgICAgICAgICAgICAg
ICAgICAgICAgID0gMHgxODdlMDAwDQpicmsoMCkgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgPSAweDE4N2UwMDANCmJyaygweDE4N2YwMDAp
ICAgICAgICAgICAgICAgICAgICAgICAgICA9IDB4MTg3ZjAwMA0KYnJrKDAp
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID0gMHgxODdmMDAw
DQpicmsoMHgxODgwMDAwKSAgICAgICAgICAgICAgICAgICAgICAgICAgPSAw
eDE4ODAwMDANCmJyaygwKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICA9IDB4MTg4MDAwMA0KYnJrKDB4MTg4MTAwMCkgICAgICAgICAgICAg
ICAgICAgICAgICAgID0gMHgxODgxMDAwDQpicmsoMCkgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgPSAweDE4ODEwMDANCmJyaygweDE4ODIw
MDApICAgICAgICAgICAgICAgICAgICAgICAgICA9IDB4MTg4MjAwMA0KYnJr
KDApICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID0gMHgxODgy
MDAwDQpicmsoMHgxODgzMDAwKSAgICAgICAgICAgICAgICAgICAgICAgICAg
PSAweDE4ODMwMDANCmJyaygwKSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICA9IDB4MTg4MzAwMA0KYnJrKDB4MTg4NDAwMCkgICAgICAgICAg
ICAgICAgICAgICAgICAgID0gMHgxODg0MDAwDQpicmsoMCkgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgPSAweDE4ODQwMDANCmJyaygweDE4
ODUwMDApICAgICAgICAgICAgICAgICAgICAgICAgICA9IDB4MTg4NTAwMA0K
YnJrKDApICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID0gMHgx
ODg1MDAwDQpicmsoMHgxODg2MDAwKSAgICAgICAgICAgICAgICAgICAgICAg
ICAgPSAweDE4ODYwMDANCmJyaygwKSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICA9IDB4MTg4NjAwMA0KYnJrKDB4MTg4NzAwMCkgICAgICAg
ICAgICAgICAgICAgICAgICAgID0gMHgxODg3MDAwDQpicmsoMCkgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAweDE4ODcwMDANCmJyaygw
eDE4ODgwMDApICAgICAgICAgICAgICAgICAgICAgICAgICA9IDB4MTg4ODAw
MA0KYnJrKDApICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID0g
MHgxODg4MDAwDQpicmsoMHgxODg5MDAwKSAgICAgICAgICAgICAgICAgICAg
ICAgICAgPSAweDE4ODkwMDANCmJyaygwKSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICA9IDB4MTg4OTAwMA0KYnJrKDB4MTg4YTAwMCkgICAg
ICAgICAgICAgICAgICAgICAgICAgID0gMHgxODhhMDAwDQpicmsoMCkgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAweDE4OGEwMDANCmJy
aygweDE4OGIwMDApICAgICAgICAgICAgICAgICAgICAgICAgICA9IDB4MTg4
YjAwMA0KLS0tIFNJR1NFR1YgKFNlZ21lbnRhdGlvbiBmYXVsdCkgLS0tDQor
Kysga2lsbGVkIGJ5IFNJR1NFR1YgKysrDQo=
--133632-692083590-913091310=:2601--

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
