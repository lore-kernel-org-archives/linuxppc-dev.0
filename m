Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zFqFp2lWLzF0bP
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 09:10:06 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linuxppc-dev@ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, npiggin@gmail.com,
 Anton Blanchard <anton@samba.org>, mikey@neuling.org, oohall@gmail.com,
 Paul Mackerras <paulus@samba.org>, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 09/11] powerpc/64s: Allow control of RFI flush via sysfs
In-Reply-To: <alpine.DEB.2.20.1801081818060.1735@nanos>
References: <20180108165453.26066-1-mpe@ellerman.id.au>
 <20180108165453.26066-9-mpe@ellerman.id.au>
 <alpine.DEB.2.20.1801081818060.1735@nanos>
Date: Tue, 09 Jan 2018 09:09:59 +1100
Message-ID: <87y3l880js.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thomas Gleixner <tglx@linutronix.de> writes:

> On Tue, 9 Jan 2018, Michael Ellerman wrote:
>
> Sorry, I wasn't aware about your efforts and did not cc you. I've just
> queued a more generic sysfs interface for this whole mess:

No worries.

> https://lkml.kernel.org/r/20180107214913.096657732@linutronix.de
>
> It should be simple to extend for write and it would be great if all
> affected architectures could share it.

As you say this has all been a bit of a mess, and as a result we already
have people running kernels with this patch, so we don't want to remove
the 'rfi_flush' file.

But we will certainly add support on powerpc for the files you have
created, in addition to 'rfi_flush'.

cheers
