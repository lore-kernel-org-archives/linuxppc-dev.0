Subject: Re: cpu_setup_6xx.S:19:22: ppc_defs.h: No such file or directory
From: "Matthew S. McClintock" <mattsm@arlut.utexas.edu>
To: Christian <evil@g-house.de>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <40048A4B.1040400@g-house.de>
References: <1074025766.23751.2.camel@chuck.arlut.utexas.edu>
	 <40048A4B.1040400@g-house.de>
Content-Type: text/plain
Message-Id: <1074101770.23751.6.camel@chuck.arlut.utexas.edu>
Mime-Version: 1.0
Date: Wed, 14 Jan 2004 11:36:11 -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The file does not even get created. I can copy it over from another
linux tree that worked before and put it in the current linux tree and
everything works. It always craps out on that one file, would that still
indicate some sort of hardware problem?

Matthew

On Tue, 2004-01-13 at 18:16, Christian wrote:
> Matthew S. McClintock wrote:
> | I have a problem with the kernel build. It seems completely random in
> | occurrence, however I'm sure something has to be causing it.The error is
> | as follows:
> |
> | cpu_setup_6xx.S:19:22: ppc_defs.h: No such file or directory
> |
> | And the kernel build can not complete. Sometimes running a make dep and
> | continuing again with a make uImage will correct the problem but not
> | always. Does anyone have any idea why sometimes this file does not get
> | built correctly and other times it does?
>
> filesystem / memory corruption, even slightly overclocking the cpu, too
> old / too new compiler or binutils.
> when the error occurs, can you actually stat ppc_defs.h ?
>
> Christian.
> - --
> BOFH excuse #200:
>
> The monitor needs another box of pixels.
>
--
Matthew S. McClintock <mattsm@arlut.utexas.edu>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
