Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F12812C009A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 09:25:41 +1000 (EST)
Message-ID: <1380065132.24959.144.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/2][v3] powerpc/fsl-booke: Add initial T104x_QDS board
 support
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@tabi.org>
Date: Tue, 24 Sep 2013 18:25:32 -0500
In-Reply-To: <523BBC15.8030607@tabi.org>
References: <1379581205-24424-1-git-send-email-prabhakar@freescale.com>
 <CAOZdJXVBV0LvEwTua_eyTHXJdOcHZKQCjiTrYocqfcQY5hosUw@mail.gmail.com>
 <071A08F2C6A57E4E94D980ECA553F874F9CF8D@039-SN1MPN1-005.039d.mgd.msft.net>
 <523BBC15.8030607@tabi.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Jain Priyanka-B32167 <B32167@freescale.com>,
 Aggrwal Poonam-B10812 <B10812@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Kushwaha Prabhakar-B32579 <B32579@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-09-19 at 22:08 -0500, Timur Tabi wrote:
> Kushwaha Prabhakar-B32579 wrote:
> > My primary object is to put base patch in Linux. once it done other things can be enabled one by one.
> 
> Any features which are not enabled must be specified in the patch 
> description.  The patch says that the board supports DIU, but the code 
> doesn't, so that's misleading.
> 
> > Also, I am not familiar with DIU driver:(.
> 
> I can help you with the DIU driver.
> 
> > shall I remove the DIU node, and  while adding support of DIU, all modification will be sent.
> 
> I think it should be okay to leave the DIU node.  I think the kernel 
> will crash if you try to enable a DIU console (video= on the kernel 
> command line), but I think it's okay to ignore that for the moment.

Sounds like a bug in the DIU driver.  It should fail gracefully in the
absence of platform support.

-Scott
