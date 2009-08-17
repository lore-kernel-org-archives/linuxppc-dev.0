Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1E392B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Aug 2009 01:14:23 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7HFDJlM031522
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2009 11:13:19 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7HFEFbu244870
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2009 11:14:16 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7HFBJVG024761
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2009 11:11:22 -0400
Date: Mon, 17 Aug 2009 11:13:59 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Solomon Peachy <solomon@linux-wlan.com>
Subject: Re: [PATCH] Add support for the ESTeem 195E (PPC405EP) SBC
Message-ID: <20090817151359.GC8710@zod.rchland.ibm.com>
References: <1248448916-29473-1-git-send-email-solomon@linux-wlan.com>
	<20090730140630.GD10244@zod.rchland.ibm.com>
	<20090730194506.GA30066@linux-wlan.com>
	<20090730200848.GF10244@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090730200848.GF10244@zod.rchland.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 30, 2009 at 04:08:49PM -0400, Josh Boyer wrote:
>>> Ok.  So I'm not really all that thrilled with changes to ppcboot.h.  
>>> We try to keep this file as much in-sync with U-Boot as we can.  Did 
>>> your HOTFOOT changes get pulled into upstream U-Boot?
>>
>>Yeah, I thought this may be a problem, but I didn't know a better way to 
>>go about this and still maintain compatibility with the many thousands 
>>of boards already in the field.  I mean, I could strip out the ppcboot.h 
>>changes and maintain that as an out-of-tree patch, but without that 
>>patch, the kernel won't boot on in-the-field boards, rendering the 
>>upstreaming of support for this board kinda pointless.
>>
>>I haven't tried to push anything to upstream u-boot, given how ancient 
>>the in-production bootloader is.  The guy who originally mangled u-boot 
>>for this board did so before the "standard" 405EP dual ethernet layout 
>>was added, and never tried to push it upstream.  Any upstream uboot work 
>>will take the form of a native dts/fdt port that probably won't use 
>>ppcboot.h anyway, which brings us full circle...
>
>There is another way.  Perhaps you could just copy ppcboot.h to a new file
>called "hotfoot.h" and just use that.  It's a duplication of ppcboot.h to
>some degree, but it seems to make sense for your board and it helps preserve
>the "stock" ppcboot.h for other boards.

Solomon, any update on this?  As far as I'm concerned, the ppcboot.h issue is
the only thing that really needs to be reworked before we bring this patch
in.

josh
