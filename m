Message-ID: <3CFF7C68.C6151B82@mvista.com>
Date: Thu, 06 Jun 2002 10:14:48 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Steffen Rumler <Steffen.Rumler@icn.siemens.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: GDB/GDBSERVER and remote Thread Debugging
References: <3CFF63A7.375F0644@icn.siemens.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You will need to be working with GDB version 5.2 or newer to do thread
debugging.

--Mark

Steffen Rumler wrote:
>
> Hello,
>
> I'm looking for a stable GDB/GDBSERVER extension
> suitable for (remote) Debugging multiple threads.
>
> It should also possible to attach already running
> threads.
>
> Actually I'm working with the GDB 5.0, but
> I have problems with it. Sometimes breakpoints
> are not hit, sometimes all threads seem to
> be hanging in the debugging case only.
>
> Is there a stable extension for the GDB/GDBSERVER
> providing thread debugging ?
>
> Thank you for help
>
> Steffen Rumler
>
> --
>
> --------------------------------------------------------------
>
> Steffen Rumler
> ICN ON PNE SB 4
> Siemens AG
> Hofmannstr. 51                 Email: Steffen.Rumler@icn.siemens.de
> D-81359 Munich                 Phone: +49 89 722-44061
> Germany                        Fax  : +49 89 722-36703
>
> --------------------------------------------------------------
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
