Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17977.9796.15991.630737@cargo.ozlabs.ibm.com>
Date: Thu, 3 May 2007 10:01:08 +1000
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powermac: support G5 CPU hotplug
In-Reply-To: <1178143429.17299.7.camel@localhost.localdomain>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1178086872.13233.27.camel@johannes.berg>
	<17976.28170.695715.416339@cargo.ozlabs.ibm.com>
	<1178116438.13233.65.camel@johannes.berg>
	<1178143429.17299.7.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt writes:

> On Wed, 2007-05-02 at 16:33 +0200, Johannes Berg wrote:
> > On Wed, 2007-05-02 at 20:55 +1000, Paul Mackerras wrote:
> > 
> > > Ultimately we want to put the disabled cpus in sleep mode, but that
> > > will require a suitable cache flush routine.
> > 
> > I don't have any docs for the particular processors the G5s have, do
> > they have a sleep mode?
> 
> They have, but the cache flush is not trivial to do (and might imply
> access to non documented bits). So let's put that on the to-do list and
> stick to NAP for now while I dig something.

Hmmm, I went looking in the 970FX manual for sleep mode and didn't
find it, only nap and doze...

Paul.
