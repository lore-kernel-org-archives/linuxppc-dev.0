Message-ID: <00c401c04bb1$dbf78420$57c809c0@fel>
Reply-To: "john zhan" <johnzhan@btamail.net.cn>
From: "john zhan" <johnzhan@btamail.net.cn>
To: <linuxppc-embedded@lists.linuxppc.org>
Cc: "Daris A Nevil" <dnevil@snmc.com>,
        "Cal Erickson" <cal_erickson@mvista.com>
References: <006001bf448c$4aee3aa0$57c809c0@fel> <3A0BFE46.A7366165@snmc.com>
Subject: Re: GDB for host development platform
Date: Sat, 11 Nov 2000 15:34:32 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thank you, Daris and Cal, for your reponse.
I believe cross-debugger is good way,no mater the
connection method, serial or Ethernet.
My point is the native debugger targeted exec-file.
The background of my idea is that I will build a new
 ppc system which have all necessary peripheral including
a harddisk, keyboard ,  graphics device and other
standard port.
Base this platform to develop embedded applications,
In fact,I am afraid I will break the traditional development
 mode ,discard the host machine, combine host and  target
 physically, all in one,  like programming in linux/pc.
 I think it can be easy acceptable.
So,I hope GDB can work with exec-file target in a standalone
linux/ppc machine.
It is the worst news that GDB is not ready for linux/ppc exec-file target.
Can someone tell me more about this?
But I can still use GDB targeted extended-remote in native environment.right?

Thanks in advance.

john zhan.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
