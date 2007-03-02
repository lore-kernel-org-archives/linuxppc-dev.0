Return-Path: <hch@lst.de>
Date: Fri, 2 Mar 2007 03:15:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [Cbe-oss-dev] [PATCH] Allow spufs to build as a module with
	slices enabled
Message-ID: <20070302021531.GA18693@lst.de>
References: <20070220074433.96AAEDDDEC@ozlabs.org>
	<20070301061134.0B4B2DDEC1@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070301061134.0B4B2DDEC1@ozlabs.org>
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, cbe-oss-dev@ozlabs.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 01, 2007 at 03:11:31PM +0900, Michael Ellerman wrote:
> The slice code is missing some exports to allow spufs to build as a
> module. Add them.

should be _GPL exports I think.
