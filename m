From: linas@austin.ibm.com
Date: Mon, 1 Mar 2004 16:38:44 -0600
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linuxppc-dev@lists.linuxppc.org, benh@kernel.crashing.org
Subject: Re: 64-bit user-space on G5? Never, soonish, or unknown?
Message-ID: <20040301163844.G74832@forte.austin.ibm.com>
References: <1078010187.2233.105.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1078010187.2233.105.camel@cube>; from albert@users.sourceforge.net on Sat, Feb 28, 2004 at 06:16:28PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Albert,

On Sat, Feb 28, 2004 at 06:16:28PM -0500, Albert Cahalan wrote:
>
> Benjamin Herrenschmidt writes:
>
> > The 64 bits kernel allow you to run both 32 and
> > 64 bits userland, the common practice is to have
> > a 32 bit userland with the necessary libs to be
> > able to build & run _some_ 64 bits executables.
>
> You'd better have a 64-bit ncurses. If you don't,
> your procps will be compiled incorrectly. Data
> will get truncated, mangled, etc. -- assuming you
> can even run the tools at all.

? My ps, top, w all work fine:

linas@panic:~> file /usr/bin/top
/usr/bin/top: ELF 32-bit MSB executable, PowerPC or cisco 4500, version 1 (SYSV), dynamically linked (uses shared libs), stripped
linas@panic:~> file /bin/ps
/bin/ps: ELF 32-bit MSB executable, PowerPC or cisco 4500, version 1 (SYSV), dynamically linked (uses shared libs), stripped

They've been running fine, with all manner of mangled and hacked
2.4 and 2.6 kernels.

--linas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
