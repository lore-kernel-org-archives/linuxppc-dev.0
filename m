Return-Path: <adgospod@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id D36F467C5F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Nov 2006 01:51:12 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so127688ugf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Nov 2006 06:51:10 -0800 (PST)
Message-ID: <bdfc5d6e0611150651r28407a4cp168eb4e4c67a9298@mail.gmail.com>
Date: Wed, 15 Nov 2006 09:51:10 -0500
From: "Andy Gospodarek" <andy@greyhouse.net>
Sender: adgospod@gmail.com
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: BDI2000 with MPC5200 and userspace programs
In-Reply-To: <528646bc0611150625u18b78d1akdaea088de27c0f9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <OFEE9EA5F5.4E12B948-ONC1257227.00338F27-C1257227.00343921@moog.com>
	<528646bc0611150625u18b78d1akdaea088de27c0f9@mail.gmail.com>
Cc: Erwin Haese <ehaese@moog.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/15/06, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 11/15/06, Erwin Haese <ehaese@moog.com> wrote:
> > Hi,
> >
> > thinking about ordering a BDI2000, in the information about the BDI2000 it
> > is broadly mentioned to be capable debugging the kernel.
> > Is it also possible to debug Linux user space programs with BDI2000 in a
> > similar way as it is possible with gdbserver running on the target system?
>
> I don't think so, but why would you need to?

It is (I've done it), but it can be tricky.  I did it a while back
with a 2.4 kernel on a 8245-based board.  If I remember correctly the
trick was to set a breakpoint inside a kernel call (I used an ioctl)
that came from your userspace app and then map the userspace
executable to start at address 0x0.  After that you are able to set
breakpoints in the user-space app and do whatever you need.  After
doing it I remember seeing a description of basically the same steps
online somewhere.

>
> > Is there any integration of the BDI2000 to eclipse running at a linux
> > host?
>
> Ultimate solutions has a product that does this.
>
> g.
>
> --
> Grant Likely, B.Sc. P.Eng.
> Secret Lab Technologies Ltd.
> grant.likely@secretlab.ca
> (403) 399-0195
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
