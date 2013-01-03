Return-Path: <benh@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DCA8D2C0087
 for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2013 17:14:31 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@au1.ibm.com>;
 Thu, 3 Jan 2013 16:09:50 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 21AE22BB004E
 for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2013 17:14:28 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r03635s652428832
 for <linuxppc-dev@ozlabs.org>; Thu, 3 Jan 2013 17:03:05 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r036ER2n017784
 for <linuxppc-dev@ozlabs.org>; Thu, 3 Jan 2013 17:14:27 +1100
Message-ID: <1357193665.3924.38.camel@pasglop>
Subject: Re: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 03 Jan 2013 17:14:25 +1100
In-Reply-To: <1357193608.3924.37.camel@pasglop>
References: <1357193608.3924.37.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-01-03 at 17:13 +1100, Benjamin Herrenschmidt wrote:
> Hi Linus !
> 
> Here are a couple of small powerpc fixes. They aren't new bugs (and
> they are both CCed to stable) but I didn't see the point of sitting
> on the fixes any longer.

Looks like I still need to fix my script to get the branch name right
for when the mirrors haven't caught up...

It's

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Cheers,
Ben.
