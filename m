Message-ID: <20021005010832.13391.qmail@kunk.jriver.com>
Subject: Re: usb-storage.o - Unresolved symbol ppc_generic_ide_fix_driveid in
 2.4.20-pre7-ben0
In-Reply-To: <20021004120538.12787@192.168.4.1>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 4 Oct 2002 20:08:32 -0500 (CDT)
From: Robert E Brose II <bob@kunk.jriver.com>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


User Benjamin Herrenschmidt says:
> It doeds make a difference, that function is only exported if you have
> IDE enabled in the .config. However, if you just enable it and redo
> the make, it may not work, as the actual export table may not be
> rebuilt properly.
>
> I suggest you enable IDE, backup .config, make distclean,
> restore .config, make oldconfig, then make.
> Ben.

Ben, you are correct. It was the distclean et al.. I forgot about
that one. Also, if I remove the isd driver it works as well without
turning the ide drivers on...

Thanks a lot..

Bob
--
/~\ The ASCII       | Robert E. Brose II    N0QBJ
\ / Ribbon Campaign | http://www.qbjnet.com/
 X  Help cure       | mailto:bob@qbjnet.com
/ \ HTML Email      | public key at http://www.qbjnet.com/key.html

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
