Date: Mon, 29 Oct 2001 19:08:41 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Mark Pilon <mpilon@midrivers.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: trying to build latest devel <cramfs>
Message-ID: <20011029190841.G9925@cpe-24-221-152-185.az.sprintbbd.net>
References: <3BDDA382.1172104F@midrivers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BDDA382.1172104F@midrivers.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Oct 29, 2001 at 11:44:18AM -0700, Mark Pilon wrote:

> trying to build for walnut, w/ cramfs enabled under
> filesystems, compressed rom-based filesystem
>
> I get:
> uncompress.c:21: linux/zlib_fs.h: No such file or directory
>
> any idea where this went or if there's a Plan for future
> support of this ?

Quite possibly because the inflate stuff under cramfs just got moved.
Post this on linux-kernel or try 2.4.14-pre4 (soon to be pre5).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
