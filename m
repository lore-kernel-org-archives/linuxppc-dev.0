Date: Tue, 11 May 1999 17:03:28 +0200 (MET DST)
From: David De Ridder <s970707@uia.ua.ac.be>
Reply-To: David De Ridder <david.de.ridder@bitsmart.com>
To: Simone Piccardi <Simone.Piccardi@fi.infn.it>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MVME2431: how to use vme?
In-Reply-To: <3736E2EE.4C26B58B@fi.infn.it>
Message-ID: <Pine.SO4.4.05.9905111658130.18026-200000@hsins.uia.ac.be>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-450928277-926435008=:25370"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-450928277-926435008=:25370
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 10 May 1999, Simone Piccardi wrote:

> I can also load the universe module without problems (at least it gave
> me the message: Universe VME bridge #1 found at bus=0, dev=13 that seems
> OK).

 OK.

> Now the problem is to test VME (to be precise the real problem is that
> this is my first experience with VME, so have no idea from where to
> start).
> I read the README.universe in the kernel source, and I tried also to use
> the program vmetest.c that I found in the same directory of the kernel
> patches.

> The problem is that that program cannot compile, it start with an error:
> testvme.c:43:  'VME_attr' undeclared ....
> and then gave a lot of other errors. I suppose that this depends on some
> version mismatch (I'm using kernel 2.2.6, with related patch). 

 OK, Gabriel is currently unreachable for two weeks (correct me if
 I'm wrong). So here's some advice to all VME testers : take the
 testvme.c program from Gabriel's website - make sure you have
 a patched 2.2.6 kernel -, strip the program from everything you
 think you don't need. The problem is : use ``window'' instead
 of ``attr''. I think Gabriel was using different (newer? older?)
 include files, because this solves the problem.

 You can start from my own stripped-down version (in attachment).

 Regards,

+-----------------------------------------------------------------+
   David 'Septimus' De Ridder     <david.de.ridder@bitsmart.com>

"Watching eyes wait for sadness to rise,
 true superstitions combine and thicken
 this poison that reaches my soul,
 this terror that blackens my soul."
 - Anne Clark
+-----------------------------------------------------------------+


---559023410-450928277-926435008=:25370
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="vme.c"
Content-ID: <Pine.SO4.4.05.9905111703280.25370@hsins.uia.ac.be>
Content-Description: 
Content-Disposition: attachment; filename="vme.c"
Content-Transfer-Encoding: BASE64

I2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c3lzL3R5cGVzLmg+DQoj
aW5jbHVkZSA8dW5pc3RkLmg+DQojaW5jbHVkZSA8ZmNudGwuaD4NCiNpbmNs
dWRlIDxzeXMvaW9jdGwuaD4NCiNpbmNsdWRlIDxsaW51eC92bWUuaD4NCiNp
bmNsdWRlIDxlcnJuby5oPg0KI2luY2x1ZGUgPHN5cy9tbWFuLmg+DQoNCiNk
ZWZpbmUgUEFUVEVSTiAweDU1DQoNCiNkZWZpbmUgTUJVRlNJWkUgKDE8PDIw
KQ0KLyoNCnN0YXRpYyBjaGFyIG1lbW9yeW1hcFtNQlVGU0laRV07DQoqLw0K
DQppbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQ0Kew0KCXVfY2hh
ciAqbXA7DQogIAlpbnQgZmQ7DQoJaW50IGVycm9yOw0KCWludCBpLCBqOw0K
CVZNRV93aW5kb3cgbWVtZGVzYyA9IHtiYXNlOiAgMHhkMDAwMDAsIA0KCQkJ
ICAgICAgbGltaXQ6IDB4ZGZmZmZmLA0KCQkJICAgICAgZmxhZ3M6IFZNRV9B
TV9BMjQoMTYpIHwgVk1FX1VTRV9NQVAgfCBWTUVfVVNFX1JNVw0KCX07DQoJ
Vk1FX2F0b21pY19hY2Nlc3Mgcm13ID0ge29mZnNldDogMCwNCgl9Ow0KDQoN
CgkvKiBPcGVuIHRoZSBWTUUgZGV2aWNlIDogKi8NCglmZCA9IG9wZW4oIi9k
ZXYvdm1lIixPX1JEV1IpOw0KCWlmIChmZDwwKSANCgl7DQoJCXBlcnJvcigi
ZXJyb3Igb3BlbmluZyB2bWUiKTsgDQoJCWV4aXQoMCk7DQoJfQ0KDQoJcHJp
bnRmKCIvZGV2L3ZtZSBvcGVuZWQuXG4iKTsNCg0KCWVycm9yID0gaW9jdGwo
ZmQsIFZNRV9TRVRfV0lORE9XLCAmbWVtZGVzYyk7DQoJaWYgKGVycm9yKQ0K
CSBwZXJyb3IoIkZhaWxlZCBWTUVfU0VUX1dJTkRPVyIpOw0KDQoJZXJyb3Ig
PSBpb2N0bChmZCwgVk1FX0dFVF9XSU5ET1csICZtZW1kZXNjKTsNCglpZiAo
ZXJyb3IpIA0KCSBwZXJyb3IoIkZhaWxlZCBWTUVfR0VUX1dJTkRPVyIpOw0K
DQoJcHJpbnRmKCJtZW1kZXNjOiBmbGFncyAleCwgdm1lX2FkZHIgJXgsIGxl
bmd0aCAlZFxuIiwgbWVtZGVzYy5mbGFncywNCgkgICAgICAgbWVtZGVzYy5i
YXNlLCBtZW1kZXNjLmxpbWl0LW1lbWRlc2MuYmFzZSsxKTsNCg0KCW1wID0g
bW1hcCgwLCBNQlVGU0laRSwgUFJPVF9SRUFEfFBST1RfV1JJVEUsIE1BUF9T
SEFSRUQsIGZkLCAwKTsgDQoJaWYgKCh1X2xvbmcpbXAgPT0gLTEpIA0KCSBw
ZXJyb3IoIk1tYXAgZmFpbGVkIHdpdGgiKTsNCgllbHNlIA0KIAkgcHJpbnRm
KCJtZW0gbWFwcGVkIGF0ICVwXG4iLCBtcCk7DQoNCgljbG9zZShmZCk7DQoN
CglyZXR1cm4gMDsNCn0NCg0KDQoNCg0KDQoNCg0KDQo=
---559023410-450928277-926435008=:25370--

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
