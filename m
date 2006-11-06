Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id 3827567C9A
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Nov 2006 17:28:02 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so672882ugf
	for <linuxppc-dev@ozlabs.org>; Sun, 05 Nov 2006 22:28:01 -0800 (PST)
Message-ID: <528646bc0611052228j20a4c197x94da47467dce8d67@mail.gmail.com>
Date: Sun, 5 Nov 2006 23:28:01 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: [PATCH/RFC] powerpc: Add MPC5200 Interrupt Controller support.
In-Reply-To: <1162689227.28571.123.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <454902F9.20206@bplan-gmbh.de>
	<1162419138.25682.453.camel@localhost.localdomain>
	<454A1C37.5050208@bplan-gmbh.de> <454A5952.6090801@bplan-gmbh.de>
	<1162683341.28571.82.camel@localhost.localdomain>
	<454D2FEC.3050605@246tNt.com>
	<1162689227.28571.123.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, sl@bplan-gmbh.de, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/4/06, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Sun, 2006-11-05 at 01:27 +0100, Sylvain Munaut wrote:
> > with a helper that would do
> > - The find_node
> >  - get_address / translate /  get_size
> >  - ioremap
> >
> > Something like :
> >
> > intr = mpc52xx_find_and_map("mpc52xx-intr");
> > sdma = mpc52xx_find_and_map("mpc52xx-sdma");
>
> Hrm... I don't care that much but I also don't think we need that
> helper. It's not saving much.

While on this topic... if a helper is added, what about it is 52xx
specific?  Wouldn't the same code apply to all platforms?

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
