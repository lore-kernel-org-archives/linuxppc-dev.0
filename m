Return-Path: <sven@powerlinux.fr>
Received: from archon.plz.fr (archon.plz.fr [194.50.78.210])
	by ozlabs.org (Postfix) with ESMTP id 6ACEDDDF09
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 00:40:39 +1000 (EST)
Date: Thu, 6 Sep 2007 16:09:40 +0200
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] AmigaOne device tree source v2
Message-ID: <20070906140940.GA3947@powerlinux.fr>
References: <20070831175006.17240@gmx.net>
	<20070903013431.GG31499@localhost.localdomain>
	<20070903145814.101070@gmx.net>
	<f460b176a7c30dae101bfc00d1d4b8e9@kernel.crashing.org>
	<20070904114945.303440@gmx.net>
	<20070905024805.GE17189@localhost.localdomain>
	<20070905115419.321990@gmx.net>
	<007113bd4008c022872fae697d5dd20f@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <007113bd4008c022872fae697d5dd20f@kernel.crashing.org>
From: Sven Luther <sven@powerlinux.fr>
Cc: David Gibson <david@gibson.dropbear.id.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 06, 2007 at 04:00:45PM +0200, Segher Boessenkool wrote:
> >> The node should have a compatible
> >> property which is sufficient to select the right bridge driver.
> > Yeah, I defined a compatible = "mai,articias"; property in the pci 
> > node.
> > Are there any naming conventions (maybe lower case only)?
> 
> It's conventional for the part behind the comma to be lower-case
> only, yes.  There are more stringent rules for the part before
> the comma (the manufacturer part).  What is "mai"?

mai logic (some mentor arc derivative i think, ma stands for mentor arc)
was the firm who produced the articia northbridge. The Articia S
northbridge was known to be defective, and i am unsure if mai survived
it or something. 

Friendly,

Sven Luther
