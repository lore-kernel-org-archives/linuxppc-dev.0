Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] 2.6.19-rc6-arnd1 release
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20061117061021.GB13535@lst.de>
References: <200611170034.09865.arnd@arndb.de> <20061117061021.GB13535@lst.de>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 19:10:15 +1100
Message-Id: <1163751015.5826.10.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Corry <kevcorry@us.ibm.com>,
	Jeremy Kerr <jeremy@au1.ibm.com>,
	Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-11-17 at 07:10 +0100, Christoph Hellwig wrote:
> On Fri, Nov 17, 2006 at 12:34:08AM +0100, Arnd Bergmann wrote:
> > I've uploaded a new kernel tree to the usual location at
> > http://www.kernel.org/pub/linux/kernel/people/arnd/patches/.
> > 
> > It now contains oprofile support, as well as the updated xmon
> > patches. Both of these were sent in the last few days.
> > 
> > Changes that are in there for a little longer include
> > saving SPU contexts in core dumps, and support for the
> > Playstation 3. The Playstation patches are still last week's
> > version, I expect an update soon, which can probably go
> > right into powerpc.git for the most part.
> 
> No they can't.  There's a shitload of braindamage in there, and we
> should hold Sony against the same standards as everyone else.

There is not that much brain damage in there anymore, at least not that
can be fixed (a lot is really the hypervisor being really weird).

Ben.
