Message-Id: <199901112138.WAA05948@denx.muc.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: linuxppc-dev@lists.linuxppc.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: MBX860: How to boot with initrd ? 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 11 Jan 1999 11:42:51 +0100."
             <19990111114251.006245@smtp.calvacom.fr>
Date: Mon, 11 Jan 1999 22:38:08 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <19990111114251.006245@smtp.calvacom.fr> you write:
> 
> >You mean ftp://ftp.linuxppc.org/gary/redhat/RPMS/ppc/egcs*-1.1*ppc.rpm ?
> >
> >They don't work for me - same result: no problems during compilation,
> >but the kernel hangs.
> >
> >So far the only reliably working version of EGCS for me is the one in
> >linuxppc-R4 :-(
> 
> Almost all the kernels I compile are with this version of egcs without
> any problem... They work just fine. Maybe egcs breaks something specific
> to your machine ? Are you using PReP or PowerMac ?

I've run some verification tests with  above  packages  and  my  home
built  cross  compiler  based  on egcs-1.1.1: the plain MBX860 kernel
boots fine, but it hangs as soon as I  try  to  use  initrd  as  root
device.

So better be careful when you use these new compilers :-(

Wolfgang

-- 
Phone:  (+49)-89-95720-110   Fax: (+49)-89-95720-112   wd@denx.muc.de
Office: (+49)-89-722-27328               Wolfgang.Denk@ICN.Siemens.DE
Quote from the Boss... "I didn't say it was your fault.  I said I was
going to blame it on you."

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
