Message-ID: <000b01bfe30e$01f90ed0$57c809c0@nt4srv87>
Reply-To: "john zhan" <r3587@sina.com>
From: "john zhan" <r3587@sina.com>
To: "Kwansuk Kim" <kskim@neowave.co.kr>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <NEBBKFENMLEDKDHMEHPJKEPECAAA.kskim@neowave.co.kr>
Subject: Re: network toolsl don't still work...
Date: Sat, 1 Jul 2000 11:39:34 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi,kim
Try put libnss_files.so.2 in your /lib.

b.r.
john zhan.

----- Original Message -----
From: Kwansuk Kim <kskim@neowave.co.kr>
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Sent: Thursday, July 13, 2000 11:38 AM
Subject: network toolsl don't still work...


>
> Thanks for you cooperation.
>
> When I make soft link from /lib to /opt/.../lib, bash can read the library files.
>
> But ping program doesn't work yet.
>
> I mounted proc file system 'mount none /proc -t proc' and in /etc directory, there are protocols, services file.
>
> -------
> init-2.03# ls -l /etc
> total 446
> -rw-r--r--   1 0        0              32 Jul 12  2000 fstab
> -rw-r--r--   1 0        0            2882 Jul 12  2000 inetd.conf
> -rw-r--r--   1 0        0              23 Dec 31 16:37 mtab
> -rw-r--r--   1 0        0            1186 Jul 12  2000 protocols
> -rw-r--r--   1 0        0           11172 Jul 12  2000 services
> -rw-r--r--   1 0        0          434898 Jul 12  2000 termcap
> init-2.03#cat /etc/protocols
> # /etc/protocols:
> # : protocols,v 1.1 1995/02/24 01:09:41 imurdock Exp $
> #
> # Internet (IP) protocols
> #
> #       from: @(#)protocols     5.1 (Berkeley) 4/17/89
> #
> #
>
> ip      0       IP              # internet protocol, pseudo protocol number
> icmp    1       ICMP            # internet control message protocol
> igmp    2       IGMP            # Internet Group Management
> ggp     3       GGP             # gateway-gateway protocol
> ipencap 4       IP-ENCAP        # IP encapsulated in IP (officially IP'')
> st      5       ST              # ST datagram mode
> tcp     6       TCP             # transmission control protocol
> egp     8       EGP             # exterior gateway protocol
> pup     12      PUP             # PARC universal packet protocol
> ....
>
> and ping, librara, kernel are compiled with same compiler.
>
> But the message still comes out
>
> ----------
>
> init-2.03# ping 127.0.0.1
> ping: unknown protocol icmp.
> init-2.03#
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
