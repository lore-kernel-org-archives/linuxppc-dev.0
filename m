To: "Flavio Pereira" <Flavio.Pereira@za.flextronics.com>
Cc: "LinuxPPC-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Accessing MPC862 registers 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 05 Feb 2003 14:48:03 +0200."
             <742AC4678EF8464697DDDFE3B40F6ECD07E248@SRV-MAILRND.azisa.co.za>
Date: Wed, 05 Feb 2003 14:03:38 +0100
Message-Id: <20030205130343.58AC4C608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <742AC4678EF8464697DDDFE3B40F6ECD07E248@SRV-MAILRND.azisa.co.za> you wrote:
>
> I'm hoping that someone can help me here. I'm using the TQM8xxL module
> with a MPC862 processor on board. With minor changes to the pin
> configurations for the ethernet controller I have gotten U-boot and
> Linux to work without any issues. However from my BDI2000 shell, with my

I'd appreciate if you'd send me your patches, then.

> IMMR set to 0xFFF00000 (confirmed), I cannot do memory dumps for the
> region 0xFFF00000 - 0xFFF02000. From FFF02000 (DP-RAM) the memory
> accesses seem fine. The same goes for the u-boot shell. Obviously u-boot

You cannot use a stupid "memory dump" command on  the  IMMR  register
space  -  there are reserved entries that may not be accessed at all,
there are registers that must be accessed in the correct length (8  /
16  /  32 bit), etc. You should be able to read individual registers,
though, assuming you know where they are and how to access them (8  /
16 / 32 bit).

> registers which are located from 0xFFF00000 to 0xFFF00DFF from either
> u-boot or the BDI shell?

And once again, this has nothing to do with  linuxppc-embedded.  It's
off topic on this list. Better ask such questions in u-boot-users.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A good aphorism is too hard for the tooth of time, and  is  not  worn
away  by  all  the  centuries,  although  it serves as food for every
epoch.                                  - Friedrich Wilhelm Nietzsche
                          _Miscellaneous Maxims and Opinions_ no. 168

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
