Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9C5C3687AC
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2005 18:52:04 +1100 (EST)
Date: Fri, 18 Nov 2005 08:51:58 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20051118075158.GB14865@suse.de>
References: <17277.28534.614112.962810@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <17277.28534.614112.962810@cargo.ozlabs.ibm.com>
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

 On Fri, Nov 18, Paul Mackeras wrote:


> +++ merge-hack/arch/powerpc/boot/zImage.lds	2005-11-16 23:16:48.000000000 +1100

This change makes arch/powerpc/boot/README obsolete. 
Last time I looked, the COFF loader liked only .text, .data and .bss.
But maybe hack-coff needs some tweaking to modify also other sections.

I was about to do the same changes. There are some comments about the
COFF layout, and PReP, in arch/powerpc/kernel/head_32.S. Some of it can
go.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
