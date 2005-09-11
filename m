Return-Path: <a.othieno@bluewin.ch>
Received: from mail15.bluewin.ch (mail15.bluewin.ch [195.186.18.63])
	by ozlabs.org (Postfix) with ESMTP id 75F3C68224
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Sep 2005 03:40:41 +1000 (EST)
Date: Sun, 11 Sep 2005 13:41:21 -0400
To: Nuguru Susheel <susheel.nuguru@mitron.fi>
Message-ID: <20050911174121.GA3177@mars>
References: <1126102465.14131.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1126102465.14131.16.camel@localhost.localdomain>
From: a.othieno@bluewin.ch (Arthur Othieno)
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: newbie question : how to register for a new interrupt
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Sep 07, 2005 at 02:14:25PM +0000, Nuguru Susheel wrote:
> Hi all,
> 
>    I have written an service routine for handling the GPIO_WAKEUP
> interrupt PSC2_4 pin (MPC5200 Core), but I donno how to register this
> routine into the kernel. 

request_irq/free_irq() are what you're looking for.
See include/linux/interrupt.h for the details.

	Arthur
