From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vincent Katz <vincent.katz@laposte.net>
Cc: <jhartmann@precisioninsight.com>, <paulus@samba.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: AGP : ATI128,powerpc
Date: Wed, 14 Nov 2001 22:26:29 +0100
Message-Id: <20011114212629.29843@smtp.wanadoo.fr>
In-Reply-To: <1005771164.6732.19.camel@avalon>
References: <1005771164.6732.19.camel@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Linux version : 2.4.14
>File with a supposed probleme : linux/drivers/char/agp/agpgart_be.c
>
>I have a powerpc with an ati128 AGP.
>
>When i compile the kernel i have this error : error "Please define
>flush_cache."
>
>this error come from the function flush_cache in agpgart_be.c where
>definition for powerpc are not setting . Why ?

What PPC machine is this ? I added support for Apple's UniNorth
chipset in my kernel (patch submited to dri-devel a few days ago)
along with the necessary r128 DRM changes to work around HW bugs.

(My rsync tree is at rsync.penguinppc.org::linux-2.4-benh).

If you are using a different chipset, then my code may not help

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
