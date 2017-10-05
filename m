Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7Nw92KS2zDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 07:02:14 +1100 (AEDT)
Date: Thu, 5 Oct 2017 22:02:10 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Jeremy Kerr <jk@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] powerpc/platforms/cell: Delete an error message for
 a failed memory allocation in three functions
Message-ID: <20171005220210.681f78e8@kitsune.suse.cz>
In-Reply-To: <62146108-5be0-c236-f404-4be122e162ac@users.sourceforge.net>
References: <db9efaf4-f3d7-d5dc-b0b2-f20e418fa3c8@users.sourceforge.net>
 <62146108-5be0-c236-f404-4be122e162ac@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Thu, 5 Oct 2017 21:36:26 +0200
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 5 Oct 2017 21:04:30 +0200
> 
> Omit extra messages for a memory allocation failure in these
> functions.

this is bogus. All these functions return -1 on any error. Until they
reflect the error in their return value (and it is properly propagated
to the user) there is no way to tell WTF failed without the message.

> 
> This issue was detected by using the Coccinelle software.
> 

... which provides only a hint which should be evaluated by the user.

Thanks

Michal
