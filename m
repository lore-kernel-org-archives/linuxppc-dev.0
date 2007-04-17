Return-Path: <bgat@billgatliff.com>
Message-ID: <46250034.7000202@billgatliff.com>
Date: Tue, 17 Apr 2007 12:13:24 -0500
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Laurent Pinchart <laurent.pinchart@technotrade.biz>
Subject: Re: Compiling interrupt controller code as a module
References: <200704171731.43608.laurent.pinchart@technotrade.biz>
In-Reply-To: <200704171731.43608.laurent.pinchart@technotrade.biz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Laurent Pinchart wrote:
> Hi everybody.
>
> I wrote a kernel driver for a custom bus (using arch/ppc). The hardware has a 
> cascaded interrupt controller wired to one of the CPU interrupts. The 
> interrupt controller IRQ handler calls __do_IRQ() to dispatch interrupts.
>
> Everything worked fine until I tried to compile the code as a module because 
> __do_IRQ() is not exported. Is there a way to compile an interrupt controller 
> as a module, or must it be included in the kernel ?
>   


Could you just export __do_IRQ()?


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com
