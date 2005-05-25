Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (unknown [217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F05D8679E7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 May 2005 22:27:01 +1000 (EST)
Date: Wed, 25 May 2005 13:26:56 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: "Peter Gehirnforce" <Gehirnmann@gmx.de>
Message-Id: <20050525132656.69ff77a4.ajz@cambridgebroadband.com>
In-Reply-To: <16216.1117022348@www12.gmx.net>
References: <16216.1117022348@www12.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: depmod.pl fails with "base directory does not match" (2_4_devel)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Use something like the following:

	make INSTALL_MOD_PATH=/opt/eldk/ppc_6xx modules_install

Where /opt/eldk/ppc_6xx should be replaced with the base of your
target root filesystem.

Alex

On Wed, 25 May 2005 13:59:08 +0200 (MEST)
"Peter Gehirnforce" <Gehirnmann@gmx.de> wrote:

> Hi all,
> 
> since now I used modules compiled into the kernel for ppc_6xx.
> for debugging I'd like to use dynamic loading, but when doing:
> make modules_install
> the depmod.pl fails with "base directory does not match
> ..../lib/modules" As far as I could find out, the modules get copied
> to the base /lib path, even with $PATH and $CROSS_COMPILE set
> correctly (I used compiled modules successfully).
> Whats wrong with my attempt? is there some cross-compile tool to do
> the job of depmod.pl?
> 
> GM
> 
> -- 
> 5 GB Mailbox, 50 FreeSMS http://www.gmx.net/de/go/promail
> +++ GMX - die erste Adresse f_r Mail, Message, More +++
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
