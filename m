Date: Mon, 27 Mar 2000 08:09:59 -0700
From: Matt Porter <mmporter@home.com>
To: "Michael A. Peters" <mpeters@mac.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: compiling glibc
Message-ID: <20000327080959.A19040@cx258813-a.chnd1.az.home.com>
References: <v04220802b504667b9953@[192.168.0.2]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <v04220802b504667b9953@[192.168.0.2]>; from mpeters@mac.com on Mon, Mar 27, 2000 at 02:38:10AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Mar 27, 2000 at 02:38:10AM +0100, Michael A. Peters wrote:
>
> I'm having trouble compiling glibc-2.1.3
>
> I grabbed the source from ftp.gnu.org and added the linux-threads and
> crypt add ons. I am building the source from a seperate directory.
>
> When I give the make command, it chews away for awhile- and the exits
> with parsing errors on line 379 and 382 of C-ctype.c (in
> glibc-2.1.3/locale/)

A patch for this problem is at
http://members.home.net/mmporter/linux/cross/

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
