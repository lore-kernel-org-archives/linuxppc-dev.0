Return-Path: <domen.puncer@telargo.com>
Received: from out002.atlarge.net (out002.atlarge.net [129.41.63.60])
	by ozlabs.org (Postfix) with ESMTP id 7EFECDDDFA
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Mar 2007 17:54:16 +1100 (EST)
Date: Wed, 14 Mar 2007 07:54:11 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Problem in compiling a kernel module
Message-ID: <20070314065411.GD14658@moe.telargo.com>
References: <20070313043050.GB82243@server.idefix.lan>
	<513703.69187.qm@web302.biz.mail.mud.yahoo.com>
	<20070314043305.GB27011@server.idefix.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070314043305.GB27011@server.idefix.lan>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 14/03/07 05:33 +0100, Matthias Fechner wrote:
> Hello Ben,
> 
> * Ben Warren <bwarren@qstreams.com> [13-03-07 05:55]:
> > Is there any chance that you qualify private data as
> > __init within the driver?  Can you post the cleanup()
> > function and any private (static) functions that it
> > calls?
> 
> no problem, I attached the file. It is bery basic from now and it is
> not written very well, but it should have all necessary parts in it.
> 
> PS: It's not necessary to CC me I'm on the list :)
> 

...
> static int __initdata max6633_initialized = 0;

__initdata

> 
> void max6633_cleanup(void)
> {
>    int res;
>    if(max6633_initialized==1)

But you access it from non-init code.


	Domen
