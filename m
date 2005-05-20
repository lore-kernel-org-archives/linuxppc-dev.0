Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3256E67A39
	for <linuxppc-dev@ozlabs.org>; Sat, 21 May 2005 00:27:57 +1000 (EST)
In-Reply-To: <17037.32285.607543.859030@cargo.ozlabs.ibm.com>
References: <17037.32285.607543.859030@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0b53908f87096525543bc4f660c613b6@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 20 May 2005 10:28:05 -0400
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Set cpu type explicitly, take 2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 20, 2005, at 2:05 AM, Paul Mackerras wrote:

> Any further comments?  Are -mcpu=860 and -mcpu=8540 reasonable for 8xx
> and 85xx respectively?

Yes.

Is there now some minimum gcc version that is required for
using these flags?

Thanks.

	-- Dan
