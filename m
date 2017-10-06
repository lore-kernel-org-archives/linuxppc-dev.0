Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0249.hostedemail.com
 [216.40.44.249])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7Xw11qfTzDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 13:02:39 +1100 (AEDT)
Message-ID: <1507255353.4434.54.camel@perches.com>
Subject: Re: [PATCH 1/2] powerpc/platforms/cell: Delete an error message for
 a failed memory allocation in three functions
From: Joe Perches <joe@perches.com>
To: Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>, Julia Lawall
 <julia.lawall@lip6.fr>
Cc: Arnd Bergmann <arnd@arndb.de>, kernel-janitors@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>, Jeremy
 Kerr <jk@ozlabs.org>, linuxppc-dev@lists.ozlabs.org, SF Markus Elfring
 <elfring@users.sourceforge.net>
Date: Thu, 05 Oct 2017 19:02:33 -0700
In-Reply-To: <20171005222949.3a288238@kitsune.suse.cz>
References: <db9efaf4-f3d7-d5dc-b0b2-f20e418fa3c8@users.sourceforge.net>
 <62146108-5be0-c236-f404-4be122e162ac@users.sourceforge.net>
 <20171005220210.681f78e8@kitsune.suse.cz>
 <alpine.DEB.2.20.1710052205560.2626@hadrien>
 <20171005222949.3a288238@kitsune.suse.cz>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-10-05 at 22:29 +0200, Michal Suchánek wrote:
> I do not expect the kernel to generate a
> stack trace every time memory allocation fails. With all the hooks in
> the code it is hard to tell, though.

All [kv].alloc failures without __GFP_NOWARN call dump_stack()
