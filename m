Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EFDAB1A000C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 21:26:14 +1100 (AEDT)
Message-ID: <1455618368.31947.8.camel@ellerman.id.au>
Subject: Re: [PATCH] MAINTAINERS: rename EEH from "enhanced" to "extended"
 error handling
From: Michael Ellerman <mpe@ellerman.id.au>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 16 Feb 2016 21:26:08 +1100
In-Reply-To: <1455612720-3758-1-git-send-email-ruscur@russell.cc>
References: <1455612720-3758-1-git-send-email-ruscur@russell.cc>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-02-16 at 19:52 +1100, Russell Currey wrote:

> Incredibly, IBM online documentation for EEH uses "extended error handling"
> and "enhanced error handling" to refer to the same thing, in different
> places.  In other parts of the kernel, namely the EEH documentation (found
> in Documentation/powerpc/eeh-pci-error-recovery.txt), it's referred to as
> "extended", and in my opinion "extended" makes more sense for what EEH
> does.
>
> The only place "enhanced error handling" shows up in the kernel is in
> MAINTAINERS, so fix it.

Unfortunately the document that pretty much defines it (PAPR) uses "Enhanced":

  5.4.1 Enhanced I/O Error Handling (EEH) Option


And online I see that the AIX manuals use Enhanced:

  https://www-01.ibm.com/support/knowledgecenter/ssw_aix_72/com.ibm.aix.kernextc/eeh_intro.htm


So I'm going to nack this and ask you to send the inverse patch, that switches
the kernel references to Enhanced.


> ---
> I don't know what kind of things parse MAINTAINERS, and if there's a chance
> this will break them.

Only scripts/get_maintainer.pl that I know of, and I don't think it cares about
the heading much, so it would be safe to change.

> Also, the powerpc tree *is* the right place to send this, right?

Yep, patches to MAINTAINERS for powerpc specific stuff should go via me.

cheers
