Message-ID: <3965E562.2322340E@crf.canon.fr>
Date: Fri, 07 Jul 2000 16:12:50 +0200
From: Eric Valette <valette@crf.canon.fr>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org, yellowdog-devel@lists.yellowdoglinux.com
Subject: Re: RFC: Changing default partition type for linux/ppc
References: <20000707105915.30418@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> Hi all !
>
> Currently, the default partition type used by Linux/PPC on mac partition
> maps is Apple_UNIX_SVR2. This is historically the type used by Apple's A/
> UX for its own partitions. However, I don't like it since it gives no
> indication on the type of filesystem on the partition, and I see no
> reason to keep it.
>
> So I suggest moving to Linux_ext2, Linux_swap, or maybe simply Linux and
> Linux_swap (since ext2 is not the only filesystem Linux may put on
> these). Using a different type for swap would help avoiding confusion.
>
> If everyone is ok, we can then update pdisk, and on my side, I'll update
> the kernel's root-auto-detect mecanism to take this into account. (The
> kernel will currently find by itself a root partition if it has the above
> type and the name "root" and no root= option was specified by the bootloader).
>
> Any comments ?

Do not forget Prep Machines that have already a specific type of
partition that is already recognised by cfdisk...

--
   __
  /  `                   	Eric Valette - Canon CRF
 /--   __  o _.          	Canon Development Europe Team Leader
(___, / (_(_(__         	Rue de la touche lambert
				35517 Cesson-Sevigne  Cedex
				FRANCE
Tel: +33 (0)2 99 87 68 91	Fax: +33 (0)2 99 84 11 30
E-mail: valette@crf.canon.fr	http://www.crf.canon.fr

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
