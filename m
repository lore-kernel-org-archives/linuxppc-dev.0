Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 891B368062
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 08:28:30 +1000 (EST)
In-Reply-To: <6d145b4205080914506cbc5e80@mail.gmail.com>
References: <6d145b42050808193058ee05b4@mail.gmail.com>
	<5c9191bc3e15d90c966735662c28fa5e@embeddededge.com>
	<6d145b42050809075718c70574@mail.gmail.com>
	<e0e99d07a5f20187cf45caac1ee9fa10@embeddededge.com>
	<6d145b4205080914506cbc5e80@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d0f29f34fcf3c6342862a8f5fbb1b61b@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 9 Aug 2005 18:28:54 -0400
To: Prashant Alange <prashant.alange@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: How to disable dcache on MPC82xx platform
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 9, 2005, at 5:50 PM, Prashant Alange wrote:

> ....... I am linking multiple BDs only but
> no of BDs are very large in my case so I am allocating the memory and
> updating the BD pointer for all BDs.

I don't understand what you mean here.

> If i use mem= option as kernel command line argument then I will have
> to just ioremap() this reserved address in my driver and start
> accessing the memory.  I do not have to worry about cache related
> things.  right?

Yes.

	-- Dan
