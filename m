Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 36C9867A30
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Jan 2005 09:03:03 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <Pine.GSO.4.61.0501211013330.1075@waterleaf.sonytel.be>
References: <41EC29A8.1040703@mvista.com> <1106259956.18397.10.camel@gaston>
	<41F0449C.5020603@mvista.com> <1106265672.5387.14.camel@gaston>
	<41F04849.70506@mvista.com> <1106266338.18397.21.camel@gaston>
	<Pine.GSO.4.61.0501211013330.1075@waterleaf.sonytel.be>
Content-Type: text/plain
Date: Sat, 22 Jan 2005 09:01:33 +1100
Message-Id: <1106344893.5387.32.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [RFC] Option to disable mapping genrtc calls to ppc_md calls
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2005-01-21 at 10:14 +0100, Geert Uytterhoeven wrote:
> On Fri, 21 Jan 2005, Benjamin Herrenschmidt wrote:
> > On Thu, 2005-01-20 at 17:09 -0700, Mark A. Greer wrote:
> > > Yes but as I wrote, I don't have time right now.
> > 
> >  ... which is exactly my rant ... embedded companies never have time
> > to do the right thing...
> 
> Because they have strict (paid for) deadlines, unlike the `we do it for
> fun'-crowd led by Linus ;-)

Then they should include the time of doing stuffs properly in the
initial sizing  ... 
