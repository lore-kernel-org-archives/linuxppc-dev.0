Message-ID: <3CA9FCCC.BF470D9C@lvl7.com>
Date: Tue, 02 Apr 2002 13:47:40 -0500
From: Neil Horman <nhorman@lvl7.com>
MIME-Version: 1.0
To: "barry.fisher" <barry.fisher@seranoa.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Does a Graphical Kernel Debugger exist for ppc?
References: <000001c1da76$ac29a110$7d0110ac@Seranoa.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi barry -
	When we do kernel debug here, we use either an Abatron BDI 2000 bdm debugger,
or build kgdb into the kernel itself.  Both soultions allow for an off-target
(host) gdb client connection, vi the gdb remote protocol via a network
connection or serial connection, respectively.  Since we can run gdb on the host
for these solutions, we have wrapped ddd around both with relatively good
success.
hope that helps!
Neil :)

"barry.fisher" wrote:
>
> Hello All:
> Being a newbie to the world of Linux kernel device driver debugging I
> was wondering whether a graphical kernel debugger exists for the power
> pc. Any help and guidance is greatly appreciated. Thanks in advance!
> Regards,
> Barry O. Fisher
> Seranoa Networks
> barry.fisher@seranoa.com
> 978-897-3434 x272
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
