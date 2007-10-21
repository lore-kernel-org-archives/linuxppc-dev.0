Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by ozlabs.org (Postfix) with ESMTP id 8A404DDE46
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 Oct 2007 02:55:32 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1116383wag
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 21 Oct 2007 09:55:31 -0700 (PDT)
Message-ID: <fa686aa40710210955v14de2e78g88bf8c0d74482176@mail.gmail.com>
Date: Sun, 21 Oct 2007 10:55:29 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH] mpc5200: /dev/watchdog driver for GPT0
In-Reply-To: <ECDF5931-F264-4083-B4F0-C8CA1976195A@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070612085931.GG23294@moe.telargo.com>
	<ECDF5931-F264-4083-B4F0-C8CA1976195A@kernel.crashing.org>
Cc: Domen Puncer <domen.puncer@telargo.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 6/13/07, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Jun 12, 2007, at 3:59 AM, Domen Puncer wrote:
>
> > Driver for internal mpc5200 watchdog on general purpose timer 0.
> > For IPB clock of 132 MHz the maximum timeout is about 32 seconds.
> >
> >
> > Signed-off-by: Domen Puncer <domen.puncer@telargo.com>
>
> Should really be submitted to the watchdog maintainer if you want
> this in the kernel

Domen, are you going to respin this patch and submit it to the
watchdog maintainer?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
