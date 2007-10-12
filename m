Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7E05CDDE09
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Oct 2007 00:41:15 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9CEfA2Z009293
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 10:41:10 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9CEfAt4403086
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 08:41:10 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9CEfA62022298
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 08:41:10 -0600
Subject: Re: [PATCH] PowerPC: Add NEW EMAC driver support to 440EPx Sequoia
	board.
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
In-Reply-To: <470F7188.5040107@ru.mvista.com>
References: <20071012130305.GA14682@ru.mvista.com>
	<470F7188.5040107@ru.mvista.com>
Content-Type: text/plain
Date: Fri, 12 Oct 2007 09:39:19 -0500
Message-Id: <1192199959.3061.45.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-10-12 at 17:07 +0400, Valentine Barshak wrote:
> This one has to be applied on top of the previously submitted RGMII patch:
> 
> http://ozlabs.org/pipermail/linuxppc-dev/2007-October/043435.html
> 
> Josh, are these OK, since Paul has NEW EMAC driver in his tree now?
> Thanks,
> Valentine.

I'll pull the one in the URL soon, yes.  This patch, and the RGMII
compile fix need to go in through netdev I think.  Unless Jeff says
otherwise.

josh
