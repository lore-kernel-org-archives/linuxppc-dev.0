To: Song Sam <samlinuxppc@yahoo.com.cn>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Cramfs Limitations 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 26 Aug 2004 18:08:27 +0800."
             <20040826100827.78542.qmail@web15603.mail.cnb.yahoo.com>
Date: Thu, 26 Aug 2004 17:12:41 +0200
Message-Id: <20040826151246.43D26C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20040826100827.78542.qmail@web15603.mail.cnb.yahoo.com> you wrote:
>
> Error in Step 7: Cannot load shared resource!

Use grep to find out who is printing this.

> INIT: can't open(/etc/ioctl.save,O_WRONLY):Permission
> denied!
>
> What's on earth with it?Could 2_4_devel or 2.6 fix it?

Are you really surprised that opening a file for writing fails  on  a
read-only filesystem???

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I program, therefore I am.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
