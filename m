Date: Mon, 2 Feb 2004 18:19:46 +0100 (MET)
From: Jean-Jacques Levy <jean-jacques.levy@inria.fr>
Message-Id: <200402021719.SAA0000012801@beaune.inria.fr>
To: linuxppc-dev@lists.linuxppc.org
Cc: schmitz@opal.biophys.uni-duesseldorf.de
Subject: Re: m3mirror + 2.4.24
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Me neither; I'd have to work out what the _IOW macro expands to in that
> case. What kernel headers version do you have installed (f.i. Debian ships
> 2.5.999 which won't match your 2.4.24 kernel too well)?

Right now, I think the headers are set by:

  /usr/include/linux -> /usr/src/linux/include/linux
  /usr/include/asm -> /usr/src/linux/include/asm
  /usr/src/linux/include/asm -> /usr/src/linux/include/asm-ppc

I hope it's correct.

-JJ-


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
