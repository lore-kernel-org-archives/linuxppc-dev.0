Date: Tue, 17 Dec 2002 14:19:46 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: kmalloc and startup process
In-reply-to: <3DFF1DF4.8010005@intracom.gr>
To: Pantelis Antoniou <panto@intracom.gr>,
	linuxppc-embedded@lists.linuxppc.org
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLKEODFIAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Don't know when it's safe to call kmalloc, but maybe you
should avoid kmalloc?  Is it possible to use
kmalloc when the microcode(8xx_io/micropatch.c) is loaded?

   Jocke
>
>
> Hi
>
> I'm hacking now the 8xx hostalloc and dpalloc stuff,
> and I have a a question.
>
> At what point in the startup process is it OK to call
> kmalloc?
>
> I don't think it is safe at the setup_arch point.
>
> Is this correct?
>
> Thanks
>
> --
> Pantelis Antoniou
> INTRACOM S.A. Greece
>
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
