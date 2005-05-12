Return-Path: <wd@denx.de>
Received: from mailout03.sul.t-online.com (mailout03.sul.t-online.com
	[194.25.134.81]) by ozlabs.org (Postfix) with ESMTP id 5F20667A3E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 May 2005 19:47:21 +1000 (EST)
To: "Peter Gehirnforce" <Gehirnmann@gmx.de>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 12 May 2005 11:13:38 +0200."
	<25101.1115889218@www45.gmx.net>
Date: Thu, 12 May 2005 11:47:07 +0200
Sender: wd@denx.de
Message-Id: <20050512094712.BBCC7C1512@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: ELDK/DENX: doesn't find iostream-lib when linking 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <25101.1115889218@www45.gmx.net> you wrote:
> I use a makefile with dependencies:

I asked for the COMMANDS used, not for a Makefile. A log of the build
process would have been more useful, but anyway...

> compiler = ${CROSS_COMPILE}gcc
...
> simple_client: $(simple_client_objects)
>         $(compiler) -o simple_client $(simple_client_objects)
> 
> #ppc_gcc dependencies, added for compiling with ppc only!!
> Socket:
>         $(compiler) -o Socket.o -c Socket.cpp
...

> Are they defined wrong?

You are using the wrong compiler. GCC is a C Compiler,  but  you  are
trying  to compile and link C++ code. GCC does not know how to handle
this. Please use a C++ compiler - i. e. "g++" - instead.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Unix is like a toll road on which you have to stop every 50  feet  to
pay another nickel. But hey! You only feel 5 cents poorer each time.
                 - Larry Wall in <1992Aug13.192357.15731@netlabs.com>
