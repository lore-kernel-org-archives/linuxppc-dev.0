Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound6-wa4-R.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id EA662DDF9E
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 06:22:12 +1000 (EST)
Message-ID: <482C9B6F.1020907@am.sony.com>
Date: Thu, 15 May 2008 13:22:07 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: Re: Convert remaining dts-v0 files to v1
References: <20080515064639.GB30996@yookeroo.seuss>
In-Reply-To: <20080515064639.GB30996@yookeroo.seuss>
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> At the moment we have a mixture of left-over version 0 and new-format
> version 1 files in arch/powerpc/boot/dts.  This is potentially
> confusing to people new to the dts format attempting to figure it out.p
> 
> So, this patch converts all the as-yet unconverted dts v0 files and
> converts them to v1.  They're mechanically-converted, and not hand
> tweaked so in some cases they're not 100% in keeping with usual v1
> style, but the convertor program does have some heuristics so the
> discrepancies aren't too bad.
> 
> I have checked that this patch produces no changes to the resulting
> dtb binaries.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> 
...
> Index: working-2.6/arch/powerpc/boot/dts/ps3.dts
> ===================================================================
> --- working-2.6.orig/arch/powerpc/boot/dts/ps3.dts	2008-05-15 16:32:08.000000000 +1000
> +++ working-2.6/arch/powerpc/boot/dts/ps3.dts	2008-05-15 16:32:08.000000000 +1000

I tested this on PS3 and it seems to work OK.

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
