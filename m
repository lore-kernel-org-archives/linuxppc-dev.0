To: "zhongqx" <zhongqx@guoguang.com.cn>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Why FEC and SCC1 can not work at the same time? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 17 Sep 2002 15:49:44 +0800."
             <001001c25e1e$c9c33ac0$7301a8c0@zhongqx>
Date: Tue, 17 Sep 2002 22:10:35 +0200
Message-Id: <20020917201041.09711FA8D@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <001001c25e1e$c9c33ac0$7301a8c0@zhongqx> you wrote:
>
> I want to use FEC(100M) and SCC1(10M) interface,but they can not work together.

They can.

> eth0: CPM ENET Version 0.2 on SCC1, 00:d0:93:00:12:34
> eth1: FEC ENET Version 0.2, FEC irq 3, MII irq 4, addr 00:d0:93:80:12:34

Please be aware that both interfaces use the same MAC  address.  This
is ok as long as you don;t try to connect bioth to the same subnet.

> VFS: Mounted root (ext2 filesystem).
> Freeing unused kernel memory: 40k init
> init started:  BusyBox v0.60.2 (2002.07.18-17:16+0000) multi-call SIOCADDRT: Net
> work is unreachable
>
>     ******(What reason ? when this message output?)

Well, it  makes  little  sense  to  guess  how  you  ifconfig'ed  the
interfaces, please provide more information.

My bet is that you tired to run  both  ethernet  ports  in  the  same
network,  and  that  you're  experiencing  a  conflict  caused by two
identical MAC addresses.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"I find this a nice feature but it is not according to  the  documen-
tation. Or is it a BUG?"   "Let's call it an accidental feature. :-)"
                       - Larry Wall in <6909@jpl-devvax.JPL.NASA.GOV>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
