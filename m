Return-Path: <jeff@theptrgroup.com>
Received: from mail.theptrgroup.com (mail.theptrgroup.com [209.183.211.17])
	by ozlabs.org (Postfix) with ESMTP id E1A1C67A2C
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Feb 2005 23:33:30 +1100 (EST)
From: Jeff Angielski <jeff@theptrgroup.com>
To: ning <ningmin@yahoo.co.jp>
In-Reply-To: <20050128100238.27631.qmail@web606.mail.yahoo.co.jp>
References: <20050128100238.27631.qmail@web606.mail.yahoo.co.jp>
Content-Type: text/plain
Message-Id: <1107347293.9091.13.camel@nighteyes.localdomain>
Mime-Version: 1.0
Date: Wed, 02 Feb 2005 07:28:13 -0500
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Serial console problem on MPC8272ADS board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2005-01-28 at 05:02, ning wrote:

> I added SCC4 to rs_table as following:
> static struct serial_state rs_table[] = {
> 	/* UART CLK   PORT          IRQ      FLAGS  NUM */
> 	{ 0,     0, PROFF_SCC1, SIU_INT_SCC1,   0,   (0 |
> NUM_IS_SCC) }, /* SCC1 ttyS0 */
> 	{ 0,     0, PROFF_SCC4, SIU_INT_SCC4,   0,   (3 |
> NUM_IS_SCC) }, /* SCC4 ttyS1 */
> };

Did you configure the SCC4 I/O pins correctly?

Have you programmed the BRGs correctly?  Does it match what is routed to
SCC4 in the CMX registers?

When booting using SCC1 as the console, can you read and write data
using SCC4?  If not, you should get this working and then worry about
configuring it as the console.


Jeff Angielski
The PTR Group
