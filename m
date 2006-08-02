Return-Path: <segher@kernel.crashing.org>
Received: from mail.arcor.de (mail-in-05.arcor-online.net [151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F320467BA0
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Aug 2006 15:36:06 +1000 (EST)
In-Reply-To: <1154474791.3987.7.camel@localhost.localdomain>
References: <1154024154.29826.229.camel@goblue>
	<1154024834.29826.240.camel@goblue>
	<1154320382.19883.26.camel@localhost.localdomain>
	<1154379714.29826.396.camel@goblue>
	<1154474791.3987.7.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <304693AC-39D8-40C1-AFC9-4A0F66549548@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH][2/2] RTAS MSI
Date: Wed, 2 Aug 2006 07:35:57 +0200
To: michael@ellerman.id.au
Cc: linuxppc-dev@ozlabs.org, PaulMackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I'm not sure what disable really needs to do, but I think drivers  
> might
> expect it to set dev->irq back to the LSI value, even if we don't free
> anything internally. Not sure.

Yes, that's required by the MSI API.


Segher
