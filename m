Return-Path: <hch@lst.de>
Date: Wed, 9 Apr 2008 10:36:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@ozlabs.org>
Subject: Re: [PATCH 5/6] [POWERPC] properly declare onstack completion in
	iseries veth
Message-ID: <20080409083616.GA24712@lst.de>
References: <20080409072230.C861EDDED0@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080409072230.C861EDDED0@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 09, 2008 at 05:21:34PM +1000, Benjamin Herrenschmidt wrote:
> The iSeries veth driver uses an on-stack struct completion that
> it initializes using the COMPLETION_INITIALIZER instead of
> COMPLETION_INITIALIZER_ONSTACK macro, causing problems with
> lockdep.

should probably go in ASAP independent of the lockdep series.
