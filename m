Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id AE7312BF06
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Oct 2004 12:02:29 +1000 (EST)
Date: Thu, 21 Oct 2004 19:02:26 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Hiroshi DOYU <Hiroshi_DOYU@montavista.co.jp>
Message-ID: <20041022020226.GC22069@gate.ebshome.net>
References: <20041022085733.0c5289c8.Hiroshi_DOYU@montavista.co.jp>
	<20041022013320.GB22069@gate.ebshome.net>
	<20041022103859.50e2b2f6.Hiroshi_DOYU@montavista.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20041022103859.50e2b2f6.Hiroshi_DOYU@montavista.co.jp>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [BUG] IBM440GX works too slow under nfsroot
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Oct 22, 2004 at 10:38:59AM +0900, Hiroshi DOYU wrote:
> On Thu, 21 Oct 2004 18:33:20 -0700
> Eugene Surovegin <ebs@ebshome.net> wrote:
> 
> > On Fri, Oct 22, 2004 at 08:57:33AM +0900, Hiroshi DOYU wrote:
> > > Now I am strugging with booting vanilla(2.4.2x) on ibm440gx and
> > > I could succeed to boot it but, after nfs mounted, it's behavior 
> > > seems too slow. I guess, it looks like the system is running 
> > > half duplex. 
> > 
> > Yeah, driver thinks it's connected to 10Mb hub. How the board is 
> > actualy connected to the network?
> 
> 10Mb hub.
> 

Wow, I really had to spend some time to find such ancient hw :). I'll 
try 2.4.27 with this hub during next couple of days (I'm a little busy 
right now) and let you know. I suspect nobody really tested EMAC driver 
in 10Mb HDX mode.

You can also bug Matt Porter, maybe he'll help you sooner :).

--
Eugene
