Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18585.31504.836857.829592@cargo.ozlabs.ibm.com>
Date: Wed, 6 Aug 2008 20:21:04 +1000
From: Paul Mackerras <paulus@samba.org>
To: David Miller <davem@davemloft.net>
Subject: Re: [RFC/PATCH 2/3] of: add of_lookup_stdout() utility function
In-Reply-To: <20080805.233205.201125898.davem@davemloft.net>
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
	<20080806060239.30717.79273.stgit@trillian.secretlab.ca>
	<20080805.233205.201125898.davem@davemloft.net>
Cc: miltonm@bga.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Miller writes:

> On sparc platforms this is obtained differently.  We obtain the 32-bit
> instance value of "/chosen/stdout" and convert that into a prom device
> node path using "instance-to-path".

That's actually exactly what we do too, the linux,stdout-path property
is just a cache of the result of that process.  The difference is that
we have to do it early on while we still have OF around, while you can
do it later.

Paul.
