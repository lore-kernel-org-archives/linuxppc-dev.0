Return-Path: <olh@suse.de>
Received: from Cantor.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E6F5C67A80
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Jan 2005 06:05:43 +1100 (EST)
Date: Wed, 26 Jan 2005 20:05:37 +0100
From: Olaf Hering <olh@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Akinobu Mita <amgta@yacht.ocn.ne.jp>
Message-ID: <20050126190537.GA26349@suse.de>
References: <200501260512.j0Q5CAhd016730@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200501260512.j0Q5CAhd016730@hera.kernel.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] oprofile: falling back on timer interrupt mode
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Wed, Jan 26, Linux Kernel Mailing List wrote:

> ChangeSet 1.2038, 2005/01/25 20:31:01-08:00, amgta@yacht.ocn.ne.jp
> 
> 	[PATCH] oprofile: falling back on timer interrupt mode

> 
>  arch/alpha/oprofile/common.c     |    6 ++++--
>  arch/arm/oprofile/common.c       |    7 +++++--
>  arch/arm/oprofile/init.c         |    8 ++++++--
>  arch/i386/oprofile/init.c        |    4 +++-
>  arch/ia64/oprofile/init.c        |    8 ++++++--
>  arch/m32r/oprofile/init.c        |    3 ++-
>  arch/parisc/oprofile/init.c      |    3 ++-
>  arch/ppc64/oprofile/common.c     |    6 ++++--
>  arch/s390/oprofile/init.c        |    3 ++-
>  arch/sh/oprofile/op_model_null.c |    3 ++-
>  arch/sparc64/oprofile/init.c     |    3 ++-
>  drivers/oprofile/oprof.c         |    6 +++---
>  include/linux/oprofile.h         |    2 +-
>  13 files changed, 42 insertions(+), 20 deletions(-)

This misses arch/ppc
