Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8A7A62C0110
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Sep 2013 02:48:49 +1000 (EST)
Message-ID: <1379522916.8901.0.camel@aoeu.buserror.net>
Subject: Re: [PATCH] powerpc/mpc85xx:Add initial device tree support of T104x
From: Scott Wood <scottwood@freescale.com>
To: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
Date: Wed, 18 Sep 2013 11:48:36 -0500
In-Reply-To: <071A08F2C6A57E4E94D980ECA553F874F8CA17@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1378882686-19454-1-git-send-email-prabhakar@freescale.com>
 <1378941854.12204.439.camel@snotra.buserror.net>
 <071A08F2C6A57E4E94D980ECA553F874F607C5@039-SN1MPN1-006.039d.mgd.msft.net>
 <1379366325.2536.178.camel@snotra.buserror.net>
 <071A08F2C6A57E4E94D980ECA553F874F8CA17@039-SN1MPN1-005.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Aggrwal Poonam-B10812 <B10812@freescale.com>,
 Jain Priyanka-B32167 <B32167@freescale.com>,
 Sethi Varun-B16395 <B16395@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-09-16 at 21:11 -0500, Kushwaha Prabhakar-B32579 wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Tuesday, September 17, 2013 2:49 AM
> > To: Kushwaha Prabhakar-B32579
> > Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org;
> > galak@kernel.crashing.org; Aggrwal Poonam-B10812; Jain Priyanka-B32167;
> > Sethi Varun-B16395
> > Subject: Re: [PATCH] powerpc/mpc85xx:Add initial device tree support of
> > T104x
> > 
> > On Fri, 2013-09-13 at 02:30 -0500, Kushwaha Prabhakar-B32579 wrote:
> > > > I also question the need to define separate t1040 compatible values
> > > > for all of these, if the only difference is whether the onboard
> > > > switch is enabled or not.
> > > >
> > >
> > > so should I use T104x as compatible field. and in T1040 device tree add
> > extra node for l2 switch.
> 
> I am using T1042 as base dts and T1040 includes T1040 + l2switch. 
> 
> so if I use T1042 in compatible. It will give wrong field for someone working on T1040QDS.

What is wrong about it?  It is compatible, right?

-Scott
