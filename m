Return-Path: <vbendeb@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.229])
	by ozlabs.org (Postfix) with ESMTP id 485ECDDE09
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Jan 2008 05:45:00 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so923076nzh.39
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jan 2008 10:44:59 -0800 (PST)
Message-ID: <f608b67d0801181044j352ee94dl50ea291164f4cb17@mail.gmail.com>
Date: Fri, 18 Jan 2008 10:44:58 -0800
From: vb <vb@vsbe.com>
Sender: vbendeb@gmail.com
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: MPIC ISU
In-Reply-To: <57351E05-13DE-48F0-B0E5-28AADEF288A1@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f608b67d0801152203j523ebdeavbab4412121a31a7@mail.gmail.com>
	<57351E05-13DE-48F0-B0E5-28AADEF288A1@kernel.crashing.org>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar,

thank you for your reply!

On Jan 18, 2008 7:54 AM, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> >
> > What is it, at the very least - what does ISU stand for?
> >
> > I would really appreciate any hints,
>
> Interrupt service unit.  I believe its an IBM concept.
>
> For 8245 can you look at what the linkstation port is doing and mimic
> that.  I believe its an 8245 or 8241 so it should be close to what you
> need.
>

what platform is linkstation and what kernel version can I find it in?


TIA,
/vb

>          mpic = mpic_alloc(dnp, paddr, MPIC_PRIMARY |
> MPIC_WANTS_RESET, 4, 32, " EPIC     ");
>          BUG_ON(mpic == NULL);
>
>          /* PCI IRQs */
>          mpic_assign_isu(mpic, 0, paddr + 0x10200);
>
>          /* I2C */
>          mpic_assign_isu(mpic, 1, paddr + 0x11000);
>
>          /* ttyS0, ttyS1 */
>          mpic_assign_isu(mpic, 2, paddr + 0x11100);
>
>          mpic_init(mpic);
>
> - k
>
