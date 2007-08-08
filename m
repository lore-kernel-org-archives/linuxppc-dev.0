Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 53B35DDE1B
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 06:43:39 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IIsNR-0004f9-7n
	for linuxppc-dev@ozlabs.org; Wed, 08 Aug 2007 22:43:33 +0200
Received: from bi01p1.co.us.ibm.com ([32.97.110.142])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Wed, 08 Aug 2007 22:43:33 +0200
Received: from hollisb by bi01p1.co.us.ibm.com with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Wed, 08 Aug 2007 22:43:33 +0200
To: linuxppc-dev@ozlabs.org
From: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: Fix small race in 44x tlbie function
Date: Wed, 8 Aug 2007 20:43:25 +0000 (UTC)
Message-ID: <f9d9td$nov$1@sea.gmane.org>
References: <20070807042050.GJ13522@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: news <news@sea.gmane.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 07 Aug 2007 14:20:50 +1000, David Gibson wrote:
> 
> This patch fixes the problem in both arch/ppc and arch/powerpc by
> inhibiting interrupts (even critical and debug interrupts) across the
> relevant instructions.

How could a critical or debug interrupt modify the contents of MMUCR?

-- 
Hollis Blanchard
IBM Linux Technology Center
