Date: Wed, 23 Apr 2003 08:30:15 -0400
From: Martin Hicks <mort@bork.org>
To: Aman <aman@mistralsoftware.com>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Serial Console Login Fails
Message-ID: <20030423123015.GI553@bork.org>
References: <001301c3093d$ad9c69f0$370da8c0@aman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <001301c3093d$ad9c69f0$370da8c0@aman>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Apr 23, 2003 at 07:41:40AM +0530, Aman wrote:
>
> Hi All
>
> I am using IBM PPC 440 processor on custom board , which has no network
> support. I am using Monta Vista Linux with ramdisk enabled. In the ramdisk ,
> I have very less files. Since there is no network on the board , I am trying
> to enable the serial console login. To achieve this, I disabled serial
> console logging by saying "console=NULL " in the cmdline and in the
> /etc/inittab file added this line

If the kernel is compiled with CONFIG_SERIAL_CONSOLE then you can
do  "console=ttyS0", which will give you a 9600bps 8n1 serial console to
see the kernel boot messages.

> "T0:23:respawn:/sbin/getty -L ttyS0 9600 vt100"
> Bcos of which during the linux bootup , there wont be console message on the
> screen , after some time , there is a login prompt
> <none>login:
> If I try login then it waits for some seconds and then display the same i.e
> <none>login:

You don't have "ttyS0" in /etc/securetty

mh

--
Martin Hicks  ||  mort@bork.org  || PGP/GnuPG: 0x4C7F2BEE
plato up 5 days, 21:20, 12 users,  load average: 0.49, 0.50, 0.46
Beer: So much more than just a breakfast drink.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
