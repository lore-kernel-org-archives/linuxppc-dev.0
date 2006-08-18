Return-Path: <SRS0+9c5c8d7c21a472aa6c73+1090+infradead.org+arjan@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 60D4A67B66
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 22:17:40 +1000 (EST)
Subject: Re: [2.6.19 PATCH 3/7] ehea: queue management
From: Arjan van de Ven <arjan@infradead.org>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
In-Reply-To: <200608181331.19501.ossthema@de.ibm.com>
References: <200608181331.19501.ossthema@de.ibm.com>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 14:17:31 +0200
Message-Id: <1155903451.4494.168.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Klein <osstklei@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +	queue->queue_length = nr_of_pages * pagesize;
> +	queue->queue_pages = vmalloc(nr_of_pages * sizeof(void *));


wow... is this really so large that it warrants a vmalloc()???
