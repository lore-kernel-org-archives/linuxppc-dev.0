To: Jeff Stevens <jsteve17@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: SMC1 Uart Problems on 2.4.24-pre2 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 09 Feb 2004 07:43:44 PST."
             <20040209154344.65077.qmail@web41401.mail.yahoo.com>
Date: Mon, 09 Feb 2004 17:20:19 +0100
Message-Id: <20040209162024.CD278C108D@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20040209154344.65077.qmail@web41401.mail.yahoo.com> you wrote:
>
> I am trying to update to kernel version 2.4.24 from
> linux_2_4_devel from the denx site on my MPC855T
> system.  I got everything to compile, but I am having
> problems getting the console to work on SMC1 with
> 2.4.24 (it works fine with 2.4.4).  I get the
...
> Here are some snippets from my .config file:
...
> CONFIG_SERIAL=y

Do not enable this!! You don't have standard PC serial ports on  your
board.

> Am I configuring something wrong?

Yes.

Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Is truth not truth for all?
	-- Natira, "For the World is Hollow and I have Touched
		   the Sky", stardate 5476.4.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
