Return-Path: <drfickle@us.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 59E12679F0
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Jul 2006 03:00:59 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6BH0sgl005443
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jul 2006 13:00:54 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6BH0sqc266256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jul 2006 13:00:54 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6BH0sjL014578
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jul 2006 13:00:54 -0400
Subject: Re: Linux v2.6.18-rc1
From: Steve Fox <drfickle@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1152566236.1576.100.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
	<pan.2006.07.07.15.41.35.528827@us.ibm.com>
	<1152441242.4128.33.camel@localhost.localdomain>
	<1152537672.28828.4.camel@farscape.rchland.ibm.com>
	<1152542413.27368.131.camel@localhost.localdomain>
	<1152566236.1576.100.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 12:00:52 -0500
Message-Id: <1152637252.2853.5.camel@flooterbu>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-07-11 at 07:17 +1000, Benjamin Herrenschmidt wrote:

> it's most certainly an irq problem as I just rewrote the irq logic of
> powerpc :) There have been some issues and I've just sent some new
> patches fixing them, let's see if that's enough. I'll give a js20 a try
> today at work.

FWIW, I tried applying the 3 non-Apple-specific patches posted on 7/10
but this didn't help.

-- 

Steve Fox
IBM Linux Technology Center
