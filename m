Date: Fri, 9 Jul 1999 02:34:22 -0600 (MDT)
From: Dan Burcaw <dburcaw@terraplex.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: QuickTime Streaming Server for Linux.. on x86
In-Reply-To: <Pine.LNX.3.96.990708145504.17464B-100000@newhope.terraplex.com>
Message-ID: <Pine.LNX.3.96.990709020727.21556D-200000@newhope.terraplex.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1228814547-1005911288-931509262=:21556"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1228814547-1005911288-931509262=:21556
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hey all,

I just tweaked the Streaming Server to work on PPC Linux and I have a
patch available. I haven't tested an actual streaming of audio or video to
see how well it works but at least this will let you build the server
which is a good first step. 

The good news is that all it took was very little modification of the
source to make it work.

The patch is attached to this email and is called
"StreamingServer-2-ppclinux.patch". 


Regards,
Dan

Terra Soft Solutions, Inc.
 email: dburcaw@yellowdoglinux.com
 website: http://www.yellowdoglinux.com/


---1228814547-1005911288-931509262=:21556
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="StreamingServer-2-ppclinux.patch"
Content-ID: <Pine.LNX.3.96.990709023422.21556E@newhope.terraplex.com>
Content-Description: 
Content-Transfer-Encoding: BASE64

LS0tIFN0cmVhbWluZ1NlcnZlci0yL1JoYXBTZXJ2ZXIvbWFpbi5jcHAubwlG
cmkgSnVsICA5IDAxOjE1OjE4IDE5OTkNCisrKyBTdHJlYW1pbmdTZXJ2ZXIt
Mi9SaGFwU2VydmVyL21haW4uY3BwCUZyaSBKdWwgIDkgMDE6MzY6MDcgMTk5
OQ0KQEAgLTkzLDcgKzkzLDcgQEANCiAJLy8odm9pZCkgOjpzaWduYWwoU0lH
UElQRSwgU0lHX0lHTik7DQogCXN0cnVjdCBzaWdhY3Rpb24gYWN0Ow0KIAkN
Ci0jaWYgZGVmaW5lZChzdW4pIHx8IGRlZmluZWQoaTM4NikNCisjaWYgZGVm
aW5lZChzdW4pIHx8IGRlZmluZWQoaTM4NikgfHwgZGVmaW5lZChwb3dlcnBj
KQ0KIAlzaWdlbXB0eXNldCgmYWN0LnNhX21hc2spOw0KIAlhY3Quc2FfZmxh
Z3MgPSAwOw0KIAlhY3Quc2FfaGFuZGxlciA9ICh2b2lkKCopKGludCkpJnNp
Z2NhdGNoZXI7DQotLS0gU3RyZWFtaW5nU2VydmVyLTIvUmhhcFNlcnZlci9V
RFBTb2NrZXQuY3BwLm8JRnJpIEp1bCAgOSAwMjowNTo0OCAxOTk5DQorKysg
U3RyZWFtaW5nU2VydmVyLTIvUmhhcFNlcnZlci9VRFBTb2NrZXQuY3BwCUZy
aSBKdWwgIDkgMDI6MDc6NDEgMTk5OQ0KQEAgLTQwLDcgKzQwLDExIEBADQog
I2VuZGlmDQogDQogI2lmIF9fbGludXhfXw0KKyNpZiBfX0dMSUJDX18gPj0g
Mg0KKyNpbmNsdWRlIDxiaXRzL3NvY2tldC5oPg0KKyNlbHNlDQogI2luY2x1
ZGUgPHNvY2tldGJpdHMuaD4NCisjZW5kaWYNCiAjZW5kaWYNCiAjaW5jbHVk
ZSAiVURQU29ja2V0LmgiDQogI2luY2x1ZGUgIk9TLmgiDQo=
---1228814547-1005911288-931509262=:21556--

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
