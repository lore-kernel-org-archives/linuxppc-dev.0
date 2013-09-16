Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 33DBA2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Sep 2013 06:44:12 +1000 (EST)
Message-ID: <1379364243.2536.154.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/2] powerpc/fsl-booke: Add initial T104x_QDS board support
From: Scott Wood <scottwood@freescale.com>
To: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
Date: Mon, 16 Sep 2013 15:44:03 -0500
In-Reply-To: <071A08F2C6A57E4E94D980ECA553F874F607E1@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1378882706-19488-1-git-send-email-prabhakar@freescale.com>
 <1378942885.12204.448.camel@snotra.buserror.net>
 <071A08F2C6A57E4E94D980ECA553F874F607E1@039-SN1MPN1-006.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
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

On Fri, 2013-09-13 at 02:35 -0500, Kushwaha Prabhakar-B32579 wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Thursday, September 12, 2013 5:11 AM
> > To: Kushwaha Prabhakar-B32579
> > Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org; Jain
> > Priyanka-B32167; Aggrwal Poonam-B10812
> > Subject: Re: [PATCH 1/2] powerpc/fsl-booke: Add initial T104x_QDS board
> > support
> > 
> > On Wed, 2013-09-11 at 12:28 +0530, Prabhakar Kushwaha wrote:
> > > +	aliases {
> > > +		 /* TODO */
> > > +		};
> > 
> > TODO?  Did you mean this patch as an RFC?
> > 
> 
> 
> actually, this patch is not adding in dpaa related node(fman,bman etc).
> I am keeping place holder for alias of Ethernet nodes. 

If you don't have any board-level aliases yet, then just don't include
the aliases node in this file.

> > Also, whitespace.
> > 
> 
> does whitespace is not captured in checkpatch?

Not in dts files.

> > Maybe some of this stuff could be put in a common dtsi between t1040 and
> > t1042?
> > 
> > Ideally for t1042 you'd just take the entire t1040 tree as an include,
> > and add the switch
> > 
> 
> means, I just create T1042qds.dts and for T1040.dts include t1042dts + switch

Is it t1040 that has the switch or t1042?

-Scott
