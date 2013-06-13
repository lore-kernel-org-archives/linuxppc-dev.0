Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 97B542C008A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 02:51:55 +1000 (EST)
Date: Thu, 13 Jun 2013 11:51:22 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: add Book E support to 64-bit hibernation
To: Wang Dongsheng-B40534 <B40534@freescale.com>
References: <1370774260-31072-1-git-send-email-dongsheng.wang@freescale.com>
 <1371074628.18413.53@snotra>
 <ABB05CD9C9F68C46A5CEDC7F15439259F74985@039-SN2MPN1-021.039d.mgd.msft.net>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259F74985@039-SN2MPN1-021.039d.mgd.msft.net>
 (from B40534@freescale.com on Thu Jun 13 04:55:43 2013)
Message-ID: <1371142282.2028.10@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "anton@enomsg.org" <anton@enomsg.org>,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/13/2013 04:55:43 AM, Wang Dongsheng-B40534 wrote:
> > > +#else
> > > +	/* Save SPRGs */
> > > +	RESTORE_SPRG(0)
> > > +	RESTORE_SPRG(1)
> > > +	RESTORE_SPRG(2)
> > > +	RESTORE_SPRG(3)
> > > +	RESTORE_SPRG(4)
> > > +	RESTORE_SPRG(5)
> > > +	RESTORE_SPRG(6)
> > > +	RESTORE_SPRG(7)
> >
> > Why do we need this on book3e and not on book3s?
> >
> Book3e: SPRG1 used save paca, SPRG2 be defined =20
> SPRN_SPRG_TLB_EXFRAME,...
> I think those register should be save, even now some SPRG register =20
> not be use.

Are those expected/allowed to change as a result of the restore?

-Scott=
