Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Friesen <cfriesen@nortel.com>
In-Reply-To: <4203D793.1040604@nortel.com>
References: <41FECA18.50609@nortelnetworks.com>
	<1107243398.4208.47.camel@laptopd505.fenrus.org>
	<41FFA21C.8060203@nortelnetworks.com>
	<1107273017.4208.132.camel@laptopd505.fenrus.org>
	<20050204203050.GA5889@dmt.cnet>  <4203D793.1040604@nortel.com>
Content-Type: text/plain
Date: Sat, 05 Feb 2005 20:19:08 +1100
Message-Id: <1107595148.30302.5.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	Arjan van de Ven <arjan@infradead.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: question on symbol exports
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> It turns out that to call ptep_clear_flush_dirty() on ppc64 from a 
> module I needed to export the following symbols:
> 
> __flush_tlb_pending
> ppc64_tlb_batch
> hpte_update

Any reason why you need to call that from a module ? Is the module
GPL'd ?

Ben.
