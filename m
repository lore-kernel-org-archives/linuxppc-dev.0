To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Rod Boyce <rod_boyce@stratexnet.com>,
	"'LinuxPPC '" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PCMCIA Modem/Serial Cards and MPC8xx? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 27 Aug 2003 11:17:07 +0200."
             <3F4C7713.2030703@imc-berlin.de>
Date: Wed, 27 Aug 2003 12:44:31 +0200
Message-Id: <20030827104436.2C91EC59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Steven,

in message <3F4C7713.2030703@imc-berlin.de> you wrote:
>
> > I am not at my desk but can tell you that you will have to change the
> > options for serial driver.  I have use the PCMCIA for serial ports but I
> > have setup both the MPC8xx uarts and a standard 16550 uart chip to work in
> > the same Linux kernel.
> Could you please give my a pointer how you did that?
> Did you have MPC8xx uarts _and_ a standard 16550 uart _and_ PCMCIA?

Yes, we support MPX8xx UART, standard serial driver  including  16550
UART,  and  PCMCIA.  See our linux-2.4 kernel tree. It should be very
easy to extract the relevant patch and  to  apply  it  to  any  other
kernel.

> Hmm. But even if I define one. The kernel won't find a UART if it's on
> PCMCIA since PCMCIA is started much later... ?

The PCMCIA Card Services will take care of that.

> Any hints?

See http://www.denx.de/twiki/bin/view/DULG/KernelConfigurationForPCMCIA

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"The whole problem with the world is  that  fools  and  fanatics  are
always so certain of themselves, but wiser people so full of doubts."
- Bertrand Russell

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
