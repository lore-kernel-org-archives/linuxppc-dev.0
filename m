Return-Path: <rpjday@mindspring.com>
Received: from falcon.mail.pas.earthlink.net (falcon.mail.pas.earthlink.net
	[207.217.120.74]) by ozlabs.org (Postfix) with ESMTP id B2FEB2BDB4
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Sep 2004 12:13:20 +1000 (EST)
Date: Wed, 29 Sep 2004 22:06:36 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Robin Gilks <robin.gilks@tait.co.nz>
In-Reply-To: <415B4E5F.6040107@tait.co.nz>
Message-ID: <Pine.LNX.4.60.0409292205200.20578@localhost.localdomain>
References: <415B4E5F.6040107@tait.co.nz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: ppc embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: Status of uart driver on mpc8xx in 2.6
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 30 Sep 2004, Robin Gilks wrote:

> Greetings
>
> Could anyone point me to a uart driver for mpc8xx as the one in 2.6.8.1 
> obviously has not been hacked from the 2.4 variant since it still contains 
> references to DECLARE_TASK_QUEUE and other things that have changed.
>
> I'm sure there is a ppc 'special' tree that has all the necessary fixes but 
> with this list disappearing for a while I've rather lost track of what is 
> where!!

as i understand it, the source file arch/ppc/8xx_io/uart.c is no 
longer used.  you'll find the uart stuff in drivers/serial/cpm_uart, i 
think.  at least, that's where i'm messing with the code.

rday
