Return-Path: <cel@us.ibm.com>
Subject: Re: [Cbe-oss-dev] [RFC, PATCH 1/4] Add support to OProfile for
	profiling Cell BE SPUs -- update
From: Carl Love <cel@us.ibm.com>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20070130103924.GA14571@lst.de>
References: <45BE4ED0.5030808@us.ibm.com> <45BE4F2A.5040702@us.ibm.com>
	<20070130103924.GA14571@lst.de>
Content-Type: text/plain
Date: Tue, 30 Jan 2007 14:49:57 -0800
Message-Id: <1170197398.5235.12.camel@dyn9047021078.beaverton.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christoph:

In our earlier work on the PPU profiling patch, Benjamin Herrenschmidt
said that we should remove macros that are only used once and just put
the actual code in.  That is why the macros were removed. 

            Carl Love


On Tue, 2007-01-30 at 11:39 +0100, Christoph Hellwig wrote:
> On Mon, Jan 29, 2007 at 01:46:50PM -0600, Maynard Johnson wrote:
> > 
> > 
> 
> I don't think the macro removal is helpful, getting rid of the names
> makes the code less readable to me.
> _______________________________________________
> cbe-oss-dev mailing list
> cbe-oss-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/cbe-oss-dev
