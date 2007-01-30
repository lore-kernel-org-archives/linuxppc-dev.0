Return-Path: <rachita@in.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B25BCDDEDD
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 21:26:35 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0UAQUL8024087
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 05:26:30 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l0UAQUYi513882
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 03:26:30 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l0UAQUNU030656
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 03:26:30 -0700
Received: from localhost.localdomain (ocean.in.ibm.com [9.124.35.47])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l0UAQT20030615
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 03:26:30 -0700
Date: Tue, 30 Jan 2007 15:55:45 +0530
From: Rachita Kothiyal <rachita@in.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Soft reset button on PowerPC
Message-ID: <20070130102545.GA2762@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Reply-To: rachita@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi

I am looking for 'Soft reset' button on Power4/Power5 boxes. Is it the same
as the yellow reset button commonly found on the front panels of these
machines? It will be great if someone can provide me pointers regarding
the location of the button.

On Power5 boxes, function 22 on the Operator Control Panel is meant for
dump triggering. But when I try it on a p520 box running Linux, nothing
happens and the system continues to run. I suspect I am missing support
from the Operating System. Does anyone know how I can enable support for 
this function from Linux?  

I am investigating methods for triggering a dump(Kdump) on hard hang on
stand-alone PowerPC boxes (no HMC, single Lpar), and hence need to figure
out if any of the above methods can be used.

Any pointers will be of great help. Please Cc me, as I am not subscribed 
to the list.

Thanks
Rachita
