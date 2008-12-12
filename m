Return-Path: <linuxuser330250@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 908F3DE0D4
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Dec 2008 03:52:27 +1100 (EST)
From: Linux User #330250 <linuxuser330250@gmx.net>
To: "linuxppc-dev list" <linuxppc-dev@ozlabs.org>
Subject: PowerMac3,6 (G4 MDD): X.org radeon + DVI panel = red flickering
Date: Fri, 12 Dec 2008 17:52:22 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200812121752.22746.linuxuser330250@gmx.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi!

Reading of "powerbook VT garbled between rc7 and rc8" by  
Johannes Berg reminded me of my own graphics problem with the X.org radeon 
driver when connected to a TFT panel using the DVI connector.

The symtom: after initial X video initialization the screen flickers red. This 
red flickering goes away once I reset the screen (my way is to change the 
resolution twice). After that the screen looks perfect.
It reapears after switching back to X from a text console of another X 
session. (same workaround fixes the red flickering)

I filed a bug at bugs.freedesktop.org a month ago, but no answer yet.
https://bugs.freedesktop.org/show_bug.cgi?id=18554

There is no problem when connecting the digital TFT panel via a DVI-to-VGA 
adapter on the Radeon 9000 AGP graphics card with the VGA connected of the 
panel, but then the picture is a bit blur, which doesn't look nice compared 
to the 100% sharp picture I get with DVI.

The problem seems the have come up with a new radeon driver starting in X.org 
7 series, (according to Giuliano Pochini) it worked with X.org 6.8.2, and did 
flicker red in X.org 7.1.1.
The radeon driver that seems not to be affected is video-ati 6.6.3.
See my bug report at freedesktop.org and 
http://lists.freedesktop.org/archives/xorg/2007-January/020641.html

Unfortunately I cannot use 6.6.3 with X.org 7.4 as it fails to compile.

My question, since this problem is present for some years now:
Does none of the Apple PowerMac G4 devs have this problem with DVI?

If not, do any of you have an idea what could cause this problem and how to 
fix it?

Thanks,
Andreas  aka  Linux User #330250
