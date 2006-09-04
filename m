Return-Path: <romieu@fr.zoreil.com>
Received: from fr.zoreil.com (electric-eye.fr.zoreil.com [213.41.134.224])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B423267BE5
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Sep 2006 07:52:24 +1000 (EST)
Date: Mon, 4 Sep 2006 23:49:45 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [2.6.19 PATCH 1/7] ehea: interface to network stack
Message-ID: <20060904214945.GA30804@electric-eye.fr.zoreil.com>
References: <200609041237.46528.ossthema@de.ibm.com>
	<20060904201606.GA24386@electric-eye.fr.zoreil.com>
	<200609042311.21202.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200609042311.21202.arnd@arndb.de>
Cc: Thomas Klein <tklein@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann <arnd@arndb.de> :
[...]
> The driver should get merged as a single commit anyway, even
> if split diffs are posted for review. Even if it gets merged
> like this, bisect will work since the Kconfig option is added
> in the final patch.

I have seen/done worse but it's not exactly pretty.

[...]
> > > +?????int i;
> >
> > unsigned int ?
> 
> does it matter? int as a counter is pretty standard.

ppc64 takes unsigned int as a little optimization. I do not know how
the target platform behaves here.

-- 
Ueimor
