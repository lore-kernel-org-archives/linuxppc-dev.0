To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PCMCIA Modem/Serial Cards and MPC8xx? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 26 Aug 2003 12:40:13 +0200."
             <3F4B390D.1060101@imc-berlin.de>
Date: Wed, 27 Aug 2003 12:37:58 +0200
Message-Id: <20030827103803.3C471C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Steven,

in message <3F4B390D.1060101@imc-berlin.de> you wrote:
>
> is someone using a PCMCIA Modem or Serial Port card with an MPC8xx system?

Yes, we tested this on a couple of boards, including a TQM8xxL board.

> I build a kernel for a TQM860L based board enabeling CONFIG_SERIAL=y
> as the PCMCIA HowTo states. (I also have CONFIG_SERIAL_CONSOLE=y). But
> while booting (or insmod serial.o) I get :

So far, this is only supported by our linux-2.4 kernel (normally, the
8xx UART driver and the standard serial driver  [as  needed  for  the
modem] will cause conflicts; these are trivially to fix, though).

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Bus error -- driver executed.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
