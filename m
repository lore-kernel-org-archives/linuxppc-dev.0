Return-Path: <dgibson@ozlabs.org>
Date: Thu, 15 Feb 2007 11:53:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v3] powerpc: delete boot-cpu property from all DTS files
Message-ID: <20070215005323.GK16279@localhost.localdomain>
References: <11714885473600-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11714885473600-git-send-email-timur@freescale.com>
Cc: Stuart Yoder <stuart.yoder@freescale.com>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, g.liakhovetski@gmx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 14, 2007 at 03:29:07PM -0600, Timur Tabi wrote:
> The 'linux,boot-cpu' property is obsolete, so remove it from all of the DTS
> files and from booting-without-of.txt.  The boot CPU is actually defined in
> the device tree header, and U-Boot sets that field.  The device tree compiler
> also complains if the property exists.

This looks sane to me.  If you're going about this sort of dts
cleanup, it would be nice to remove all the linux,phandle properties
and use dtc's reference facility to auto-generate them instead.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
