Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail7.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BDA9EB7099
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 11:44:35 +1000 (EST)
Message-ID: <4A8B5929.2030000@windriver.com>
Date: Wed, 19 Aug 2009 09:45:13 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: powerpc/405ex: Support cuImage for PPC405EX
References: <1250562484-16415-1-git-send-email-tiejun.chen@windriver.com>
	<20090818132835.GA2530@zod.rchland.ibm.com>
In-Reply-To: <20090818132835.GA2530@zod.rchland.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Tue, Aug 18, 2009 at 10:28:02AM +0800, Tiejun Chen wrote:
>> Summary: powerpc/405ex: Support cuImage for PPC405EX
>> Reviewers: Benjmain and linux-ppc
>> ----------------------------------------------------
>> These patch series are used to support cuImage on the kilauea board based on PPC405ex.
>>
>> Tested on the amcc kilauea board:
> 
> Hm.  The U-Boot version that ships on the AMCC Kilauea board is FDT aware, so
> cuImage shouldn't be needed at all.  I'm slightly confused why we need this.

That the newer u-boot can aware extra on Kilauea is really as you said. But I
think I/we need to consider some other requirements for 405EX, such as only
using one image for convenient on embedded system, and u-boot don't pass dtb for
kernel since it will be isolated with one customer software layer.

And actually to support old U-boot compatibility is original *goal* of
implementing cuImage in kernel as we know. Right?

As Documentation/powerpc/bootwrapper.txt I think the kernel should support more
image variant to satisfy different requirement. Sometimes that is also beyond we
can discuss here.

> Are you using it for some other board derived from 405EX that doesn't have
> an FDT aware U-Boot?
> 

Yes, this is really another factor. Anyway thinks your comments.

Best Reards
Tiejun

> josh
> 
