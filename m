Return-Path: <jaka@activetools.si>
From: Jaka =?iso-8859-2?Q?Mo=E8nik?= <jaka@activetools.si>
To: Embedded PPC Linux Mailing List <Linuxppc-embedded@ozlabs.org>
Content-Type: text/plain
Date: Thu, 03 Mar 2005 10:31:22 +0100
Message-Id: <1109842283.29455.9.camel@x.at.lan>
Mime-Version: 1.0
Subject: BCM5421 PHY on TSEC on MPC8560
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hello!

I am currently attempting to boot linux (kernel 2.6.11) on an
MPC8560-based board: I have successfully fixed U-Boot to work and am now
attempting to get the kernel up - I have managed to get as far as I can
without mounting the root fs, adding a few fixes on the way. I attempt
to mount root fs via NFS and this is where I've been stuck for a few
days (I used 2.6.10 before, I just ported my board-specific changes over
to 2.6.11, hence the "few days").

I have a BroadCom BCM5421 PHY attached to MPC8560 TSEC. I have added
support for its aux status register and its initialization (via another
phy_info entry) to gianfar_phy.c and configured the kernel with Gianfar
driver without NAPI support. It seems that the link is established OK
(at least the switch that the board is connected to suggests so) and the
gfar_transmit() gets called, signalling that the buffers are being sent.
however, no packets seem to be thrown on the wire (nothing ever gets to
the other side).

Ethernet works perfectly in U-Boot. I have also compared the code and it
seems - apart from the architectural differences between U-Boot and
Linux kernel - that U-Boot does roughly the same thing as the kernel
does.

If anyone has any idea or hint whatsoever about what I could look into,
I'd appreciate it very much. Thanks!

regards,
        jaKa

-- 

w3: http://fish.homeunix.org/people/jaka
email: jaka@activetools.si
