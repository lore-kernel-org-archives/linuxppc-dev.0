Date: Thu, 8 Jul 2004 18:48:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jean-Christophe Dubois <jdubois@mc.com>
Cc: Bret Indrelee <Bret.Indrelee@qlogic.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: proposed patch for cross compiling from Solaris 2.8
Message-ID: <20040709014853.GQ23135@smtp.west.cox.net>
References: <Pine.LNX.4.44.0407060823120.2040-100000@spider.ancor.com> <1089121664.31278.264.camel@fr-jdubois1.ad.mc.com> <1089125860.18578.12.camel@fr-jdubois1.ad.mc.com> <1089279330.18578.2175.camel@fr-jdubois1.ad.mc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1089279330.18578.2175.camel@fr-jdubois1.ad.mc.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jul 08, 2004 at 11:35:31AM +0200, Jean-Christophe Dubois wrote:

>
> Hello,
>
> I rewrote my patches to be a little more well behaved in regards to non
> linux systems.
>
> Any feedback is welcome. Once again this is just to enable Solaris 2.8
> (and others?) to be a valid host to cross-compile the 2.6 Linux Kernel
> (for PPC).

Sadly, it looks like Cygwin (the other odd host to build a linux kernel on)
lacks <inttypes.h>.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
