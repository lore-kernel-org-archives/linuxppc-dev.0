Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <4A2BA6A2F12BD511AAFA00606730DE9B3F81DB@BLREXSR>
From: Nageswari S <nageswari@sanyo.co.in>
To: "'Wolfgang Denk '" <wd@denx.de>,
	Nageswari S <nageswari@sanyo.co.in>
Cc: "'LinuxPPC '" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Serial Mouse Not working 
Date: Thu, 20 Jun 2002 20:31:32 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Dear Wolfgang Denk,

Thank you very much for the reply. I connected  +9V to RTS and DTR lines.
Then I tried
cat some txt file to /dev/ttyS0 to enable Tx line.

The serial mouse is working now.

Regards,
Nageswari





-----Original Message-----
From: Wolfgang Denk
To: Nageswari S
Cc: LinuxPPC
Sent: 6/19/02 8:51 PM
Subject: Re: Serial Mouse Not working

Dear Nageswari,

in message <4A2BA6A2F12BD511AAFA00606730DE9B0A7170@BLREXSR> you wrote:
>
>  I am new to Linux environment. I have a serial mouse connected to my
custom
> PowerPC board. My serial mouse is not working when I conenct it to
ttyS0.
> But I am able to do PPP and serial file transfer over the same port.

Unfortunately you don't provide ANY informatiuon about what  sort  of
hardware you have, or which kernel version tyou are running.

> Do I need to enable/configure any settings specifically for the serial
mouse
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
