Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5F58BB6F34
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 21:45:37 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7JBnXRT024517
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2009 07:49:33 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7JBjV56216204
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2009 07:45:31 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7JBjVAm029037
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2009 07:45:31 -0400
Date: Wed, 19 Aug 2009 07:45:28 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "tiejun.chen" <tiejun.chen@windriver.com>
Subject: Re: powerpc/405ex: Support cuImage for PPC405EX
Message-ID: <20090819114528.GC2530@zod.rchland.ibm.com>
References: <1250562484-16415-1-git-send-email-tiejun.chen@windriver.com>
	<20090818132835.GA2530@zod.rchland.ibm.com>
	<4A8B5929.2030000@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4A8B5929.2030000@windriver.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 19, 2009 at 09:45:13AM +0800, tiejun.chen wrote:
>Josh Boyer wrote:
>> On Tue, Aug 18, 2009 at 10:28:02AM +0800, Tiejun Chen wrote:
>>> Summary: powerpc/405ex: Support cuImage for PPC405EX
>>> Reviewers: Benjmain and linux-ppc
>>> ----------------------------------------------------
>>> These patch series are used to support cuImage on the kilauea board based on PPC405ex.
>>>
>>> Tested on the amcc kilauea board:
>> 
>> Hm.  The U-Boot version that ships on the AMCC Kilauea board is FDT aware, so
>> cuImage shouldn't be needed at all.  I'm slightly confused why we need this.
>
>That the newer u-boot can aware extra on Kilauea is really as you said. But I
>think I/we need to consider some other requirements for 405EX, such as only
>using one image for convenient on embedded system, and u-boot don't pass dtb for
>kernel since it will be isolated with one customer software layer.
>
>And actually to support old U-boot compatibility is original *goal* of
>implementing cuImage in kernel as we know. Right?

Yes.  Supporting _old_ U-Boot compatibility.  Not FDT aware U-Boot :).


>As Documentation/powerpc/bootwrapper.txt I think the kernel should support more
>image variant to satisfy different requirement. Sometimes that is also beyond we
>can discuss here.
>
>> Are you using it for some other board derived from 405EX that doesn't have
>> an FDT aware U-Boot?
>> 
>
>Yes, this is really another factor. Anyway thinks your comments.

That's fine then.  I have no real problems with having a cuImage that works
on Kilauea.  I just wouldn't want to promote it as the default because the
cuImage wrapper is a bit of a hack.

Anyway, I'll review the patches soon.  Thanks for the explanation.

josh
