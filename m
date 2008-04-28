Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 18811DDDFC
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 18:48:23 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Mon, 28 Apr 2008 10:46:30 +0200
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: cpu_clock confusion
Message-ID: <20080428084630.GA1623@iram.es>
References: <1207240450.3797.22.camel@johannes.berg>
	<20080404144641.GA15844@elte.hu>
	<1209028912.3357.52.camel@johannes.berg>
	<20080424.022404.151729194.davem@davemloft.net>
	<1209029257.3357.55.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1209029257.3357.55.camel@johannes.berg>
Cc: linux-kernel@vger.kernel.org, benh@ozlabs.org, linuxppc-dev@ozlabs.org,
	tglx@linutronix.de, arndb@de.ibm.com, mingo@elte.hu,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 24, 2008 at 11:27:37AM +0200, Johannes Berg wrote:
> On Thu, 2008-04-24 at 02:24 -0700, David Miller wrote:
> > From: Johannes Berg <johannes@sipsolutions.net>
> > Date: Thu, 24 Apr 2008 11:21:52 +0200
> > 
> > > Hmm. Why is that whole cpu_clock stuff in place anyway? powerpc has
> > > perfectly synchronised time across processors with dirt cheap access to
> > > it as well, so why build all this code that only messes it up on top of
> > > it?
> > 
> > Same on sparc64.  These changes add more bugs than they fix.
> 
> I tend to think all this clock business should be done local to those
> arches that aren't capable of providing cheap, useful synchronised and
> accurate clocks themselves. Or be a lib that they can link in if needed.
> As it stands, it seems to me that it all just penalises those
> architectures that have decent clocks.

100% agreed. 

	Gabriel
