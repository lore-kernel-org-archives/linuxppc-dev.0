From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Cordes <peter@llama.nslug.ns.ca>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: bk tree doesn't build because of cputable.h
Date: Sun, 15 Apr 2001 15:24:52 +0200
Message-Id: <20010415132452.7690@smtp.wanadoo.fr>
In-Reply-To: <20010414225606.A7020@llama.nslug.ns.ca>
References: <20010414225606.A7020@llama.nslug.ns.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> For some reason, the patch in
>http://lists.linuxppc.org/listarcs/linuxppc-dev/200104/msg00130.html
> was applied to the bk tree.  (I rsync'ed against it from
>penguinppc.org/linux-2.4-bk yesterday, and again today.)  cputable.h doesn't
>exist in that tree, so it breaks when I try to build the kernel.  Removing
>the #include makes the kernel build succeed.  Somebody should fix this. :>
>
> (please CC on reply, I'm not subscribed to the list.)

My fault, this line managed to get into the patch. Dunno why, but I did
test compiling before pushing and it worked... well...

I'll push a fix asap.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
