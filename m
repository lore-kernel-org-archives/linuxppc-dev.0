Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 60BF567B91
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jul 2006 04:06:12 +1000 (EST)
Date: Thu, 13 Jul 2006 22:06:28 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: new IRQ stuff : some details?
Message-ID: <20060713220628.54c2912d@vitb.ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

As your irq rewrite touched mainstream, I am wondering about some details/directions to move fw and 
update the boards up to it. Currently, the irq numbers are messed (since the board has 2 Int controllers), and I am assuming some touch to devicetree is needed, but not sure what exactly.


Sorry if it have been brought up somewhere... 

-- 
Sincerely, 
Vitaly
