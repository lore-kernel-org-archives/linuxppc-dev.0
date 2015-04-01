Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A95801A0A06
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 16:03:49 +1100 (AEDT)
Date: Tue, 31 Mar 2015 22:05:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, Joel Stanley
 <joel@jms.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, rusty@rustcorp.com.au, fabf@skynet.be,
 jk@ozlabs.org
Subject: Re: [PATCH 1/2] kernel/reboot.c: Add orderly_reboot for graceful
 reboot
Message-Id: <20150331220528.b1f9b500.akpm@linux-foundation.org>
In-Reply-To: <20150331220326.994661ba.akpm@linux-foundation.org>
References: <1427681733-25488-1-git-send-email-joel@jms.id.au>
 <551B7978.8040502@linux.vnet.ibm.com>
 <20150331220326.994661ba.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 31 Mar 2015 22:03:26 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> static char reboot_cmd[] = "/sbin/reboot";

static const char, actually.
