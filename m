Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id D248968583
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Oct 2005 08:37:28 +1000 (EST)
Date: Wed, 26 Oct 2005 15:02:05 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-ID: <20051026220205.GH26475@smtp.west.cox.net>
References: <20051026133648.GA10373@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051026133648.GA10373@logos.cnet>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Makefile check for older binutils broken?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 26, 2005 at 11:36:48AM -0200, Marcelo Tosatti wrote:
> 
> Hi,
> 
> While trying to compile 2.6.14-rc4 on my Pegasos (running Debian unstable):
> 
> make[2]: Entering directory `/home/marcelo/8xx/linux-2.6.14-rc4'
> *** 2.6 kernels no longer build correctly with old versions of binutils.
> *** Please upgrade your binutils to 2.12.1 or newer
> make[2]: *** [checkbin] Error 1

What's your CONFIG_SHELL set to?

[snip]
> marcelo@pegasos:~$ /bin/echo dssall | as -many -o /tmp/output.as >/dev/null 2>&1
> marcelo@pegasos:~$ echo $?

What about if you run the whole test on shell (if ...), does it work there? 
What shell are you running?

-- 
Tom Rini
http://gate.crashing.org/~trini/
