Date: Thu, 26 Oct 2000 09:54:59 -0400
From: Josh Huber <huber@mclx.com>
To: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: lombard ethernet
Message-ID: <20001026095459.A12571@missioncriticallinux.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm having trouble with my Lombard's ethernet.  Every once in a while
it seems to lock up.  bringing the interface down and then up fixes
the problem.

I'm not sure if this is helpful or not. (are the errors normal?)

eth0      Link encap:Ethernet  HWaddr 00:50:E4:A0:40:6F
          inet addr:10.1.8.96  Bcast:10.1.8.255  Mask:255.255.255.0
          UP BROADCAST RUNNING  MTU:1500  Metric:1
          RX packets:122499 errors:16 dropped:15 overruns:0 frame:15
          TX packets:85094 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0

I'm running pump to get dhcp, so I thought it was (perhaps) the
culprit.  I'd experienced this problem with a Wallstreet and I traced
it to dhclient.  However, it's not that easy because killing pump
didn't make the problem go away.

Any thoughts?

--=20
Josh Huber                               | huber@nightshade.org |
1024D/6B21489A 61F0 6138 BE7B FEBF A223  E9D1 BFE1 2065 6B21 489A

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature
Content-Disposition: inline


--Kj7319i9nmIyA2yE--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
