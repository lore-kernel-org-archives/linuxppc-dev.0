Return-Path: <borntraeger@de.ibm.com>
Received: from mtagate3.uk.ibm.com (mtagate3.uk.ibm.com [195.212.29.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5FFC4B7B65
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Nov 2009 19:57:23 +1100 (EST)
Received: from d06nrmr1806.portsmouth.uk.ibm.com
	(d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate3.uk.ibm.com (8.14.3/8.13.8) with ESMTP id nAA8uvhC277570
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Nov 2009 08:57:02 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id nAA8ulqR2072690
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Nov 2009 08:56:47 GMT
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id nAA8ukVU006953
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Nov 2009 08:56:46 GMT
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 3/8] hvc_console: make the ops pointer const.
Date: Tue, 10 Nov 2009 09:56:45 +0100
References: <1257834450..rusty@rustcorp.com.au>
In-Reply-To: <1257834450..rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200911100956.45668.borntraeger@de.ibm.com>
Cc: Amit Shah <amit.shah@redhat.com>, linuxppc-dev@ozlabs.org,
	virtualization@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Dienstag 10 November 2009 07:27:30 schrieb Rusty Russell:
> This is nicer for modern R/O protection.  And noone needs it non-const, so
> constify the callers as well.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> To: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: linuxppc-dev@ozlabs.org
> ---
>  drivers/char/hvc_beat.c       |    2 +-
>  drivers/char/hvc_console.c    |    7 ++++---
>  drivers/char/hvc_console.h    |    7 ++++---
>  drivers/char/hvc_iseries.c    |    2 +-
>  drivers/char/hvc_iucv.c       |    2 +-
>  drivers/char/hvc_rtas.c       |    2 +-
>  drivers/char/hvc_udbg.c       |    2 +-
>  drivers/char/hvc_vio.c        |    2 +-
>  drivers/char/hvc_xen.c        |    2 +-
>  drivers/char/virtio_console.c |    2 +-
>  10 files changed, 16 insertions(+), 14 deletions(-)

Ok, I started with patches 1-3. I like the result.

So for the first 3 patches you can add
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com> (on s390)
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

I have not yet looked at the other ones, but I will try to find some time to 
look at them.

Christian
