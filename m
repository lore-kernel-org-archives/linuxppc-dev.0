Date: Sat, 1 Jul 2000 15:25:12 -0700
From: Daniel Jacobowitz <drow@false.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: (Manually) relocate PPC code?
Message-ID: <20000701152511.A32182@drow.them.org>
References: <200007011839.UAA29375@denx.local.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200007011839.UAA29375@denx.local.net>; from wd@denx.de on Sat, Jul 01, 2000 at 08:39:14PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jul 01, 2000 at 08:39:14PM +0200, Wolfgang Denk wrote:
>
> Hi,
>
> I need to write some C code on PPC which must stay relocatable, resp.
> I must relocate it myself (all of code and data etc.). I'm using GNU
> tools.
>
> This is for a standalone application, _NOT_ running under Linux.
>
> Where can I find documentation about things like the format of the
> GOT etc., or ideally existing _simple_ (read: small) example code?
>
> All hints, pointers, ideas appreciated - TIA!

It's not terribly small, but - you REALLY should read ld.so.1's source.
There may be more information in the ABI document floating around, too.

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
