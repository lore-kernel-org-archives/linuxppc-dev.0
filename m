To: "Kevin A. Sapp" <Kevin.Sapp@catapult.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: RAMDISK Segv 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 04 Dec 2003 06:34:08 EST."
             <3FCF1BB0.9060005@catapult.com>
Date: Thu, 04 Dec 2003 12:43:35 +0100
Message-Id: <20031204114340.42AD1C5F5F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3FCF1BB0.9060005@catapult.com> you wrote:
>
> Thanks, I'll build busy box from scratch with my
> distro and see how that goes.  The Arabella free
> package seems to do a few thing s different, such
> as dpr allocation...

??

> IMMR is 0xF000_0000   with virt=phys
> BCSR is 0xF450_0000    this seems a little strange

This is probably correct, other MPC82xxADS boards use the same.

Sorry, I don't have such hardware, so I can't help.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Uuencode/uudecode is just a mickey-mouse archiver.
                       - Doug Gwyn in <1995Mar4.011139.22820@arl.mil>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
