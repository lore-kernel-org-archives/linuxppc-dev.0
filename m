Message-ID: <3A76769B.87242FAA@valinux.com>
Date: Tue, 30 Jan 2001 19:08:59 +1100
From: Gareth Hughes <gareth@valinux.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@linuxcare.com.au>,
        "Michel
	Ddnzer" <daenzerm@student.ethz.ch>,
        Bernd Kreimeier
	<bk@lokigames.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: r128 DRI driver now fully functional on PPC
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've just committed the last of the updates required to get full hardware
accelerated 3D rendering with the ATI Rage 128 on PowerPC.  Many thanks to Paul
Mackerras for allowing me to hack away on his machine over the last week!

The code is available on the ati-pcigart-0-0-1-branch in the DRI CVS
repository.  Please feel free to check it out and report any problems you have.

Now all we need is a PPC Linux build of Q3A...

-- Gareth

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
