Message-ID: <3B66B2DE.CD888C9F@seranoa.com>
Date: Tue, 31 Jul 2001 09:30:06 -0400
From: Andrew Dixon <andrew.dixon@seranoa.com>
MIME-Version: 1.0
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: HHL 2.0 login problem
References: <200107310901.CAA02948@krakatoa.gigabitnetworks.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi James,
James F Dougherty wrote:
>
> INIT: version 2.78 booting
> eth0: Setting full-duplex based on MII#0 link partner capability of 45e1.
> INIT: Entering runlevel: 2
>
> Linux 2.0 (linux-2.4.2_hhl20)
>
> mousse login: root
> PAM_unix[14]: (login) session opened for user root by (uid=0)
>
> Linux 2.0 (MontaVista HLL2.0)
>
> MOUSSE/MPC8240
>
> login[14]: unable to change tty `/dev/console' for user `root'
>
> Unable to change tty /dev/console: Illegal seek
>
>

What do /dev/console and /dev/tty[0-7] look like (ls -l)?

Look in /usr/src/linux/Documentation/devices.txt for a description of
these devices (be sure to read the section TERMINAL DEVICES).

You should also checkout /etc/inittab.  The last few lines in there
spawn gettys to handle the terminal connection.

hth,
Andy

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
