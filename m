Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Improve the make install target 
In-Reply-To: Your message of "Tue, 24 Jul 2007 15:14:52 +1000."
	<20070724051452.GA28851@localhost.localdomain>
References: <20070724051452.GA28851@localhost.localdomain> 
Date: Wed, 25 Jul 2007 10:29:33 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IDint-0003Fn-N1@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> This patch makes various improvements to dtc's make install target:
> 	- libfdt is also installed.  Specifically, libfdt.a and the
> two export relevant header files, fdt.h and libfdt.h are installed.
> 	- ftdump is no longer installed.  It was only ever a
> development debugging tool and may well go away at some point.
> 	- In keeping with normal conventions, there is now a PREFIX
> variable, allowing control of where things are installed (in /usr,
> /usr/local, /opt, etc.).
> 	- By default, installed into the user's home directory,
> instead of /usr.  This is friendlier for self-installers, package
> builders can easily override PREFIX to restore the old behaviour.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

Thanks,
jdl
