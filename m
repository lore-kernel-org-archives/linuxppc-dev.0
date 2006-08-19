Return-Path: <dan@embeddedalley.com>
In-Reply-To: <20060819065247.10235.qmail@web36608.mail.mud.yahoo.com>
References: <20060819065247.10235.qmail@web36608.mail.mud.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <04CDF080-8BF2-4381-969B-32D4B64A32A7@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: ioremap() twice on same memory mapped area?
Date: Sat, 19 Aug 2006 10:13:18 -0400
To: Parav Pandit <paravpandit@yahoo.com>
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 19, 2006, at 2:52 AM, Parav Pandit wrote:

> Question is:
> Can both the driver call the ioremap() on the same space and get  
> the different virtual address?

Yes, and depending upon the implementation and optimizations,
they may also get the same virtual address.  It will work as you
intend.


	-- Dan
