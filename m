Subject: Re: Kernel sound problems (and misc)
From: Bastien Nocera <hadess@hadess.net>
To: Anton Blanchard <anton@samba.org>
Cc: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20010513153953.A16897@va.samba.org>
References: <kara.5052-0.989768459@kara.hadess.net>
	<20010513153953.A16897@va.samba.org>
Content-Type: text/plain
Date: 13 May 2001 23:54:13 +0100
Message-Id: <989794453.4941.3.camel@kara>
Mime-Version: 1.0
Message-ID: <kara.18908-0.989794453@kara.hadess.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On 13 May 2001 15:39:53 -0700, Anton Blanchard wrote:
>
> > The misc problem is, while trying to compile paulus' kernel, the vmlinux
> > target fails to link with rwsem_down_write_failed and rwsem_wake
> > undefined references.
>
> Did you make oldconfig? You should this in your .config:
>
> # CONFIG_RWSEM_GENERIC_SPINLOCK is not set
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y

Hmm,usually I just load the my old config file, run make menuconfig to
change whatever there is to change (like adding or removing device
drivers), and have a sane .config.

-(~/Cvs/pmac-devel)-> grep RWSEM .config
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set

seems like it could be the problem. Thanks for the tip.
I guess I will do as Ben advised me, and stick to using his tree rather than paulus' for my pmac.

Cheers

--
/Bastien Nocera
http://hadess.net


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
