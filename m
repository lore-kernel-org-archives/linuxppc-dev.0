Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: "Narayanan, Ganesh" <ganesh.narayanan@netapp.com>
Subject: Re: AMD to ST migration issues 
In-reply-to: <7619F3097FAB384287CF636FF92D0CA109943577@exsvl01.hq.netapp.com> 
References: <7619F3097FAB384287CF636FF92D0CA109943577@exsvl01.hq.netapp.com>
Date: Wed, 30 May 2007 10:57:01 +1000
Message-ID: <22246.1180486621@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> We have been using PPC with a AMD flash (Spansion S29GL128M) on it for
> our applications.  We are running Montavista linux on it.  Recently we
> replaced the AMD flash with ST flash (M29W128FH).  The u-boot boots up
> and during the kernel boot, I am getting the following error messages
> and the system doesn't boot after this:
> =20
> 
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000000:
> 0x0020 instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000001c:
> 0x2212 instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000020:
> 0x0020 instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000003c:
> 0x2212 instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000040:
> 0x0020 instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000005c:
> 0x2212 instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000060:
> 0x0020 instead
> =20
> It would be really great if someone could let me know what is going
> wrong in this.

This might be better answered at the jffs2 list which is linked off
here:  http://sourceware.org/jffs2/ 

Mikey
