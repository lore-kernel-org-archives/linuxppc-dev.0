Return-Path: <leon.woestenberg@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by ozlabs.org (Postfix) with ESMTP id 1FD7DDDEF2
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jul 2008 06:03:34 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so715334anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 03 Jul 2008 13:03:33 -0700 (PDT)
Message-ID: <c384c5ea0807031303i1ddf7663na80928fd77d40be5@mail.gmail.com>
Date: Thu, 3 Jul 2008 22:03:33 +0200
From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
To: "Brian Silverman" <bsilverman@conceptxdesign.com>
Subject: Re: Full Linux distributions
In-Reply-To: <486D27B9.8090308@conceptxdesign.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <486D27B9.8090308@conceptxdesign.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Brian,

On Thu, Jul 3, 2008 at 9:25 PM, Brian Silverman
<bsilverman@conceptxdesign.com> wrote:
> I'm looking for advice into what Linux distributions (rootfs) people are
> using for the PowerPC.
>
> Specifically, I'm currently using busybox for my core rootfs, but I'm
>
buildroot I guess, not busybox (alone).

> looking for an alternative that will allow me to:
>   - easily add new packages

>   - is binary compatible with the PPC405. 440, and Freescale 85xx cores.
>
binary compatible? You mean it can build binaries for those cores?

>   - can be large (compared to the usual embedded devices), say in the 100MB
> to 1GB range.  It will sit on an SD card.
>   - Can be built/maintained under cygwin, and can generate a ext2 image
> (e.g. with gen2extfs)
>
>   3) OpenEmbedded (doesn't seem to currently support cygwin)
>
My preference is to use OpenEmbedded and do so under a Linux host
system (any will do).
As I don't want to be tied to a certain host OS, Emdebian or
Gentoo-Embedded are no-go for me.

I have used tools and rootfs systems like crosstool, buildroot, LFS before.

There is also LTIB by Freescale, tried that?

Regards,
-- 
Leon
