To: j.rakesh@gdatech.co.in
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: couldn't find the kernel version the module was compiled for 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 20 Oct 2003 18:35:34 +0530."
             <200310201305.IAA20143@lists.linuxppc.org>
Date: Mon, 20 Oct 2003 17:08:30 +0200
Message-Id: <20031020150835.A5B21C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200310201305.IAA20143@lists.linuxppc.org> you wrote:
>
> I am working on mpc8245 based board. I ahve compiled he rtc driver as a
> seperate modules. I have 2 function in assembly file i2c2.S. Its getting
> compiled but when I am inserting the module I am getting the above mentioned
> error.

And you are absolutely sure that what you use is Linux kernel code?

> i2c2.o: couldn't find the kernel version the module was compiled for
> x1226.o: Unresolved symbol load_runtime_reg
> x1226.o: Unresolved symbol store_runtime_reg
...

> How can I avoid this.

To mee it seems as if you used a source file which was  not  intended
for  use  with the Linux kernel, and adopted it for this purpose, but
poorly. You don't mention how you build your kernel module, s owe can
only speculate that there is either a problem with your source  code,
or  (more likely) with the way you compile and link your source files
into a module (like bad and/or missing compiler / linker options).

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
He'd been wrong, there _was_ a light at the end of the tunnel, and it
was a flamethrower.                         - Terry Pratchett, _Mort_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
