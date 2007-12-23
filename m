Return-Path: <hch@lst.de>
Date: Sun, 23 Dec 2007 13:35:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [Cbe-oss-dev] Time for cell code reshuffle?
Message-ID: <20071223123501.GA19823@lst.de>
References: <200712211522.03841.arnd@arndb.de>
	<200712231247.44154.jk@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200712231247.44154.jk@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Dec 23, 2007 at 12:47:42PM +0900, Jeremy Kerr wrote:
> Hi all,
> 
> > To the question, where what it should go, I'd leave the decision to
> > Jeremy, but my current idea would be:
> >
> > arch/powerpc/platforms/cell/spufs -> arch/powerpc/spufs
> 
> I'd suggest arch/powerpc/sysdev/spufs to keep arch/powerpc clean.
> 
> However, this may also depend on the (intended) structure of SPURSEngine 
> support, which may mean that fs/spufs might be a better place. It would 
> suck to have to move things twice, so maybe someone from Tosihba could 
> provide some input? Would the powerpc spufs code be suitable for 
> SPURSEngine?

Strong NACK for fs/spufs/  fs code is the smallest part of the spu
support, and all this nasty lowlevel code doesn't belong into fs/ at
all.
