Return-Path: <jaka@activetools.si>
From: Jaka =?iso-8859-2?Q?Mo=E8nik?= <jaka@activetools.si>
To: Embedded PPC Linux Mailing List <Linuxppc-embedded@ozlabs.org>
Content-Type: text/plain
Date: Fri, 04 Mar 2005 16:53:13 +0100
Message-Id: <1109951593.32294.5.camel@x.at.lan>
Mime-Version: 1.0
Subject: U-Boot hangs in relocate_code after sw reboot
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

I don't really know if this mailing list is the proper place to direct
questions regarding U-Boot, but I've seen some preceding posts about it,
so I thought I'd ask...

I've ported U-Boot over to a custom MPC8560 (PQ3) based board - it works
well, except that after a sw reboot (from linux kernel or u-boot
itself), it only gets to the part where it relocates itself to RAM and
then hangs - the last debug output is 

Relocating code to 07fd4000...

and the famous

Now running in RAM - U-Boot at: 07fd4000 never shows up.

has anyone experienced similar problems? any hints on what to look at?

regards,
	jaKa

-- 

w3: http://fish.homeunix.org/people/jaka
email: jaka@activetools.si
