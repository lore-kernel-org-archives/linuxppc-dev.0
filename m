Subject: Re: cpu_setup_6xx.S:19:22: ppc_defs.h: No such file or directory
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Matthew S. McClintock" <mattsm@arlut.utexas.edu>
Cc: Christian <evil@g-house.de>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1074101770.23751.6.camel@chuck.arlut.utexas.edu>
References: <1074025766.23751.2.camel@chuck.arlut.utexas.edu>
	 <40048A4B.1040400@g-house.de>
	 <1074101770.23751.6.camel@chuck.arlut.utexas.edu>
Content-Type: text/plain
Message-Id: <1074131648.5123.48.camel@gaston>
Mime-Version: 1.0
Date: Thu, 15 Jan 2004 12:54:54 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2004-01-15 at 04:36, Matthew S. McClintock wrote:
> The file does not even get created. I can copy it over from another
> linux tree that worked before and put it in the current linux tree and
> everything works. It always craps out on that one file, would that still
> indicate some sort of hardware problem?

That is WRONG

That file has to be created as part of the kernel build process, the
offsets in there are different depending on various things like
kernel version, compiler version, kernel config options, just copying
it from another kernel may result into interesting random kernel
behaviour...

If it's not created for you, then something is wrong in your build
process, or you source tree contains crap or whatever. It definitely
works fine with the upstream sources.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
