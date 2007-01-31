Return-Path: <hch@lst.de>
Date: Wed, 31 Jan 2007 09:47:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [RFC,
	PATCH 1/4] Add support to OProfile for profiling Cell BE SPUs --
	update
Message-ID: <20070131084721.GC5596@lst.de>
References: <45BE4ED0.5030808@us.ibm.com> <45BE4F2A.5040702@us.ibm.com>
	<20070130103924.GA14571@lst.de>
	<1170197398.5235.12.camel@dyn9047021078.beaverton.ibm.com>
	<1170197846.26655.342.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1170197846.26655.342.camel@localhost.localdomain>
Cc: linux-kernel@vger.kernel.org, cbe-oss-dev@ozlabs.org,
	linuxppc-dev@ozlabs.org, oprofile-list@lists.sourceforge.net,
	Carl Love <cel@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 31, 2007 at 09:57:26AM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2007-01-30 at 14:49 -0800, Carl Love wrote:
> > Christoph:
> > 
> > In our earlier work on the PPU profiling patch, Benjamin Herrenschmidt
> > said that we should remove macros that are only used once and just put
> > the actual code in.  That is why the macros were removed. 
> 
> Heh... there is a balance to be found... In some cases, inline functions
> might be better too.

Well, unless there's a very good reasons against it (token pasting,
header pollution) inlines are always preferable over macros, but I
didn't want to bring that issue up aswell..
