Return-Path: <peterh@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [216.239.45.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C2D016857D
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Oct 2005 05:37:46 +1000 (EST)
Received: from evilmonkey.corp.google.com (evilmonkey.corp.google.com
	[172.24.0.124]) by smtp-out.google.com with ESMTP id j9SJRYwZ031723
	for <linuxppc-embedded@ozlabs.org>; Fri, 28 Oct 2005 12:27:34 -0700
Received: from smtp-out2.google.com (zzb8.corp.google.com [172.25.12.88])
	by evilmonkey.corp.google.com with ESMTP id j9SIeimp005785
	for <linuxppc-embedded@ozlabs.org>; Fri, 28 Oct 2005 12:27:33 -0700
Received: by smtp-out2.google.com with SMTP id 8so124241zzb
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Oct 2005 12:27:32 -0700 (PDT)
Message-ID: <50e923300510281227i15609c9dt7778ecbe20920dfa@mail.google.com>
Date: Fri, 28 Oct 2005 12:27:32 -0700
From: Peter Hanson <peterh@google.com>
To: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
In-Reply-To: <1628E43D99629C46988BE46087A3FBB93ADEE3@ep-01.EmbeddedPlanet.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1628E43D99629C46988BE46087A3FBB93ADEE3@ep-01.EmbeddedPlanet.local>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Howto Cross Compile GCC to run on PPC Platform
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 10/28/05, Steven Blakeslee <BlakesleeS@embeddedplanet.com> wrote:
> > get it to cross compile gcc (to run on ppc).  Does anyone
> > know of a good HowTo to do this?
>
> Karim Yaghmour's "Building Embedded Linux Systems"
>
>
> >  I'm currently downloading the source distro of ELDK, so if
> > it's already in there I'll find it, but if there is one
> > elsewhere online please let me know.
>
> Very good, full of features.

My favorite cross tool chain site:

Building and Testing gcc/glibc cross toolchains
http://kegel.com/crosstool/

Look into Canadian crosses.  At the very least you should find the
discussion helpful.
