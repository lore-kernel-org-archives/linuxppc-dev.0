Date: Mon, 2 Feb 2004 18:22:02 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Jean-Jacques Levy <jean-jacques.levy@inria.fr>
Cc: linuxppc-dev@lists.linuxppc.org,
	<schmitz@opal.biophys.uni-duesseldorf.de>
Subject: Re: m3mirror + 2.4.24
In-Reply-To: <200402021719.SAA0000012801@beaune.inria.fr>
Message-ID: <Pine.LNX.4.44.0402021821060.18653-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Me neither; I'd have to work out what the _IOW macro expands to in that
> > case. What kernel headers version do you have installed (f.i. Debian ships
> > 2.5.999 which won't match your 2.4.24 kernel too well)?
>
> Right now, I think the headers are set by:
>
>   /usr/include/linux -> /usr/src/linux/include/linux
>   /usr/include/asm -> /usr/src/linux/include/asm
>   /usr/src/linux/include/asm -> /usr/src/linux/include/asm-ppc

And /usr/src/linux is the 2.4.24 tree? (check include/linux/version.h)

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
