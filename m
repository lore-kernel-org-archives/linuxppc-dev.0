Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BCBAC67A6D
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 21:35:23 +1000 (EST)
In-Reply-To: <447C20C4.50804@yahoo.fr>
References: <1147988040.2692.40.camel@basalt.austin.ibm.com>	<17516.64514.854281.64425@cargo.ozlabs.ibm.com>
	<1148593014.15517.32.camel@basalt.austin.ibm.com>
	<447C20C4.50804@yahoo.fr>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ecea6f4aafae5a453662340020d4cc88@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch] fix RTC/NVRAM accesses on Maple
Date: Tue, 30 May 2006 13:38:01 +0200
To: jfaslist <jfaslist@yahoo.fr>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> So the RTC/NVRAM patch is no longer needed for the Maple?
> Thanks
> -jf simon

[Post-top not do.  Backwards read not do people.]

Hollis' latest patch is needed still.  We agreed not to solve it
completely correctly yet, as we'll need more surgery in other parts
of the PowerPC kernel first.


Segher
