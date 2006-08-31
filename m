Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17654.25802.380698.831529@cargo.ozlabs.ibm.com>
Date: Thu, 31 Aug 2006 14:25:46 +1000
From: Paul Mackerras <paulus@samba.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: IPSec kernel oops on ppc64
In-Reply-To: <20060831035346.GA28306@gondor.apana.org.au>
References: <200608301636.k7UGaQY5002569@faith.austin.ibm.com>
	<20060831015942.GA27423@gondor.apana.org.au>
	<17654.21983.691176.397891@cargo.ozlabs.ibm.com>
	<20060831035346.GA28306@gondor.apana.org.au>
Cc: jmorris@redhat.com, netdev@vger.kernel.org, anton@au1.ibm.com,
	linuxppc-dev@ozlabs.org, gcwilson@us.ibm.com,
	Joy Latten <latten@austin.ibm.com>, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Herbert Xu writes:

> BTW, did you see the "cmpldi r1,..." stuff in the code?  That's a typo,
> right?

Yes it is a typo, but fixing it is lower priority since both r1 and
cr1 equal 1.

Paul.
