Date: Sat, 20 Jan 2001 22:26:30 +0100
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: mprotect broken on ppc
Message-ID: <20010120222630.B20689@suse.de>
References: <20010120221908.A20689@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010120221908.A20689@suse.de>; from olh@suse.de on Sat, Jan 20, 2001 at 10:19:08PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jan 20, Olaf Hering wrote:

>
> Hi,
>
> there seems to be a bug in mprotect which was introduced in
> test9->test10.
>
> The result is an invalid pointer from the getpwuid(3) function, this
> function is used in rpm to check owner and group permissions.

forgot some facts:

the build host runs always a glibc2.13 system with 2.2 headers. The
build chroot runs a glibc2.2 system with 2.4.0ac2 headers.
And it fails when a kernel 2.4.0-test10 or later is running, every other
kernel works fine.


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
