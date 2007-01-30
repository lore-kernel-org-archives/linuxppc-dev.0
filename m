Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [RFC, PATCH 1/4] Add support to OProfile
	for	profiling Cell BE SPUs -- update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Carl Love <cel@us.ibm.com>
In-Reply-To: <1170197398.5235.12.camel@dyn9047021078.beaverton.ibm.com>
References: <45BE4ED0.5030808@us.ibm.com> <45BE4F2A.5040702@us.ibm.com>
	<20070130103924.GA14571@lst.de>
	<1170197398.5235.12.camel@dyn9047021078.beaverton.ibm.com>
Content-Type: text/plain
Date: Wed, 31 Jan 2007 09:59:57 +1100
Message-Id: <1170197997.26655.345.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	oprofile-list@lists.sourceforge.net, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-01-30 at 14:49 -0800, Carl Love wrote:
> Christoph:
> 
> In our earlier work on the PPU profiling patch, Benjamin Herrenschmidt
> said that we should remove macros that are only used once and just put
> the actual code in.  That is why the macros were removed. 

I've looked at the macros you remove and indeed, they look like stuff
you actually want to keep in macros. I don't have off the top of my head
the circumstances where I asked you to remove macros in the PPE code,
but I'm sure it was different.

Ben.
