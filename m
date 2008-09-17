Return-Path: <CFRIESEN@nortel.com>
Received: from zcars04e.nortel.com (zcars04e.nortel.com [47.129.242.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B00E5DDF26
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Sep 2008 04:22:17 +1000 (EST)
Message-ID: <48D146C4.4010108@nortel.com>
Date: Wed, 17 Sep 2008 12:04:52 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
Subject: Re: build failure with current linus tree
References: <20080905010618.GA30278@lst.de> <20080909235626.GA5254@lst.de>
In-Reply-To: <20080909235626.GA5254@lst.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christoph Hellwig wrote:
> On Fri, Sep 05, 2008 at 03:06:18AM +0200, Christoph Hellwig wrote:
> 
>>Current linus tree fail to build for me for a 64bit powerpc config with:
> 
> 
> This is cause by
> 
> commit 7563dc64585324f443f5ac107eb6d89ee813a2d2
> Author: Tony Breeds <tony@bakeyournoodle.com>
> Date:   Tue Sep 2 16:50:38 2008 +1000
> 
>     powerpc: Work around gcc's -fno-omit-frame-pointer bug


Is there a proper fix other than simply reverting that commit?

Chris
