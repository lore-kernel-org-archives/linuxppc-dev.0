To: Steven Rothweiler <Stevenr@raritan.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: AgileDB and Abatron BDI 2000 ICE 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 11 Jul 2003 11:12:46 EDT."
             <159C486347C8D3119B1D005004A469400244BC6B@OLIVE>
Date: Fri, 11 Jul 2003 17:33:05 +0200
Message-Id: <20030711153310.7DD2FC6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Steven,

in message <159C486347C8D3119B1D005004A469400244BC6B@OLIVE> you wrote:
>
> >From the AgileDB product data sheet (I can send it to you if
> you'd like), it is clearly a GUI front end for GDB, or any

Thanks, I've read it.

> other debugger you want to use.  They allow you to issue any
> GDB (or any tool's) command-line command from a prompt, if
> that's what you're familiar with.  From their data sheet:

This is why I wonder what they provide which  is  not  available  for
example  in  DDD,  which is available for free and pre-installed with
all major Linux distributions.

> * The BDI 2000 ICE Command Set

available with DDD/GDB though GDB's "monitor" command

> * The GDB Command Set

available through GDB itself.

> * Target Serial I/O (over telnet)
> * Any Tool or Service that uses Telnet
> * Boot Agents Like: PPC/U-BOOT
> * User-Defined Tests and Target Services

Yeah, all available without AgileDB, too.

> Theoretically, you're supposed to have productivity gains
> by using their GUI (if you invest the time to learn it, just
> as you've invested time to learn a CLI) over the equivalent

You can use DDD if you want a GUI.

> debuggers suffer from.  In a particular debug session, you
> can put all of the things that are most important to you
> into a single window.  I have no idea if this enhances
> productivity, but I know that one of the reasons that I
> prefer CLIs is that I spend more time opening, closing,
> re-sizing, and just plain fiddling with the GUI windows.

As mentioned before, you will have to test yoursdelf if you like  the
tool,  or  not.  But do yourself a favour and test DDD, too. And then
compare the prices.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"If you are afraid of loneliness, don't marry."             - Chekhov

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
