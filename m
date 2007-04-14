Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 7329BDDE1A
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 15 Apr 2007 05:01:52 +1000 (EST)
Date: Sat, 14 Apr 2007 21:01:49 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Clint Thomas <cthomas@Soneticom.com>
Subject: RE: Linux 2.6 and uboot
In-Reply-To: <3C02138692C13C4BB675FE7EA24095293284E0@bluefin.Soneticom.local>
Message-ID: <Pine.LNX.4.60.0704142053560.5114@poirot.grange>
References: <3C02138692C13C4BB675FE7EA24095293284E0@bluefin.Soneticom.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 13 Apr 2007, Clint Thomas wrote:

> mice: PS/2 mouse device common for all mice
> i2c /dev entries driver
> TCP cubic registered
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> 
> This is the point where it stops booting.

It might be just the point before root is mounted... That's what I'd check 
anyway... I see it has 2 eth interfaces. Can it be that their order has 
changed and it's trying the wrong one?

Thanks
Guennadi
---
Guennadi Liakhovetski
