Return-Path: <ossthema@de.ibm.com>
Received: from mtagate8.uk.ibm.com (mtagate8.uk.ibm.com [195.212.29.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 26744DE10A
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Aug 2007 17:32:03 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate8.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l767Vtol117108
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 07:31:55 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.4) with
	ESMTP id l767VtRR2666618
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 08:31:55 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l767VmX7026183
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 08:31:49 +0100
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: "Kok, Auke" <auke-jan.h.kok@intel.com>
Subject: Re: [PATCH] lro: eHEA example how to use LRO
Date: Mon, 6 Aug 2007 09:01:51 +0200
References: <200708031441.26841.ossthema@de.ibm.com>
	<46B39030.7030009@intel.com>
In-Reply-To: <46B39030.7030009@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708060901.53336.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, Andrew Gallatin <gallatin@myri.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Auke,

On Friday 03 August 2007 22:29, Kok, Auke wrote:
> Jan-Bernd Themann wrote:
> > This patch shows how the generic LRO interface is used for SKB mode
> > 
> > Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
> > 
> > ---
> >  drivers/net/Kconfig             |    1 +
> >  drivers/net/ehea/ehea.h         |    9 ++++-
> >  drivers/net/ehea/ehea_ethtool.c |   15 +++++++
> >  drivers/net/ehea/ehea_main.c    |   84 +++++++++++++++++++++++++++++++++++---
> >  4 files changed, 101 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> > index f8a602c..fec4004 100644
> > --- a/drivers/net/Kconfig
> > +++ b/drivers/net/Kconfig
> 
> <snip>
> 
> > +module_param(use_lro, int, 0);
> 
> Have you looked at my generic lro get/set patch that I posted this week? this 
> adds a useless module parameter while ethtool has all the structure already to 
> accomodate setting lro on/off.
> 

Yes, I saw your patch. Looks very good to me. I will modify our driver soon
to use ethtool instead of this module parameter.

Thanks for adding this support to the ethtool interface.
