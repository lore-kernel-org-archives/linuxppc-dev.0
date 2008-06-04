Return-Path: <y-goto@jp.fujitsu.com>
Received: from fgwmail7.fujitsu.co.jp (fgwmail7.fujitsu.co.jp [192.51.44.37])
	by ozlabs.org (Postfix) with ESMTP id 19DB2DDD04
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 15:31:38 +1000 (EST)
Date: Wed, 04 Jun 2008 14:27:16 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Jeff Garzik <jeff@garzik.org>, Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH 2/2] ehea: remove dependency on MEMORY_HOTPLUG
In-Reply-To: <4845C8D1.4080808@garzik.org>
References: <20080603223128.GD7475@localdomain> <4845C8D1.4080808@garzik.org>
Message-Id: <20080604142112.979F.E1E9C6FF@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: tklein@de.ibm.com, themann@de.ibm.com,
	Hannes Hering <hannes.hering@linux.vnet.ibm.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	ossrosch@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
	raisch@de.ibm.com, Badari Pulavarty <pbadari@us.ibm.com>,
	ossthema@de.ibm.com, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

I'm working for memory hotplug. This patch looks good to me. 

Acked-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Thanks.

> Nathan Lynch wrote:
> > Now that walk_memory_resource() is available regardless of
> > MEMORY_HOTPLUG's setting, this dependency is not needed.
> > 
> > Signed-off-by: Nathan Lynch <ntl@pobox.com>
> > ---
> >  drivers/net/Kconfig |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> > index dd0ec9e..f4182cf 100644
> > --- a/drivers/net/Kconfig
> > +++ b/drivers/net/Kconfig
> > @@ -2426,7 +2426,7 @@ config CHELSIO_T3
> >  
> >  config EHEA
> >  	tristate "eHEA Ethernet support"
> > -	depends on IBMEBUS && INET && SPARSEMEM && MEMORY_HOTPLUG
> > +	depends on IBMEBUS && INET && SPARSEMEM
> >  	select INET_LRO
> 
> ACK, please send via appropriate target for memory hotplug stuff
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Yasunori Goto 
