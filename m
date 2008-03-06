Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18384.27914.34609.721913@cargo.ozlabs.ibm.com>
Date: Fri, 7 Mar 2008 09:15:38 +1100
From: Paul Mackerras <paulus@samba.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: Please pull pasemi.git for-2.6.26 branch
In-Reply-To: <20080306214406.GA2631@lixom.net>
References: <20080306214406.GA2631@lixom.net>
Cc: linuxppc-dev@ozlabs.org, pasemi-linux@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson writes:

> Please pull from 'for-2.6.26' branch of
> 
>   master.kernel.org:/pub/scm/linux/kernel/git/olof/pasemi.git for-2.6.26
> 
> to receive the following updates. They have all been posted to the list
> previously, and had only minor updates to remove a couple of compiler
> warnings:
> 
>  arch/powerpc/platforms/pasemi/dma_lib.c |  144 ++++++++++++++
>  drivers/net/Makefile                    |    3 
>  drivers/net/pasemi_mac.c                |  324 ++++++++++++++++++++++++++------
>  drivers/net/pasemi_mac.h                |   35 +++
>  drivers/net/pasemi_mac_ethtool.c        |  159 +++++++++++++++
>  include/asm-powerpc/pasemi_dma.h        |   77 +++++++
>  6 files changed, 681 insertions(+), 61 deletions(-)

Is Jeff Garzik OK with those pasemi_mac_* updates going via my tree?

Paul.
