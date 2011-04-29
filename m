Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 115901007E8
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 30 Apr 2011 06:38:18 +1000 (EST)
Subject: Re: [PATCH 0/1] ppc4xx: Fix PCIe scanning for the 460SX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ayman El-Khashab <ayman@elkhashab.com>
In-Reply-To: <20110429170240.GA21384@crust.elkhashab.com>
References: <1302286930-9988-1-git-send-email-ayman@elkhashab.com>
	<1302306484.2458.64.camel@pasglop>
	<178c7df4696bacdd1510bacae143222a@mail.gmail.com>
	<20110429170240.GA21384@crust.elkhashab.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 30 Apr 2011 06:37:56 +1000
Message-ID: <1304109476.2513.243.camel@pasglop>
Mime-Version: 1.0
Cc: Tirumala Marri <tmarri@apm.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-04-29 at 12:02 -0500, Ayman El-Khashab wrote:
> On Tue, Apr 12, 2011 at 07:09:49PM -0700, Tirumala Marri wrote:
> > You originally submitted the support for 460ex. Can you chime in (and
> > review Ayman patch) please ?
> > 
> > [Marri] Ben sure I will review it and send you my feedback in couple of
> > days.
> 
> Is there any update on this patch?  Any comment?  Any reason it _cant_
> be included?  

I'm tempted to put it in if Tirumala doesn't get to review it asap.

Cheers,
Ben.
