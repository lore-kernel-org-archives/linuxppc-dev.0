Subject: Re: cpu_setup_6xx.S:19:22: ppc_defs.h: No such file or directory
From: "Matthew S. McClintock" <mattsm@arlut.utexas.edu>
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Christian <evil@g-house.de>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <200401151925.24746.hollisb@us.ibm.com>
References: <1074025766.23751.2.camel@chuck.arlut.utexas.edu>
	 <1074131648.5123.48.camel@gaston>
	 <1074186989.23751.9.camel@chuck.arlut.utexas.edu>
	 <200401151925.24746.hollisb@us.ibm.com>
Content-Type: text/plain
Message-Id: <1074198036.23751.17.camel@chuck.arlut.utexas.edu>
Mime-Version: 1.0
Date: Thu, 15 Jan 2004 14:20:37 -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2004-01-15 at 13:25, Hollis Blanchard wrote:
> Just a guess, but I don't think 2.4 trees work perfectly with parallel builds
> (make -jN). It could be that one build needs ppc_defs.h before the other has
> created it yet.

This appears to be the problem. I am compiling this kernel on a dual cpu
machine and I suppose make takes the liberty of running in -j2 mode.
Running make with the -j1 option fixes the problem.

Thanks everyone for the help

--
Matthew S. McClintock <mattsm@arlut.utexas.edu>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
