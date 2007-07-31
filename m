Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AF719DDE38
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 10:00:40 +1000 (EST)
Message-ID: <46AE7B9E.7030505@garzik.org>
Date: Mon, 30 Jul 2007 20:00:30 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 0/4][RFC] lro: Generic Large Receive Offload for TCP
	traffic
References: <200707301724.33865.ossthema@de.ibm.com>	<46AE0F36.8030605@garzik.org>
	<20070730.154332.72713181.davem@davemloft.net>
In-Reply-To: <20070730.154332.72713181.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: tklein@de.ibm.com, themann@de.ibm.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, raisch@de.ibm.com,
	linuxppc-dev@ozlabs.org, ossthema@de.ibm.com, meder@de.ibm.com,
	gallatin@myri.com, stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Miller wrote:
> From: Jeff Garzik <jeff@garzik.org>
> Date: Mon, 30 Jul 2007 12:17:58 -0400
> 
>> David, thoughts on merging?  I'm not We could stick this into your tree 
>> or mine.  Whether yours or mine, I would like to keep the driver and 
>> net-core patches together in the same git tree.
> 
> No objections and I'll stick it into my net-2.6.24 tree once I cut
> that, I'll have the NAPI stuff in there too so I'll keep these two
> merge nightmares out of your hair :-)

Works for me.

Thanks,

	Jeff
