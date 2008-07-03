Return-Path: <d.stonier@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.238])
	by ozlabs.org (Postfix) with ESMTP id 8F5C8DDEEE
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jul 2008 09:59:54 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so1025174rvb.9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 03 Jul 2008 16:59:53 -0700 (PDT)
Message-ID: <27dfa3d0807031659n4a03dd63i4793c3231d224ae6@mail.gmail.com>
Date: Fri, 4 Jul 2008 08:59:53 +0900
From: "Daniel Stonier" <d.stonier@gmail.com>
To: "Brian Silverman" <bsilverman@conceptxdesign.com>
Subject: Re: Full Linux distributions
In-Reply-To: <486D32A7.7080007@conceptxdesign.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <486D27B9.8090308@conceptxdesign.com>
	<c384c5ea0807031303i1ddf7663na80928fd77d40be5@mail.gmail.com>
	<486D32A7.7080007@conceptxdesign.com>
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

On 04/07/2008, Brian Silverman <bsilverman@conceptxdesign.com> wrote:
>
>  Thanks for your response...
>
>  Leon Woestenberg wrote:
>
>  - is binary compatible with the PPC405. 440, and Freescale 85xx cores.
>
>  binary compatible? You mean it can build binaries for those cores?
>
>  What I meant (but said poorly) was that it has pre-compiled binaries.  But
> its fine if I can build it under cygwin.  And I am thinking that I may drop
> the cygwin requirement, because its painful to do linux builds under it.
>
>  My preference is to use OpenEmbedded and do so under a Linux host
> system (any will do).
> As I don't want to be tied to a certain host OS, Emdebian or
> Gentoo-Embedded are no-go for me.
>
> I have used tools and rootfs systems like crosstool, buildroot, LFS before.
>
> There is also LTIB by Freescale, tried that?
>
>  I need to look closer at LITB - but I was guessing it didn't have PPC4xx
> support.
>
>  Thanks!
>  --
> Brian Silverman
> Concept X, LLC

I've been using the ELDK for an amcc440EP ppc board. It's turned out
to be rather convenient, especially when running a networked
environment. The guy who primarily maintains it is very helpful also.
