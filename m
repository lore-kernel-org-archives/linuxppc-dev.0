Return-Path: <davem@davemloft.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E9098B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Aug 2009 04:48:43 +1000 (EST)
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id A067ADDD04
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Aug 2009 04:48:43 +1000 (EST)
Date: Tue, 04 Aug 2009 11:48:49 -0700 (PDT)
Message-Id: <20090804.114849.263290756.davem@davemloft.net>
To: hannes.hering@linux.vnet.ibm.com
Subject: Re: [PATCH 2.6.31] ehea: Fix napi list corruption on ifconfig down
From: David Miller <davem@davemloft.net>
In-Reply-To: <200908041620.16542.hannes.hering@linux.vnet.ibm.com>
References: <200908041620.16542.hannes.hering@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: themann@de.ibm.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	raisch@de.ibm.com, ossrosch@linux.vnet.ibm.com,
	linuxppc-dev@ozlabs.org, ossthema@de.ibm.com, osstklei@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hannes Hering <hannes.hering@linux.vnet.ibm.com>
Date: Tue, 4 Aug 2009 16:20:15 +0200

> This patch fixes the napi list handling when an ehea interface is shut down to
> avoid corruption of the napi list.
> 
> Signed-off-by: Hannes Hering <hering2@de.ibm.com>

Applied, thanks.
