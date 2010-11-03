Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0A1E5B70E6
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  4 Nov 2010 00:46:11 +1100 (EST)
Subject: Re: Problem with Infiniband adapter on IBM p550
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Finnegan <pat@computer-refuge.org>
In-Reply-To: <201011022315.04291.pat@computer-refuge.org>
References: <201010072324.33062.pat@computer-refuge.org>
	<1286516470.2463.403.camel@pasglop> <1286516749.2463.408.camel@pasglop>
	<201011022315.04291.pat@computer-refuge.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 04 Nov 2010 00:46:05 +1100
Message-ID: <1288791965.2147.35.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-11-02 at 23:15 -0400, Patrick Finnegan wrote:
> > I don't know why, but it definitely looks like a firmware bug to me.
> > On those machines, PCI resource assignment is under hypervisor
> > control and so Linux cannot re-assign missing resources itself.
> > 
> > I'll see if I can find a FW person to shed some light on this.
> > 
> > Can you provide me (privately maybe) with the FW version on the
> > machine ?
> 
> Ben,
> 
> Have you found out anything more on this (firmware) bug?

No, not yet. Let me ping some folks again.

Cheers,
Ben.
