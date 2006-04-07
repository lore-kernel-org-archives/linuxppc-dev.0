Return-Path: <geoffrey.levand@am.sony.com>
Message-ID: <44368B18.4010109@am.sony.com>
Date: Fri, 07 Apr 2006 08:54:00 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [Cbe-oss-dev] [PATCH 4/5] powerpc: export symbols for page size
	selection
References: <20060407150124.422051000@dyn-9-152-242-103.boeblingen.de.ibm.com>	<20060407150743.688538000@dyn-9-152-242-103.boeblingen.de.ibm.com>	<20060407152813.GA382@lst.de>
	<20060407154247.GJ952@pb15.lixom.net>
In-Reply-To: <20060407154247.GJ952@pb15.lixom.net>
Content-Type: text/plain; charset=UTF-8
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> On Fri, Apr 07, 2006 at 05:28:13PM +0200, Christoph Hellwig wrote:
>> On Fri, Apr 07, 2006 at 12:00:04AM +0200, arnd@arndb.de wrote:
>> > We need access to some symbols in powerpc memory management
>> > from spufs in order to create proper SLB entries.
>> 
>> One more reason to disallow modular spufs..
> 
> Yeah, what's the need for that, really? It needs to know so much of
> kernel internals that it's getting silly to allow it to be a module.

We never used that feature either...

-Geoff
