Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by ozlabs.org (Postfix) with ESMTP id 973E6DDED9
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 03:25:59 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1125579wag
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Oct 2007 10:25:58 -0700 (PDT)
Message-ID: <fa686aa40710211025s668cf34eg959c82dab6b1621@mail.gmail.com>
Date: Sun, 21 Oct 2007 11:25:57 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Marian Balakowicz" <m8@semihalf.com>
Subject: Re: [PATCH v2 2/4] [POWERPC] Update device tree binding for mpc5200
	gpt
In-Reply-To: <fa686aa40710210954v3337e82cnf14a487427ecfccc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071018184407.3584.3513.stgit@hekate.izotz.org>
	<20071018184424.3584.77643.stgit@hekate.izotz.org>
	<fa686aa40710210954v3337e82cnf14a487427ecfccc@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/21/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 10/18/07, Marian Balakowicz <m8@semihalf.com> wrote:
> > Add 'fsl,' prefix to 'compatible' property for gpt nodes.
> > Add 'fsl,' prefix to empty, GPT0 specific 'has-wdt' property.
>
> Patch doesn't apply; mpc5200_wdt.c watchdog driver is not in the
> kernel.  I'll pick up the dts change, but you'll need to coordinate w/
> Domen to get the needed changes into his driver before it's picked for
> mainline.

Oops, it is there; drivers/char/watchdog has been moved to
drivers/watchdog, so the patch didn't apply.  I'll fix this up.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
