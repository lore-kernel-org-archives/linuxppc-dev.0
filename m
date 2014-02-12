Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 170462C0096
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Feb 2014 06:21:57 +1100 (EST)
Date: Wed, 12 Feb 2014 20:21:50 +0100
From: Gerhard Sittig <gsi@denx.de>
To: Alexander Popov <a13xp0p0v88@gmail.com>
Subject: Re: [PATCH RFC v7 1/6] dma: mpc512x: reorder mpc8308 specific
 instructions
Message-ID: <20140212192150.GH4524@book.gsilab.sittig.org>
References: <1392211508-23615-1-git-send-email-a13xp0p0v88@gmail.com>
 <1392211508-23615-2-git-send-email-a13xp0p0v88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392211508-23615-2-git-send-email-a13xp0p0v88@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>,
 Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ removed DT from Cc: ]

On Wed, Feb 12, 2014 at 17:25 +0400, Alexander Popov wrote:
> 
> Concentrate the specific code for MPC8308 in the 'if' branch
> and handle MPC512x in the 'else' branch.
> This modification only reorders instructions but doesn't change behaviour.

As this one is an obvious improvement and straight forward, it
can be taken regardless of the remainder of the series.  (I guess
this formerly stated judgement is what made Alexander derive
Acked-By tags from.)


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
