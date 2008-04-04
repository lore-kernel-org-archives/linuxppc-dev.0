Return-Path: <hch@lst.de>
Date: Fri, 4 Apr 2008 11:15:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Cbe-oss-dev] [PATCH] RTAS - adapt procfs interface
Message-ID: <20080404091524.GA12528@lst.de>
References: <200804011512.20834.jens@de.ibm.com>
	<20080404001242.GA19506@lst.de> <200804040739.30139.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200804040739.30139.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>,
	cbe-oss-dev@ozlabs.org, Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 04, 2008 at 07:39:29AM +0200, Arnd Bergmann wrote:
> Well we still have the regression against 2.6.23 and I'd like to
> get that fixed in 2.6.25 if it's not already release by the time
> we get there.
> 
> Would you prefer using Nathan's proper patch for 2.6.25, or do
> that for 2.6.26 instead, perhaps using Jens' patch as a quick
> fix, as Nathan suggested?

Nathan's patch is not correct either because each file needs it's own
open count.  But something similar would be correct.
