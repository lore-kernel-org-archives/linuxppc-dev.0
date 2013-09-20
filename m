Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 238562C013F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Sep 2013 02:14:45 +1000 (EST)
Message-ID: <1379693678.16231.8.camel@aoeu.buserror.net>
Subject: Re: [PATCH 1/2][v3] powerpc/fsl-booke: Add initial T104x_QDS board
 support
From: Scott Wood <scottwood@freescale.com>
To: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
Date: Fri, 20 Sep 2013 11:14:38 -0500
In-Reply-To: <071A08F2C6A57E4E94D980ECA553F874F9CF8D@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1379581205-24424-1-git-send-email-prabhakar@freescale.com>
 <CAOZdJXVBV0LvEwTua_eyTHXJdOcHZKQCjiTrYocqfcQY5hosUw@mail.gmail.com>
 <071A08F2C6A57E4E94D980ECA553F874F9CF8D@039-SN1MPN1-005.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Jain Priyanka-B32167 <B32167@freescale.com>,
 Aggrwal Poonam-B10812 <B10812@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Timur Tabi <timur@tabi.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-09-19 at 20:38 -0500, Kushwaha Prabhakar-B32579 wrote:
> Hi Tabi,
> 
> > -----Original Message-----
> > From: Timur Tabi [mailto:timur@tabi.org]
> > Sent: Friday, September 20, 2013 2:03 AM
> > To: Kushwaha Prabhakar-B32579
> > Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; Jain Priyanka-
> > B32167; Aggrwal Poonam-B10812
> > Subject: Re: [PATCH 1/2][v3] powerpc/fsl-booke: Add initial T104x_QDS
> > board support
> > 
> > On Thu, Sep 19, 2013 at 4:00 AM, Prabhakar Kushwaha
> > <prabhakar@freescale.com> wrote:
> > 
> > >  - Video
> > >      - DIU supports video at up to 1280x1024x32bpp
> > 
> > You mention DIU support, except there's no DIU enablement in the platform
> > file.  You need the T104x equivalent of
> > p1022ds_set_pixel_clock() and the other functions.
> 
> My primary object is to put base patch in Linux. once it done other things can be enabled one by one.
> Also, I am not familiar with DIU driver :(. 
> 
> or
> 
> shall I remove the DIU node, and  while adding support of DIU, all modification will be sent.

Do not remove the node.  The device tree describes the hardware, not
what Linux does with it.

-Scott
