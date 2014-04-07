Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D95DE1400B2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Apr 2014 09:21:48 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 8 Apr 2014 04:51:45 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 855D6394003E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Apr 2014 04:51:43 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s37NLc1H5898682
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Apr 2014 04:51:39 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s37NLgJ9029929
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Apr 2014 04:51:42 +0530
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Greg Kurz <gkurz@linux.vnet.ibm.com>, benh@kernel.crashing.org
Subject: Re: [PATCH v2] powerpc/le: enable RTAS events support
In-Reply-To: <20140404072750.20016.18969.stgit@bahia.local>
References: <0140402175658.1b4a8c4d@bahia.local>
 <20140404072750.20016.18969.stgit@bahia.local>
Date: Tue, 08 Apr 2014 09:21:41 +1000
Message-ID: <8738hoenei.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-kernel@vger.kernel.org, paulus@samba.org, anton@samba.org,
 nfont@linux.vnet.ibm.com, geert@linux-m68k.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greg Kurz <gkurz@linux.vnet.ibm.com> writes:
> The current kernel code assumes big endian and parses RTAS events all
> wrong. The most visible effect is that we cannot honor EPOW events,
> meaning, for example, we cannot shut down a guest properly from the
> hypervisor.
>
> This new patch is largely inspired by Nathan's work: we get rid of all
> the bit fields in the RTAS event structures (even the unused ones, for
> consistency). We also introduce endian safe accessors for the fields used
> by the kernel (trivial rtas_error_type() accessor added for consistency).
>
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>

Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>
