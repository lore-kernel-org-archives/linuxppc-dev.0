To: leeyang <leeyang@ycig.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linux booting 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 26 Aug 2002 20:40:16 +0800."
             <000901c24cfd$de617140$0141b73d@leeyang>
Date: Mon, 26 Aug 2002 17:12:46 +0200
Message-Id: <20020826151251.7BB8811829@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

in message <000901c24cfd$de617140$0141b73d@leeyang> you wrote:
>
> > http://www.denx.de/doc/TQM8xxL/debugging.html
>
> I have read it before,but only for module or application,
> not for kernel and ppcboot,someone told me because of
> ppcboot's relocation,so it is difficult in some externd.

See the Q+A section

> However,new ones come:
> kernel can not find init in the ramdisk!
> the initrd had been tested in the old kernel and can mount fs
> and entering system.so a little strange:(
>
> the only reason I am wondering is the compiler!
> the file in the initrd were compiled with HHL1.2 ppc compiler.
> and the kernel was created with eldk.
> Is that make sense?

That should be no problem.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The nice thing about standards is, there are so many to choose from.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
