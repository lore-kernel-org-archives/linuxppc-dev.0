To: nitesh_ppc@lycos.com, linuxppc-embedded@lists.linuxppc.org,
	"Steven Blakeslee" <BlakesleeS@embeddedplanet.com>
Date: Thu, 30 Jan 2003 15:26:54 -0500
From: "Nitesh Goyal" <nitesh_ppc@lycos.com>
Message-ID: <KMFIGHDLLFILEBAA@mailcity.com>
Mime-Version: 1.0
Reply-To: nitesh_ppc@lycos.com
Subject: RE: Howto install bootloader using jtag?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>The first thing you do is create an appropriate config file for the debugger
>and board.  If you go to ftp://ftp.denx.de/pub/BDI2000/ you can get Abatron
>BDI config files for the ep405 board.  You run this script then download the
>pcl____.ep file that is on the documentation CD.
I have downloaded the script(config file) on my host machine (x86). How do I run the script ? If I am right, it has to be run on the board, but the problem is, I can't communicate to the board with serial-port.


>You should be able to download and execute it in one
>simple step.
The problem is I do not know how to download an image from the host to the board because I've overwritten the bootloader.

Also, if I'm right, the JTAG has to be connected to the parallel port of host and the bootloader image needs to be downloaded using "some" utility ?

TIA,
-nitesh


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
