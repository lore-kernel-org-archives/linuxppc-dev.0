Message-ID: <3E38E3C8.5020203@imc-berlin.de>
Date: Thu, 30 Jan 2003 09:35:20 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Keith Outwater <Keith_Outwater@microvision.com>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: I2C RTC with MPC8xx?
References: <AFA2797FA126FD46B8CD281F2809844E0197DB@taurus.primary.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Keith Outwater schrieb:
> Hi Stephen -
>
> I am successfully using a DS1337 RTC with PPCBoot/U-Boot and a
> linux-2.4.4-10-06 kernel from the Denx FTP site. I haven't gotten around
> to submitting it, but let me know if you want the patch.

I actually wouldn't mind! :o)

I guess it's not to hard to put it onto 2.4.20.
Yesterday I received a file from Jocke. I would be more than happy to compare them.

Maybe Wolfgang is putting that on his 2.4.20 CVS someday!

BTW I think I'll need the DS1307. Hope it's only a differnt pinout. It has a
dedicated battery pin and no irq output.

Is the driver or linux using RTC interrupts?

Thanks a million,

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
