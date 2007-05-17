Return-Path: <benh@kernel.crashing.org>
Subject: Re: Resending: RT patches expose netdev race [was Re: [RFC] [patch
	2/2] powerpc 2.6.21-rt1: fix kernel hang and/or panic
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20070517002751.GC4325@austin.ibm.com>
References: <20070517002751.GC4325@austin.ibm.com>
Content-Type: text/plain
Date: Thu, 17 May 2007 10:49:45 +1000
Message-Id: <1179362985.32247.252.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, cbe-oss-dev@ozlabs.org,
	linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, mingo@elte.hu,
	tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I do not know why sk_buff->head would be null, or
> would be set in a racy kind of way, or why the rt patches
> would cause this. But the evidence implicates that.

Would it be possible that a locking bug in spidernet would cause it
under some circumstances to get a stale skb pointer ?

Ben.
