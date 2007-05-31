Return-Path: <SRS0+b6be5a7e4fb03e41cd25+1376+infradead.org+hch@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6F238DDF9B
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 23:41:41 +1000 (EST)
Date: Thu, 31 May 2007 14:41:18 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Thomas Klein <osstklei@de.ibm.com>
Subject: Re: [PATCH 2/2] ehea: Receive SKB Aggregation
Message-ID: <20070531134118.GA30501@infradead.org>
References: <200705311354.56979.osstklei@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200705311354.56979.osstklei@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	Stefan Roscher <ossrosch@linux.vnet.ibm.com>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm still very unhappy with having all this in various drivers.  There's
a lot of code that can be turned into generic library functions, and even
more code that could be made generic with some amount of refactoring.
