To: "Flavio Pereira" <fpereira@azisa.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on 8260 using ELDK..Help?!? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 04 Sep 2002 15:59:24 +0200."
             <1E354700654661418593A0D6B5A9D410A3618E@mail.azisa.co.za>
Date: Wed, 04 Sep 2002 18:10:46 +0200
Message-Id: <20020904161051.6B9E011835@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Flavio,

in message <1E354700654661418593A0D6B5A9D410A3618E@mail.azisa.co.za> you wrote:
>
> > Are you sure this was done well?
>
> Well _no_ I'm not sure this was done well but I can tell you exactly
> what I have done. For uart.c I've completely removed SMC1 and SMC2 from
> serial_state rs_table and rs_brg_map[]. If I don't remove this my serial
> port does not come up at all initially. For tty_io.c I simply to do not
> call rs_8xx_init because it kills my serial port, i.e. if I let it this
> code execute there is no more output on my serial terminal.

I recommend to return to the original code, and get this working. You
can probably use the driver in our  CVS  as  reference;  we  fixed  a
couple of issues for example in the area of BRG assignment.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
No journaling file system can recover your data if the disk dies.
                                 - Steve Rago in <D4Cw1p.L9E@plc.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
