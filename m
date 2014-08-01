Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0171.hostedemail.com
 [216.40.44.171])
 by lists.ozlabs.org (Postfix) with ESMTP id DE0EC1A07B9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Aug 2014 10:47:32 +1000 (EST)
Received: from smtprelay.hostedemail.com (ff-bigip1 [10.5.19.254])
 by smtpgrave04.hostedemail.com (Postfix) with ESMTP id 0AAACB192B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Aug 2014 00:40:56 +0000 (UTC)
Message-ID: <1406853648.9953.14.camel@joe-AO725>
Subject: Re: [PATCH v2 1/2] printk: Add function to return log buffer
 address and size
From: Joe Perches <joe@perches.com>
To: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 31 Jul 2014 17:40:48 -0700
In-Reply-To: <20140731152255.37e675870dfdf77d9dbaff70@linux-foundation.org>
References: <20140731153447.27134.44225.stgit@hegdevasant.in.ibm.com>
 <20140731152255.37e675870dfdf77d9dbaff70@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-07-31 at 15:22 -0700, Andrew Morton wrote:

> Please include this in whatever tree carries "powerpc/powernv:
> Interface to register/unregister opal dump region".

At some point, I'd like to redo the patch series
that breaks up printk.c into more manageable blocks.

https://lkml.org/lkml/2012/10/17/41

Any suggestion for timing?
