Return-Path: <srs0=fyum=ee=redhat.com=jcm@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zG4bQ4g0qzF0ft
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 19:11:14 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zG4bQ2R24z8vsS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 19:11:14 +1100 (AEDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zG4bP4FvGz9sNw
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2018 19:11:12 +1100 (AEDT)
Subject: Re: [PATCH 09/11] powerpc/64s: Allow control of RFI flush via sysfs
To: Greg KH <gregkh@linuxfoundation.org>
References: <20180108165453.26066-1-mpe@ellerman.id.au>
 <20180108165453.26066-9-mpe@ellerman.id.au>
 <alpine.DEB.2.20.1801081818060.1735@nanos>
 <87y3l880js.fsf@concordia.ellerman.id.au>
 <f4a66b7c-0ee0-07da-b327-42ba6a8c704b@redhat.com>
 <20180109080527.GA32120@kroah.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, mikey@neuling.org,
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 npiggin@gmail.com, linuxppc-dev@ozlabs.org, oohall@gmail.com,
 Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>
From: Jon Masters <jcm@redhat.com>
Message-ID: <d067cc91-e53e-1bfb-d976-839f1a1ba801@redhat.com>
Date: Tue, 9 Jan 2018 03:11:08 -0500
MIME-Version: 1.0
In-Reply-To: <20180109080527.GA32120@kroah.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/09/2018 03:05 AM, Greg KH wrote:
> On Tue, Jan 09, 2018 at 01:06:23AM -0500, Jon Masters wrote:
>> Knowing that the IBM team was going to post with this sysfs interface,
>> our trees contain the rfi_flush file. I mentioned it to some folks on
>> this end (because we know we don't want to add things in sysfs
>> generally, debugfs is a good substitute, per Andrea, and I raised this
>> with him yesterday as a concern in the backport here) but in the end it
>> seemed reasonable to pull this in because it was what got posted, and as
>> Michael says, it's gone into other distro kernels beyond just ours.
> 
> What distro kernels end up enabling does not really reflect on what we
> end up doing in mainline.  The api for this should NOT be arch-specific
> if at all possible, that way lies madness.  Do you want to write
> userspace tools to handle the 60+ different arch implementations?
> 
> Don't let the fragmentation problems of the period in which no one was
> allowed to talk to each other, result in a unchangable mess, that would
> be insane.

Totally fine :) Just saying we tried to do reasonable things with what
we had. Whatever happens upstream in the end is, of course, what we'll
make sure fits into updates that go into the likes of RHEL.

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop
