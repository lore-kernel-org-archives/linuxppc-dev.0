To: "XOL" <xol@mail.ru>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Re[4]: initrd problem. CRC Error. 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 09 Jun 2003 17:05:55 +0400."
             <E19PMLT-000Hhi-00.xol-mail-ru@f16.mail.ru>
Date: Mon, 09 Jun 2003 22:21:27 +0200
Message-Id: <20030609202132.A0579C5FD7@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <E19PMLT-000Hhi-00.xol-mail-ru@f16.mail.ru> you wrote:
>
> I think I found out what is a problem
> The thread bi_record and initrd
> http://lists.linuxppc.org/linuxppc-embedded/200211/msg00286.html
>
> Discuss the problem of corrupting initrd by bi_record - board info record.
> As I have no good background in bootloading could you please let me know
> 1. What is a current status of fixing the bug. Are there any
> new kernel version there it was fixed

Don't know. Never ran into this problem.

> 2. Does this problem depends on bootloader. Will u-boot fix it?

Yes, it probably depends on the bootloader. More exactly, itt depends
on the interface between the bootloader and the Linux kernel.

U-Boot works fine if your kernel is configured for U-Boot. I  am  not
aware of a problem that needs fixing.

> 3. Does anybody succeded to use 2.4.18 with initrd? How?

Yes, we did. Many times. We use  U-=Boot,  and  make  sure  that  the
kernel interface fits.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"That unit is a woman."
"A mass of conflicting impulses."
	-- Spock and Nomad, "The Changeling", stardate 3541.9

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
