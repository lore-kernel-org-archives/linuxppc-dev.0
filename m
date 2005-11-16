Return-Path: <roto@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id D8E0F68724
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2005 05:09:34 +1100 (EST)
Date: Wed, 16 Nov 2005 19:09:26 +0100
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20051116180925.GB3080@localhost>
References: <1130999620.4680.28.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1130999620.4680.28.camel@gaston>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: 2.6.14 USB vs. sleep issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 03, 2005 at 05:33:39PM +1100, Benjamin Herrenschmidt wrote:
> For those who experience crashes on sleep and/or wakeup (typically due
> to USB) with 2.6.14, I made a test patch that might help. [ ... ]

Ben, I just compiled and installed a 2.6.14.1 from kernel.org with
none of your patches from this thread applied to it, and I have no
sleep/wakeup probs with it so far: about 3 instances of sleep/wakeup
until now, all of them successful.

Maybe I even made it a bit more complicated for the system, as I
connected a USB HUB, with 4 ports, to the machine: It just seems to
work ...

-------------------------------------
$ cat /proc/cpuinfo 
processor       : 0
cpu             : 7455, altivec supported
clock           : 867MHz
revision        : 0.2 (pvr 8001 0302)
bogomips        : 865.18
machine         : PowerBook3,5
motherboard     : PowerBook3,5 MacRISC2 MacRISC Power Macintosh
detected as     : 80 (PowerBook Titanium IV)
pmac flags      : 0000001b
L2 cache        : 256K unified
memory          : 768MB
pmac-generation : NewWorld
-----------------------------------

HTH

Best Regards
Wolfgang

-- 
Wolfgang Pfeiffer
http://profiles.yahoo.com/wolfgangpfeiffer

Key ID: E3037113
Key fingerprint = A8CA 9D8C 54C4 4CC1 0B26  AA3C 9108 FB42 E303 7113
