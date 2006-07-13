Return-Path: <bwarren@qstreams.com>
Received: from smtp105.biz.mail.re2.yahoo.com (smtp105.biz.mail.re2.yahoo.com
	[206.190.52.174]) by ozlabs.org (Postfix) with SMTP id B860D67B80
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Jul 2006 07:04:12 +1000 (EST)
Subject: Re: Knowing kernel module load address (insmod hasn't -m)
From: Ben Warren <bwarren@qstreams.com>
To: Antonio Di Bacco <antonio.dibacco@aruba.it>
In-Reply-To: <200607132238.11177.antonio.dibacco@aruba.it>
References: <200607132238.11177.antonio.dibacco@aruba.it>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 17:04:08 -0400
Message-Id: <1152824648.5238.12.camel@saruman.qstreams.net>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

cat /proc/modules

If you want more detailed information about a module (locations
of .text, .data, .bss etc), enable CONFIG_KALLSYMS in your kernel and
you'll see lots of goodness in the /sys/module/<YOUR MODULE>/sections
directory.

Do yourself a favor and browse http://lwn.net/Articles/driver-porting/
where Jon Corbet has written a really good series of articles about
modules and device drivers in the 2.6 kernel.

cheers,
Ben

On Thu, 2006-07-13 at 22:38 +0200, Antonio Di Bacco wrote:
> Hi all,
> 
> where can be read at which memory address a module was loaded. I use the bb 
> insmod that doesn't provide -m option.
> 
> Bye,
> Antonio.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
