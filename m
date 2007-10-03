Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id 33333DDE32
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 04:22:53 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so5839310wag
	for <linuxppc-dev@ozlabs.org>; Wed, 03 Oct 2007 11:22:52 -0700 (PDT)
Message-ID: <fa686aa40710031122w7a0a04aemecd492da1e4864bc@mail.gmail.com>
Date: Wed, 3 Oct 2007 12:22:47 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Andrei Konovalov" <akonovalov@ru.mvista.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 0/6] Patch series to add of_platform binding to xilinxfb
In-Reply-To: <4703C8A7.8070001@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071001155024.6114.47993.stgit@trillian.cg.shawcable.net>
	<4703C8A7.8070001@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/3/07, Andrei Konovalov <akonovalov@ru.mvista.com> wrote:
> Hi Grant,
>
> Grant Likely wrote:
> > (resend due to mailer issues.  Apologies to anyone receiving this twice)
> >
> > This patch series reworks the Xilinx framebuffer driver and then adds
> > an of_platform bus binding.  The of_platform bus binding is needed to use
> > the driver in arch/powerpc platforms.
>
> The patch series looks good (though I did no testing on my site; seems
> the Xilinx ML* boards should not be hurt).

I've tested under both arch/ppc and arch/powerpc on a custom board
that I have here.

>
> BTW, I don't follow the linuxppc list close enough at the moment.
> What boards are going to use of_platform bus binding?

Any Xilinx platform (powerpc & microblaze) using the xilinx
framebuffer (ml300, ml403, etc).

> ML40x/ML300 are not in the arch/powerpc yet, right?

2.6.24 will have Xilinx Virtex support in arch/powerpc.  It's already
in Josh's 4xx maintainer tree.

> Do I recall correct that you have a mpc5200 based one with two xilinxfb's?

Nope, I haven't seen such a beast myself.

> PS
> I don't think you need an ack from me.
> If this is not true, let me know, and I'll ack the patch series

You are the author after all.  :-)  Your ack is probably appropriate,
if not absolutely necessary.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
