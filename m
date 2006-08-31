Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17654.13282.125232.199693@cargo.ozlabs.ibm.com>
Date: Thu, 31 Aug 2006 10:57:06 +1000
From: Paul Mackerras <paulus@samba.org>
To: Joy Latten <latten@austin.ibm.com>
Subject: Re: IPSec kernel oops on ppc64
In-Reply-To: <200608301636.k7UGaQY5002569@faith.austin.ibm.com>
References: <200608301636.k7UGaQY5002569@faith.austin.ibm.com>
Cc: jmorris@redhat.com, herbert@gondor.apana.org.au, netdev@vger.kernel.org,
	anton@au1.ibm.com, linuxppc-dev@ozlabs.org, gcwilson@us.ibm.com,
	davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Joy Latten writes:

> The good news is that the pings worked great!
> So perhaps ESP is working ok with ICMP.
> 
> But when I tried to do sftp, I still got the oops.
> I don't think TCP and ESP are working.

You're hitting the BUG_ON(len) at line 611 of net/xfrm/xfrm_algo.c.
Is that the same thing that happened without the patch to memcpy, or
was that a different oops?

Paul.
