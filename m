To: Hihn Jason <JasonHihn@DANFOSS.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: hacking linux - framebuffer console/i2c keyboard 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 04 Sep 2002 15:34:02 +0200."
             <E1836A7F3557D311A14000805F9F36FC0141C86B@usdfo011.usac.danfoss.net>
Date: Wed, 04 Sep 2002 18:05:36 +0200
Message-Id: <20020904160541.545CC11835@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

in message <E1836A7F3557D311A14000805F9F36FC0141C86B@usdfo011.usac.danfoss.net> you wrote:
>
> How would one hack up a i2c keypad interface to appear as a keyboard on a
> system, and get messages to stdout appear on an LCD? Specifically, I'm
> working on 823e. I have no idea where or how to start. I know each thing
> works correctly, that is, I have the i2c keypad and the LCD properly working
> on the system. I'm just at a loss on how to tie it all together.

Check out the LWMON configuration in our kernel sources; see
http://www.denx.de/re/linux.html

The arch/ppc/8xx_io/lwmon_kbd.c  file  implements  a  (very  special)
keyboard  driver  that  is attached over I2C (using the I2C driver in
drivers/i2c/i2c-simple.*).

Hope this helps,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"The algorithm to do that is extremely nasty. You might want  to  mug
someone with it."                   - M. Devine, Computer Science 340

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
