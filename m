Return-Path: <htejun@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id 3B26167C32
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 00:56:09 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id b21so258358ana
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Dec 2006 05:56:07 -0800 (PST)
Message-ID: <457D636F.9020806@gmail.com>
Date: Mon, 11 Dec 2006 22:55:59 +0900
From: Tejun Heo <htejun@gmail.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Oops in pata_pdc2027x
References: <20061205170144.0b98d7e6.sfr@canb.auug.org.au>	
	<457790F0.2070208@tw.ibm.com>
	<1165651032.1103.123.camel@localhost.localdomain>
In-Reply-To: <1165651032.1103.123.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	ppc-dev <linuxppc-dev@ozlabs.org>, albertl@mail.com,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> Could that be related to the fix
> 
> [PATCH] libata: fix oops with sparsemem
> 
> That Arnd Bergmann just posted ? I'm copying it below in case you
> haven't seen it.

Seems to be the same problem to me.  I'll reply in the original thread.

Thanks.

-- 
tejun
