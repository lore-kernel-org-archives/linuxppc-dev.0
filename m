To: Nageswari S <nageswari@sanyo.co.in>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Serial Mouse Not working 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 19 Jun 2002 20:08:25 +0530."
             <4A2BA6A2F12BD511AAFA00606730DE9B0A7170@BLREXSR>
Date: Wed, 19 Jun 2002 17:21:03 +0200
Message-Id: <20020619152108.CFA9B10301@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Nageswari,

in message <4A2BA6A2F12BD511AAFA00606730DE9B0A7170@BLREXSR> you wrote:
>
>  I am new to Linux environment. I have a serial mouse connected to my custom
> PowerPC board. My serial mouse is not working when I conenct it to ttyS0.
> But I am able to do PPP and serial file transfer over the same port.

Unfortunately you don't provide ANY informatiuon about what  sort  of
hardware you have, or which kernel version tyou are running.

> Do I need to enable/configure any settings specifically for the serial mouse
> to work? I have link a /dev/mouse to /dev/ttyS0.
>
> Kindly help me with this..

Well, I can only speculate: maybe your board is based on a MPC8xx  or
MPC82xx  CPU,  and  your  ttyS0  port  is connected to one of the SMC
interfaces?

The SMC's on  these  systems  have  no  modem  control  lines,  which
normally  are used to feed the serial mouse with some power. IIRC the
RTS and/or DTR lines are used for power sources, so maybe you get  it
working  by connecting +5V to those lines (careful! I'm a programmer,
not an electrician - don't blame me when you fry your board :-)

Hope this helps,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Security is mostly a superstition. It does not  exist  in  nature...
Life is either a daring adventure or nothing."         - Helen Keller

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
