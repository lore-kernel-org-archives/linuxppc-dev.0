Date: Tue, 8 Aug 2000 18:48:21 -0700
From: Daniel Jacobowitz <drow@false.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: php compilation fix
Message-ID: <20000808184821.A20816@drow.them.org>
References: <00080818110803.04184@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <00080818110803.04184@localhost.localdomain>; from mpeters@omnilinux.com on Tue, Aug 08, 2000 at 05:29:19PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Aug 08, 2000 at 05:29:19PM -0700, Michael A. Peters wrote:
>
> I created a patch that makes the changes suggest to php-4.0.1pl2/main/main.c
>
> replace
> args = orig_args;
> by:
> memcpy(args, orig_args, sizeof(orig_args));

I suspect you're looking for va_copy().


Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
