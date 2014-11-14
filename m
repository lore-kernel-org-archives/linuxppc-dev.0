Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3B3CB1A018C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Nov 2014 13:04:53 +1100 (AEDT)
Message-ID: <1415930691.26378.1.camel@concordia>
Subject: Re: [PATCH v2] drivers/char/ipmi: Add powernv IPMI driver
From: Michael Ellerman <mpe@ellerman.id.au>
To: minyard@acm.org
Date: Fri, 14 Nov 2014 13:04:51 +1100
In-Reply-To: <54655DFE.6080503@acm.org>
References: <1415778065.431549.108606915276.1.gpush@pablo>
 <54655DFE.6080503@acm.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: openipmi-developer@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-11-13 at 19:42 -0600, Corey Minyard wrote:
> This looks good.  Can this go into the IPMI tree now, or does it need
> work done in the PowerPC tree first?

You need to merge this first:

  https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/log/?h=topic/opal-ipmi

ie.

  $ git fetch git://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux.git topic/opal-ipmi
  $ git merge FETCH_HEAD

cheers
