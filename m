Date: Mon, 1 Nov 1999 02:02:55 -0600 (EST)
From: "Jon A. Christopher" <jon@amanda.tamu.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: bug in getenv/putenv on linuxppc/G4
Message-ID: <Pine.LNX.4.04.9911010157580.7854-200000@amanda.tamu.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1537555251-1088477086-941443375=:7854"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1537555251-1088477086-941443375=:7854
Content-Type: TEXT/PLAIN; charset=US-ASCII

I've just discovered a bug in either getenv (probably) or putenv (less
likely) on linuxppc on a G4, glibc-2.1.1-6c.

The attached test program demonstrates the bug.  Basically, using putenv
to add a variable to the environment whose name is only one letter long
and then using getenv to read it doesn't work.  

Variables with two or more letters are processed as normal.

I'm not sure if this is a glibc or a linuxppc problem, but I don't have
teh same problem on my intel RH 5.2 box, or any other unix I've ever heard
of.

-jon

Please CC replies to me, since I'm not on this list.

-- 
Dr. Jon A. Christopher              / jac8792@tamu.edu |  Project URLs:
Department of Biochem./Biophys.    /  spock: http://quorum.tamu.edu/spock
Texas A&M University MS-2128      / lesstif: http://www.lesstif.org/
College Station, TX, 77843       / personal: http://quorum.tamu.edu/jon


--1537555251-1088477086-941443375=:7854
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="getput.c"
Content-ID: <Pine.LNX.4.04.9911010202550.7854@amanda.tamu.edu>
Content-Description: 
Content-Disposition: attachment; filename="getput.c"
Content-Transfer-Encoding: BASE64

I2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c3RkbGliLmg+DQoNCm1h
aW4oKQ0Kew0KICAvKiBkb2Vzbid0IHdvcmsgb24gcHBjLCBidXQgc2hvdWxk
ICovDQogIHB1dGVudigiaT0xIik7DQogIHByaW50ZigiZ290OiBpPSVzXG4i
LGdldGVudigiaSIpKTsNCg0KICAvKiB3b3JrcyBvbiBwcGMgKi8NCiAgcHV0
ZW52KCJpaT0xIik7DQogIHByaW50ZigiZ290OiBpaT0lc1xuIixnZXRlbnYo
ImlpIikpOw0KfQ0K
--1537555251-1088477086-941443375=:7854--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
