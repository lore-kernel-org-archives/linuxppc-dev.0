Return-Path: <olh@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 264886877F
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Nov 2005 10:16:48 +1100 (EST)
Date: Sat, 19 Nov 2005 00:16:43 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20051118231643.GA14601@suse.de>
References: <17277.28534.614112.962810@cargo.ozlabs.ibm.com>
	<20051118075158.GB14865@suse.de> <20051118221309.GA12724@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20051118221309.GA12724@suse.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] generate COFF zImage in arch/powerpc/boot
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Fri, Nov 18, Olaf Hering wrote:

>  On Fri, Nov 18, Olaf Hering wrote:
> 
> >  On Fri, Nov 18, Paul Mackeras wrote:
> > 
> > 
> > > +++ merge-hack/arch/powerpc/boot/zImage.lds	2005-11-16 23:16:48.000000000 +1100
> > 
> > This change makes arch/powerpc/boot/README obsolete. 
> > Last time I looked, the COFF loader liked only .text, .data and .bss.
> > But maybe hack-coff needs some tweaking to modify also other sections.
> 
> I tried to keep the kernel in its own section. But the firmware does not
> fully setup the memory range for that section. claim and map calls for
> that area are not enough.

After using your new version of claim, I found that the section is not
copied. It contains only sequences of ff0fffff fff0ff0f.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
