To: byf <byfmail@yeah.net>
Cc: embeded powerpc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: a simple question about ppcboot 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 17 May 2001 09:55:41 +0800."
             <20010517015601.437D91C9E8999@smtp2.yeah.net>
Date: Thu, 17 May 2001 08:20:51 +0200
Message-Id: <20010517062056.BE7B710AA0@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20010517015601.437D91C9E8999@smtp2.yeah.net> you wrote:
>
> I have a question about ppcboot,
> How should I set ethaddr for using tftpboot to load kernel image?

You better ask such questions on the PPCBoot mailing list.

Use the "setenv"  command  to  set  environment  variables,  and  the
"saveenv"  command to save the current settings in persistent storage
(Flash or EEPROM, depending on your hardware). So you type:

	=> setenv ethaddr xx:yy:zz:aa:bb:cc
	=> saveenv

Be careful to chose a VALID (unique, assigned to your board) address!

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
All men should freely use those seven words which have the  power  to
make any marriage run smoothly: You know dear, you may be right.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
