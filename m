To: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: gdb problems 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 10 May 2001 23:50:19 +0200."
             <000701c0d99b$357cbf20$3196143e@jocke>
Date: Fri, 11 May 2001 00:09:09 +0200
Message-Id: <20010510220914.7A6522814D@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <000701c0d99b$357cbf20$3196143e@jocke> you wrote:
>
> > Which version of GDB are you using, and which firmware version of the
...
> >From the MontaVista CDK 1.2, ppc_8xx-gdb-5.0-1 and ppc_8xx-gcc-2.95.2-13

Ummm... I tried this once, and it barfed on all my macro definitions.
Something must be seriously broken with this version of GDB. I  would
not trust it a signle step :-(

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Another megabytes the dust.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
