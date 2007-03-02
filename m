Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 65104DDF17
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Mar 2007 19:33:47 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id l228Xh99234022
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Mar 2007 08:33:43 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l228XhX61597588
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Mar 2007 09:33:43 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l228XgVf006685
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Mar 2007 09:33:43 +0100
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH 2.6.21-rc2] ehca: fix mismatched sync between completion
	handler and destroy cq
Date: Fri, 2 Mar 2007 09:37:46 +0100
References: <200702281801.02747.hnguyen@linux.vnet.ibm.com>
	<ada8xegr7zu.fsf@cisco.com>
In-Reply-To: <ada8xegr7zu.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703020937.47012.hnguyen@linux.vnet.ibm.com>
Cc: heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hch@infradead.org,
	linuxppc-dev@ozlabs.org, raisch@de.ibm.com, general@lists.openfabrics.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>  > +#include <linux/completion.h>
> This can just be <linux/wait.h>, because you're only using
> wait_queue_head_t and not struct completion, right?
> I fixed this up before merging.
Yes, right. Thanks for your help!
Regards
Nam 
