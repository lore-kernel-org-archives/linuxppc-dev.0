To: rekha gvv <rekhagvvc@yahoo.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ZImage.initrd 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 17 Oct 2003 00:07:20 PDT."
             <20031017070720.61838.qmail@web8204.mail.in.yahoo.com>
Date: Sat, 18 Oct 2003 22:59:31 +0200
Message-Id: <20031018205936.5459BC59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20031017070720.61838.qmail@web8204.mail.in.yahoo.com> you wrote:
>
> I want to boot linux using the zImage.initrd file.
...
> i downloaded it using ppcboot.

PPCBoot does not use the zImage.initrd images format.

> go 200000

PPCBoot does not use "go" to boot Linux images (it uses  the  "bootm"
command instead).

> Why does the system crash if i tell go 200000 and then
> it just hangs at go 210000

Because you did not read any of the available documentation like  the
RAEDME file that comes with code?

> please tell me how to boot an zImage.initrd.

You don't. With PPCboot / U-boot you will use the "mkimage"  tool  to
create a special image format.

> and also i have a confusion as to what is the
> difference between vmlinux and zvmlinux kernel that is
> found in the mbxboot directory.

Well, read the command output that gets printed when you run  "make",
and you will see.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If the facts don't fit the theory, change the facts.
                                                   -- Albert Einstein

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
