Return-Path: <kelsey@codemonkey.net>
Received: from z.codemonkey.net (z.codemonkey.net [64.142.120.45])
	by ozlabs.org (Postfix) with ESMTP id 2DAA4679FB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Sep 2006 16:44:17 +1000 (EST)
Date: Wed, 20 Sep 2006 00:20:04 -0600
From: Kelsey Dawes <kelsey@codemonkey.net>
To: Steven Hein <ssh@sgi.com>
Subject: Re: JTAG debugger for MPC82xx/MPC83xx
Message-ID: <20060920062004.GS29707@nimrod.unx.ca>
References: <4510664B.2020304@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4510664B.2020304@sgi.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Sep 19, 2006 at 04:51:07PM -0500, Steven Hein wrote:
> Hi,

Hi,

<SNIP>

> We will definitely want one with a network connection,
> and will will run the debugger software from a Linux host.
> Ideally, we would also like one that provides a library
> to allow us to write apps to function the debugger.
> 
> Can anyone comment on what JTAG debugger they are using,
> and how have your experiences been?   Are there any other
> good options besides the ones mentioned above.
> I'd appreciate any input.
> 
> Thanks!
> Steve

We've been using the BDI-2000 from abatron on an 8248 board.  It's done 
everything we've needed to do so far.  

It has a serial interface, but we use the ethernet port.
Remote debug works well, and other usual tasks also - flash programming, etc. 

Can't comment about developing apps for the debugger, sorry.

-kelsey
