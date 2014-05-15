Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 08A40140086
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 May 2014 01:03:23 +1000 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20140515022238.GL28907@ld-irv-0074>
References: <20140515022238.GL28907@ld-irv-0074>
To: Brian Norris <computersforpeace@gmail.com>
Subject: Re: roundup_pow_of_two() may not handle 64-bit integers
Date: Thu, 15 May 2014 16:03:09 +0100
Message-ID: <29314.1400166189@warthog.procyon.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, dhowells@redhat.com,
 Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Brian Norris <computersforpeace@gmail.com> wrote:

> I'm looking to use roundup_pow_of_two() (actually, order_base_2())
> from <linux/log2.h>, but it seems that it only supports 64-bit integers
> if your toolchain uses a 64-bit 'unsigned long' type. This is strange,
> considering that ilog2() is explicitly designed for 32-bit or 64-bit
> compatibility.

ilog2() was explicitly designed for use with 'unsigned long'.  See the commit
description (f0d1b0b30d250a07627ad8b9fbbb5c7cc08422e8).  It may work with
unsigned long long, however...

David
