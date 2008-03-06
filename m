Return-Path: <olof@lixom.net>
Date: Thu, 6 Mar 2008 16:32:05 -0600
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Please pull pasemi.git for-2.6.26 branch
Message-ID: <20080306223205.GA3755@lixom.net>
References: <20080306214406.GA2631@lixom.net>
	<18384.27914.34609.721913@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18384.27914.34609.721913@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, pasemi-linux@ozlabs.org, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 07, 2008 at 09:15:38AM +1100, Paul Mackerras wrote:
> Olof Johansson writes:
> 
> > Please pull from 'for-2.6.26' branch of
> > 
> >   master.kernel.org:/pub/scm/linux/kernel/git/olof/pasemi.git for-2.6.26
> > 
> > to receive the following updates. They have all been posted to the list
> > previously, and had only minor updates to remove a couple of compiler
> > warnings:
> > 
> >  arch/powerpc/platforms/pasemi/dma_lib.c |  144 ++++++++++++++
> >  drivers/net/Makefile                    |    3 
> >  drivers/net/pasemi_mac.c                |  324 ++++++++++++++++++++++++++------
> >  drivers/net/pasemi_mac.h                |   35 +++
> >  drivers/net/pasemi_mac_ethtool.c        |  159 +++++++++++++++
> >  include/asm-powerpc/pasemi_dma.h        |   77 +++++++
> >  6 files changed, 681 insertions(+), 61 deletions(-)
> 
> Is Jeff Garzik OK with those pasemi_mac_* updates going via my tree?

Yes, he explicitly asked for it last week:

http://ozlabs.org/pipermail/linuxppc-dev/2008-February/052227.html


-Olof
