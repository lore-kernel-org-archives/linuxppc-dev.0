Date: Tue, 2 May 2000 18:18:57 +0200
From: Olaf Hering <olh@suse.de>
To: claude@convergence.de
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Pismo boots then ?
Message-ID: <20000502181857.A3528@suse.de>
Reply-To: linuxppc-dev@lists.linuxppc.org
References: <20000502181359.A1157@warez.convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20000502181359.A1157@warez.convergence.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, May 02, claude@convergence.de wrote:


> Finally, my kernel booted nice into the Suse install items, but I
> haven't the suse CD (only the linuxppc1999 CD), and unfortunately I
> wasn't able to continue my installation.

Just replace the ramdisk.image.gz with the version from your CD.

> ? Do I need absolutely one of the newest distribution CD (ppc2000 or
> suseppc), or can I continue in an other way (using the linuxppc1999
> distribution, or doing it via FTP, or even NFS).

The binaries should work, you need only the latest kernel version.
Take it from BenH's website or from
ftp://ftp.suse.com/pub/suse/ppc/update/BETA.
The /proc/sys/dev directory might be useful, you can switch some
features on and off :=)


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
