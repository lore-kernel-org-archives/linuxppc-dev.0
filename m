Return-Path: <benh@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4AFB6DDE09
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 12:50:43 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l0U25TgL204338
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 13:05:29 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by sd0208e0.au.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l0U1sAEX190082
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 12:54:10 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l0U1oeYR017910
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 12:50:40 +1100
Subject: Re: EMAC OF binding....
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <7BADAAC7-D139-4C1A-A799-93F46508880E@kernel.crashing.org>
References: <OF7EF2F643.75F7008B-ON8625725D.00157658-8625725D.00167CB4@au1.ibm.com>
	<1168236558.22458.187.camel@localhost.localdomain>
	<8ee3d13b73a511a785ac4744c268943e@kernel.crashing.org>
	<1170116712.26655.293.camel@localhost.localdomain>
	<7BADAAC7-D139-4C1A-A799-93F46508880E@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 30 Jan 2007 12:50:32 +1100
Message-Id: <1170121832.26655.301.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Christian Rund <Christian.Rund@de.ibm.com>,
	Hartmut Penner <HPENNER@de.ibm.com>, Murali N Iyer <mniyer@us.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Does emac really vary that much between the chips its in?  I know  
> chatting with Ben that axon did some evil things, but how much  
> difference exists on 4xx implementations?

They all seem to have subtle differences, which is why I want the actual
chip to be the first entry in the compatible property.

Ben.
