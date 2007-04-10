Return-Path: <michaelzwrk@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.236])
	by ozlabs.org (Postfix) with ESMTP id D02CDDDF22
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Apr 2007 01:31:34 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so1630670nzf
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Apr 2007 08:31:33 -0700 (PDT)
Message-ID: <1ea6be8e0704100831u6b7a62cbia0ecef82ec73f0a2@mail.gmail.com>
Date: Tue, 10 Apr 2007 17:31:32 +0200
From: Michael <michaelzwrk@gmail.com>
To: "Mark Lord" <liml@rtr.ca>
Subject: Re: IDE driver in polling mode
In-Reply-To: <461BA2BB.6040101@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <1ea6be8e0704100635ydbf1538i782e796c99891e5d@mail.gmail.com>
	<461B9D04.2000109@ru.mvista.com> <461BA2BB.6040101@rtr.ca>
Cc: linux-ide@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks, looks like a good plan...

On 4/10/07, Mark Lord <liml@rtr.ca> wrote:
> > Michael wrote:
> >
> >> I'd like to know whether it is possible to use IDE driver (ide-disk)
> >> in polling mode, instead of using IRQ.
>
> This should be doable, with a small amount of hacking.
> Mostly, you just need to use add_timer() to set up a polling
> function that simply calls ide_intr() and then does add_timer()
> again for the next poll.
>
> For your purposes, it could be as simple as five lines of C.
>
> Cheers
>
