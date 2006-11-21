Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 2632967CEE
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 05:14:30 +1100 (EST)
Date: Tue, 21 Nov 2006 12:10:36 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@tux.tmfweb.nl
Subject: Re: [PATCH] Add generated powerpc files to .gitignore
Message-Id: <20061121121036.5b021de8.kim.phillips@freescale.com>
In-Reply-To: <20061120182519.GA24789@nospam.com>
References: <20061120182519.GA24789@nospam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: rutger@nospam.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 20 Nov 2006 19:25:19 +0100
Rutger Nijlunsing <rutger@nospam.com> wrote:

> Is this the right place for patches like this to be digisted?  This

yes,

> patch adds files generated on a G3 PowerBook built of 2.6-git...
> 
some of these (e.g. empty.c) are already in the powerpc git tree, and some are not; the arch/powerpc/boot/Makefile lists all possible file names (not just the pmac's) that should be in the .gitignore file.  please base off of Paul Mackerras' powerpc git tree, and respin with all files not already in .gitignore.

Thanks,

Kim

> 
> Author: Rutger Nijlunsing <linuxppc-dev@tux.tmfweb.nl>
> Date:   Mon Nov 20 18:52:56 2006 +0100
> 
>     Add generated powerpc files to .gitignore
> 
> diff --git a/arch/powerpc/.gitignore b/arch/powerpc/.gitignore
> new file mode 100644
> index 0000000..a1a869c
> --- /dev/null
> +++ b/arch/powerpc/.gitignore
> @@ -0,0 +1 @@
> +include
> diff --git a/arch/powerpc/boot/.gitignore b/arch/powerpc/boot/.gitignore
> index 45c9ad2..dadf873 100644
> --- a/arch/powerpc/boot/.gitignore
> +++ b/arch/powerpc/boot/.gitignore
> @@ -1,20 +1,30 @@
>  addnote
> +empty.c
> +hack-coff
>  infblock.c
>  infblock.h
>  infcodes.c
>  infcodes.h
>  inffast.c
>  inffast.h
> +inffixed.h
>  inflate.c
> +inflate.h
>  inftrees.c
>  inftrees.h
>  infutil.c
>  infutil.h
>  kernel-vmlinux.strip.c
>  kernel-vmlinux.strip.gz
>  uImage
>  zImage
> +zImage.chrp
> +zImage.coff
> +zImage.coff.lds
> +zImage.lds
> +zImage.miboot
> +zImage.pmac
>  zImage.vmode
>  zconf.h
>  zlib.h
>  zutil.h
> 
> 
> -- 
> Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
> never attribute to a conspiracy which can be explained by incompetence
> ----------------------------------------------------------------------
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
