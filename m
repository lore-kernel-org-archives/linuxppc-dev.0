Date: Thu, 1 Nov 2001 23:24:13 +0100 (CET)
From: Jonas Smedegaard <dr@jones.dk>
Reply-To: Jonas Smedegaard <js@debian.org>
To: <debian@jones.dk>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	<debian-powerpc@lists.debian.org>
Subject: IrDA-patched binaries
Message-ID: <Pine.LNX.4.33.0111012312360.888-100000@auryn.jones.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Hi all,

I have made available kernel and irda-packages with the irda-hacks added
to make .

Also, according to BenH the IDE tweaks should be alright now (but who
knows what other "features" have been thrown into this bleeding edge
kernel as well ;-)

Haven't had time to test myself, bu they are at
http://debian.jones.dk/auryn/ as usual:

deb http://debian.jones.dk sid misc tibook

Remember to also lower the speed as described in the mail-thread
(http://lists.linuxppc.org/linuxppc-dev/200110/msg00168.html):

> 3) When applying 1) and 2), IRCOMM works provided that
> /proc/sys/net/irda/max_baud_rate is clamped to 57600.

 - Jonas

P.S.

Please Cc me or debian@jones.dk - I am not on other lists I am
crossposting

- --
Jonas Smedegaard (+45 40843136)          http://dr.jones.dk/~jonas/
Spiff ApS (= IT-guide dr. Jones ApS)     http://dr.jones.dk/
Debian GNU/Linux developer               http://people.debian.org/~js/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
