Subject: Re: cpu_setup_6xx.S:19:22: ppc_defs.h: No such file or directory
From: "Matthew S. McClintock" <mattsm@arlut.utexas.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christian <evil@g-house.de>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1074131648.5123.48.camel@gaston>
References: <1074025766.23751.2.camel@chuck.arlut.utexas.edu>
	 <40048A4B.1040400@g-house.de>
	 <1074101770.23751.6.camel@chuck.arlut.utexas.edu>
	 <1074131648.5123.48.camel@gaston>
Content-Type: text/plain
Message-Id: <1074186989.23751.9.camel@chuck.arlut.utexas.edu>
Mime-Version: 1.0
Date: Thu, 15 Jan 2004 11:16:29 -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2004-01-14 at 19:54, Benjamin Herrenschmidt wrote:

> That is WRONG
>
> That file has to be created as part of the kernel build process, the
> offsets in there are different depending on various things like
> kernel version, compiler version, kernel config options, just copying
> it from another kernel may result into interesting random kernel
> behaviour...
>
> If it's not created for you, then something is wrong in your build
> process, or you source tree contains crap or whatever. It definitely
> works fine with the upstream sources.
>

Well it is from the same kernel tree and same config, I just copy it
because sometimes the current tree does not make that file correctly. I
don't know what else to do, does anyone have any idea why my tree is not
building this file every time correctly in the first place?

Thanks,
Matthew

--
Matthew S. McClintock <mattsm@arlut.utexas.edu>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
