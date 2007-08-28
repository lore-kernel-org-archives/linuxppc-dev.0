Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id 7F760DDE0F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Aug 2007 23:30:21 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2257980wag
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Aug 2007 06:30:20 -0700 (PDT)
Message-ID: <fa686aa40708280630x67856334qaf2e0dd59ecb95bf@mail.gmail.com>
Date: Tue, 28 Aug 2007 07:30:19 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: schardt <g.schardt@fz-juelich.de>
Subject: Re: Newbie and linux on virtex-II ppc
In-Reply-To: <46D4221D.8030500@fz-juelich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <46D2C9A5.9030708@fz-juelich.de>
	<fa686aa40708270609x453092eye6eaf83b65ac2dee@mail.gmail.com>
	<46D2CFFB.6050602@fz-juelich.de>
	<fa686aa40708270719s1fd230e9g188948ef02b3eda7@mail.gmail.com>
	<46D41298.7060109@fz-juelich.de>
	<fa686aa40708280606p67fd74p9287d041d955c538@mail.gmail.com>
	<46D4221D.8030500@fz-juelich.de>
Cc: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/28/07, schardt <g.schardt@fz-juelich.de> wrote:
> Grant Likely wrote:
> >
> > You've got 2 choices:
> > 1. use the new sysace driver; it's already in mainline.  The new
> > driver is faster, but it doesn't handle hotswap of the CF card (yet)
> >
> But where in menuconfig could i find the sysace driver ? i'm blind, i
> think :)

Which version of kernel are you using?  The new sysace driver was
merged into 2.6.22

>
> > 2. use the EDK driver; easiest way is to use my tree which already has
> > it merged:  http://git.secretlab.ca
> >
> >
> i made an EDK update and now i have the linux_2_2 os in the software
> options. the bsp with all drivers is generated.
> and now ?
>  - copy to kernel tree
>  - use the xmake  to build the kernel, or make ?

Don't use EDK to build you're kernel.  It's too fragile and you need
to use the *exact* version of kernel that EDK expects.  You're better
off to manually copy the xparams file from the generated BSP.  (ie.
Don't let EDK know where your real kernel source tree is)

>
> and why is there no dokumentation :)

Care to write some?

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
