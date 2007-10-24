Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by ozlabs.org (Postfix) with ESMTP id 459D2DDF1E
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 06:14:45 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so395648wag
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 13:14:44 -0700 (PDT)
Message-ID: <fa686aa40710241314w2dbe0863ja15746614cff0dd@mail.gmail.com>
Date: Wed, 24 Oct 2007 14:14:40 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Domen Puncer" <domen.puncer@telargo.com>
Subject: Re: [PATCH 0/2] mpc52xx: stop drivers from accessing clock config
	directly
In-Reply-To: <20071024191206.GD3369@nd47.coderock.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071024182308.21194.69416.stgit@trillian.cg.shawcable.net>
	<20071024191206.GD3369@nd47.coderock.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/24/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> On 24/10/07 12:24 -0600, Grant Likely wrote:
> > Domen,
> >
> > Here's a real solution to the problem.  I've somewhat tested this on
> > the lite5200b.  Can you give it a spin on efika and see if SPI still
> > works for you?
>
> My test case was lite5200b too, I don't think I ever tried SPI on
> efika.
> (Are even the right pins on irda connector, or is a necessary line
> missing?)

Hmm, I guess that's right.  Can you at least make sure it still boots
on Efika?  Some of the clock detection stuff has changed so I want to
make sure it still boots.

Are you setup to do your SPI test easily on you lite5200b?  When I say
"somewhat" tested; I mean I probed the driver and it didn't crash.
:-)  I haven't tried to run traffic over it.

Can you check that on your system?  If not, can you email me what
setup/programs you used for testing?  I know very little about the SPI
infrastructure.

Thanks,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
