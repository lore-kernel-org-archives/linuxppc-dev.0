To: "rick.liu" <dovi@eyou.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Why my console output nothing 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "13 May 2003 16:05:15 +0800."
             <20030513160515.79677.qmail@eyou.com>
Date: Tue, 13 May 2003 15:46:07 +0200
Message-Id: <20030513134612.89CB7C6092@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Rick,

in message <20030513160515.79677.qmail@eyou.com> you wrote:
>
>       I am using ELDK to port linux to a simple MPC860T board. I use SMC1 to
> connect to the serial port and as the console.But I can't go any further
> because when i powerup,the console doesnot show any message.List my steps
> here:
>       1. edit ~/.kermrc as what was shown in <Denx ppcboot and linux
> Guide(tqm8xxl)>.
>       2. modify several line of  'TQM860L.h'.
>       3. modify my UPM table and register OR1/BR1 to OR4/BR4(my sdram uses
> cs4) in the file tqm8xx.c.
>       4. bash>make distclean.
>       5. bash>make TQM860L_config.
>       7. bash>make all
>       8. use a flash programmer to burn the u-boot.bin to my boot flash.


Only now it becomes clear that you are not talking about Linux at all.

Your posting is off topic in the linuxppc-embedded mailing list.

Chances for useful  replies  are  much  better  in  the  u-boot-users
mailing list instead.

Chances for useful replies would be even better  if  you  provided  a
little more information. "modify several line of ..." is not really a
precise description of what you did.


Porting U-Boot to new hardware requires more  than  just  tweaking  a
line  here  and there. It will require both an in-depth understanding
of the hardware and U-Boot.

> It's my first time to build a embedded linux project,wish u can help me out.

Did you read the README that comes with U-Boot?

Finally: did you order your BDI2000 yet? You will  probably  need  it
soon.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If all you have is a hammer, everything looks like a nail.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
