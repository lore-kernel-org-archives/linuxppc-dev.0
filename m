Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id 464042C009F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Jun 2013 08:57:21 +1000 (EST)
Received: from mail-vc0-f175.google.com (mail-vc0-f175.google.com
 [209.85.220.175])
 by muin.pair.com (Postfix) with ESMTPSA id C1EB58FC3E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 18:57:18 -0400 (EDT)
Received: by mail-vc0-f175.google.com with SMTP id hr11so1199775vcb.6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 15:57:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1371061871.18413.44@snotra>
References: <1371041258-15298-1-git-send-email-ogabbay@advaoptical.com>
 <51B88EED.6090709@linutronix.de> <1371061871.18413.44@snotra>
Date: Sat, 15 Jun 2013 17:57:18 -0500
Message-ID: <CAOZdJXVjdkMF5rpTVd9tnwCRDqXWtJTUAbywcuzoVehRrgPPsg@mail.gmail.com>
Subject: Re: [PATCH] MDIO: FSL_PQ_MDIO: Fix bug on incorrect offset of tbipa
 register
From: Timur Tabi <timur@tabi.org>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stef van Os <stef.van.os@prodrive.nl>,
 Oded Gabbay <ogabbay@advaoptical.com>, netdev@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Dongsheng.Wang@freescale.com, Timur Tabi <timur@tabi.org>,
 Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>, lkml <linux-kernel@vger.kernel.org>,
 B38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 12, 2013 at 1:31 PM, Scott Wood <scottwood@freescale.com> wrote:
>
> I'm not sure it's stable material if this is something that has never
> worked...
>
> The device tree binding will also need to be fixed to note the difference in
> "reg" between "fsl,gianfar-mdio" and "fsl-gianfar-tbi" -- and should give an
> example of the latter.

I don't remember how much I tested it, but I'm pretty sure that at
some of the suspect devices did work for me.  My goal was to maintain
compatibility with existing device trees, and just refactor the code
so that it's easier to read.
