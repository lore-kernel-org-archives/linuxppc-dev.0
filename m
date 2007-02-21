Return-Path: <johnrose@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5F5ACDDDE5
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2007 04:06:00 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l1LH5AgF028721
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 12:05:10 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1LH5vDH538584
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 10:05:57 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1LH5uM5029727
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 10:05:57 -0700
Subject: Re: [PATCH] ehea: dynamic add / remove port
From: John Rose <johnrose@austin.ibm.com>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
In-Reply-To: <200702211706.18235.ossthema@de.ibm.com>
References: <200702211706.18235.ossthema@de.ibm.com>
Content-Type: text/plain
Message-Id: <1172077378.22669.15.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Date: Wed, 21 Feb 2007 11:02:58 -0600
Cc: Thomas Klein <tklein@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <RAISCH@de.ibm.com>,
	Marcus Eder <MEDER@de.ibm.com>, Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-02-21 at 10:06, Jan-Bernd Themann wrote:
> This patch introduces functionality to dynamically add / remove
> ehea ports via an userspace DLPAR tool. It creates a subnode for
> each logical port in the sysfs. 

Looks great!

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
Acked-by: John Rose <johnrose@austin.ibm.com>
