Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rCrbp3LVmzDqD8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 May 2016 18:01:54 +1000 (AEST)
Message-ID: <1463990507.3078.16.camel@kernel.crashing.org>
Subject: Re: PAGE_GUARDED
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>, linuxppc-dev@lists.ozlabs.org
Cc: darren@stevens-zone.net
Date: Mon, 23 May 2016 18:01:47 +1000
In-Reply-To: <8B4C4AB7-5C17-4992-935A-361153472793@xenosoft.de>
References: <8B4C4AB7-5C17-4992-935A-361153472793@xenosoft.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-05-23 at 06:38 +0200, Christian Zigotzky wrote:
> Hi All,
> 
> You removed PAGE_GUARDED in the commit  
> 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commi
> t/?id=c04a5880299eab3da8c10547db96ea9cdffd44a6
> 
> We use
> 
> range.size, _PAGE_NO_CACHE|_PAGE_GUARDED);
> 
> This doesn't work anymore. What can we use instead?

You should just use pgprot_noncached()

Cheers,
Ben.
