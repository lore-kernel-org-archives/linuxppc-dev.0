Return-Path: <beckyb@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8B479B6F34
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Aug 2009 01:13:26 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D2AFADDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2009 01:13:25 +1000 (EST)
Message-Id: <097D0457-BF1C-403A-A930-31807C296D2C@kernel.crashing.org>
From: Becky Bruce <beckyb@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1250374817.24143.71.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: Poll: Rebasing of powerpc-next
Date: Mon, 17 Aug 2009 10:13:18 -0500
References: <1250374817.24143.71.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 15, 2009, at 5:20 PM, Benjamin Herrenschmidt wrote:

> Hi !
>
> I'd like to rebase powerpc-next ... a few bugs have been found that it
> would be nice to fix in the original patch rather than introducing a
> bisection breakage, and Kumar also just noticed a potentially  
> misleading
> error in a commit message from his tree.
>
> So who is not ok with me doing that tomorrow or tuesday ?

Sounds like a swell idea to me.... I hate bisection breakage.

-Becky
