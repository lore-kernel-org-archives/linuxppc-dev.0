Date: Tue, 27 Jul 2004 10:47:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Giuliano Pochini <pochini@shiny.it>, Olaf Hering <olh@suse.de>
Cc: LinuxPPC-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Can't compile 2.6.7 with gcc 3.4.1
Message-ID: <20040727174707.GB10891@smtp.west.cox.net>
References: <20040726223832.3edafe0a.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040726223832.3edafe0a.pochini@shiny.it>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jul 26, 2004 at 10:38:32PM +0200, Giuliano Pochini wrote:

>
> Is this a known problem ?  I can't compile the kernel 2.6.7 with gcc 3.4.1:

You're trying to use gcc-3.4 and binutils-2.14, which is a bad
combination.

Olaf, did you ever get a chance to try the last patch I had with your
matrix of toolchain versions?

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
