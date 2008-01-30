Return-Path: <gregkh@suse.de>
Received: from mx1.suse.de (mail.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6BC49DDDEB
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 13:38:37 +1100 (EST)
Date: Tue, 29 Jan 2008 16:40:40 -0800
From: Greg KH <gregkh@suse.de>
To: maximilian attems <max@stro.at>
Subject: Re: ppc64 vecemu compile failure
Message-ID: <20080130004040.GA4876@suse.de>
References: <20080130000337.GC25253@stro.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080130000337.GC25253@stro.at>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 30, 2008 at 01:03:37AM +0100, maximilian attems wrote:
> on latest git since driver subsys merge on powerpc64:
> 
> arch/powerpc/kernel/built-in.o: In function `fphalf':
> vecemu.c:(.toc+0x1360): undefined reference to `devices_subsys'
> make[3]: *** [.tmp_vmlinux1] Error 1

See the patches posted on lkml for this already.

thanks,

greg k-h
