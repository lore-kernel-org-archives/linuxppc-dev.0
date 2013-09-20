Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id 4A1472C0111
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Sep 2013 13:08:09 +1000 (EST)
Message-ID: <523BBC15.8030607@tabi.org>
Date: Thu, 19 Sep 2013 22:08:05 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
Subject: Re: [PATCH 1/2][v3] powerpc/fsl-booke: Add initial T104x_QDS board
 support
References: <1379581205-24424-1-git-send-email-prabhakar@freescale.com>
 <CAOZdJXVBV0LvEwTua_eyTHXJdOcHZKQCjiTrYocqfcQY5hosUw@mail.gmail.com>
 <071A08F2C6A57E4E94D980ECA553F874F9CF8D@039-SN1MPN1-005.039d.mgd.msft.net>
In-Reply-To: <071A08F2C6A57E4E94D980ECA553F874F9CF8D@039-SN1MPN1-005.039d.mgd.msft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Jain Priyanka-B32167 <B32167@freescale.com>,
 Aggrwal Poonam-B10812 <B10812@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kushwaha Prabhakar-B32579 wrote:
> My primary object is to put base patch in Linux. once it done other things can be enabled one by one.

Any features which are not enabled must be specified in the patch 
description.  The patch says that the board supports DIU, but the code 
doesn't, so that's misleading.

> Also, I am not familiar with DIU driver:(.

I can help you with the DIU driver.

> shall I remove the DIU node, and  while adding support of DIU, all modification will be sent.

I think it should be okay to leave the DIU node.  I think the kernel 
will crash if you try to enable a DIU console (video= on the kernel 
command line), but I think it's okay to ignore that for the moment.
