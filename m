Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 7D3CCB6EF4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2012 03:25:41 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH v3] ipc: provide generic compat versions of IPC syscalls
Date: Thu, 15 Mar 2012 16:25:32 +0000
References: <201112091536.pB9Fa5f7002738@farm-0002.internal.tilera.com>
 <201112122148.pBCLmPH0023959@farm-0002.internal.tilera.com>
 <4F6144B8.5010601@tilera.com>
In-Reply-To: <4F6144B8.5010601@tilera.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201203151625.32199.arnd@arndb.de>
Cc: linux-mips@linux-mips.org, NeilBrown <neilb@suse.de>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
 "J. Bruce Fields" <bfields@redhat.com>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>,
 Lucas De Marchi <lucas.demarchi@profusion.mobi>,
 Thomas Gleixner <tglx@linutronix.de>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 15 March 2012, Chris Metcalf wrote:
> 
> Somewhat belatedly, I'm looking to push this through the "tile" tree. 
> Andrew Morton has been keeping it in his tree but I figure I should push it
> since it directly affects "tile" and currently no one else.

Sounds good.

> However, it would be nice if anyone could provide a Reviewed-by or Acked-by
> on the patch.  Thanks!

As the main author of ipc/compat.c in its current form,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
