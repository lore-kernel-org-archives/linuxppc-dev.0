Message-ID: <3A100490.C279AEC@mvista.com>
Date: Mon, 13 Nov 2000 07:11:12 -0800
From: Cal Erickson <cal_erickson@mvista.com>
Reply-To: cal_erickson@mvista.com
MIME-Version: 1.0
To: john zhan <johnzhan@btamail.net.cn>
CC: linuxppc-embedded@lists.linuxppc.org, Daris A Nevil <dnevil@snmc.com>
Subject: Re: GDB for host development platform
References: <006001bf448c$4aee3aa0$57c809c0@fel> <3A0BFE46.A7366165@snmc.com> <00c401c04bb1$dbf78420$57c809c0@fel>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


John,
If you want to do that check out MontaVista again.
There is both a cross development and native
version of gdb on the product. The version of GDB
is 5.0.
Cal

john zhan wrote:

> Thank you, Daris and Cal, for your reponse.
> I believe cross-debugger is good way,no mater the
> connection method, serial or Ethernet.
> My point is the native debugger targeted exec-file.
> The background of my idea is that I will build a new
>  ppc system which have all necessary peripheral including
> a harddisk, keyboard ,  graphics device and other
> standard port.
> Base this platform to develop embedded applications,
> In fact,I am afraid I will break the traditional development
>  mode ,discard the host machine, combine host and  target
>  physically, all in one,  like programming in linux/pc.
>  I think it can be easy acceptable.
> So,I hope GDB can work with exec-file target in a standalone
> linux/ppc machine.
> It is the worst news that GDB is not ready for linux/ppc exec-file target.
> Can someone tell me more about this?
> But I can still use GDB targeted extended-remote in native environment.right?
>
> Thanks in advance.
>
> john zhan.

--
===========================================================================
Cal Erickson                 MontaVista Software Inc.
Customer Support Engineer    490 Potrero Avenue
Phone (408) 328-0304         Sunnyvale CA 94085
Fax   (408) 328-9204         e-mail cal_erickson@mvista.com
Pager 877-566-2012           support 1-800-759-8888 pin 202-7489
web http://www.mvista.com    support e-mail: support@mvista.com
eCode: http://cal@work.com.ecode.com
===========================================================================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
