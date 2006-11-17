Return-Path: <hch@lst.de>
Date: Fri, 17 Nov 2006 07:10:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Cbe-oss-dev] 2.6.19-rc6-arnd1 release
Message-ID: <20061117061021.GB13535@lst.de>
References: <200611170034.09865.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200611170034.09865.arnd@arndb.de>
Cc: Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, Jeremy Kerr <jeremy@au1.ibm.com>,
	Kevin Corry <kevcorry@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 17, 2006 at 12:34:08AM +0100, Arnd Bergmann wrote:
> I've uploaded a new kernel tree to the usual location at
> http://www.kernel.org/pub/linux/kernel/people/arnd/patches/.
> 
> It now contains oprofile support, as well as the updated xmon
> patches. Both of these were sent in the last few days.
> 
> Changes that are in there for a little longer include
> saving SPU contexts in core dumps, and support for the
> Playstation 3. The Playstation patches are still last week's
> version, I expect an update soon, which can probably go
> right into powerpc.git for the most part.

No they can't.  There's a shitload of braindamage in there, and we
should hold Sony against the same standards as everyone else.
