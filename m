Return-Path: <cfriesen@nortel.com>
Message-ID: <4207F396.7080408@nortel.com>
Date: Mon, 07 Feb 2005 17:02:46 -0600
From: Chris Friesen <cfriesen@nortel.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <41FECA18.50609@nortelnetworks.com>	
	<1107243398.4208.47.camel@laptopd505.fenrus.org>	
	<41FFA21C.8060203@nortelnetworks.com>	
	<1107273017.4208.132.camel@laptopd505.fenrus.org>	
	<20050204203050.GA5889@dmt.cnet> <4203D793.1040604@nortel.com>	
	<1107595148.30302.5.camel@gaston> <42077EE0.2060505@nortel.com>
	<1107812101.7734.42.camel@gaston>
In-Reply-To: <1107812101.7734.42.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Benjamin Herrenschmidt wrote:

> Interesting... more than no swap, you must also make sure you have no
> r/w mmap'ed file (which are technically equivalent to swap).

Ah...thanks for the warning.

We want to eventually make it work with swap as well, but that's 
substantially more complicated.

> I'm not too fan about exporting those symbols, but I'll talk to paulus,
> it should be possible at least to EXPORT_SYMBOL_GPL them...

I understand the reluctance.  I'm perfectly willing to export it GPL in 
my private branch as long as you guys don't consider it evil--the module 
is going to be GPL anyways.

The alternative would be for me to build my code directly in to the 
kernel...just makes it harder for me to debug.

Chris
