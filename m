To: Daris A Nevil <dnevil@snmc.com>
Cc: simitel0299 <simitel0299@sina.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Where get the Linux Init Source for 8xx 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 30 Mar 2001 08:46:57 MDT."
             <3AC49C61.D3B65EDE@snmc.com>
Date: Fri, 30 Mar 2001 17:30:11 +0200
Message-Id: <20010330153016.42E6728827@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3AC49C61.D3B65EDE@snmc.com> you wrote:
>
> You can also find CPU PWRUP code for the MPC850 in the QSLinux release,
> downloadable from ftp://qslinux.org.  It contains code to "kick" the
> watchdog as it decompresses the kernel.  It also provides a very

This is available in PPCBoot as a configurable option,  too  (and  we
have  submitted  a  watchdog  driver  for  Linux  2.4.x to the kernel
maintainers).

And PPCBoot is not limited to the 850.

> flexible scheme for configuring processor clock speed, console port

Everything (and more) is available in PPCBoot, too.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"I like your game but we have to change the rules."

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
