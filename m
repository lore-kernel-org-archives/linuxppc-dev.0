Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 586B4DDF17
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Oct 2007 23:30:59 +1000 (EST)
In-Reply-To: <B108919F-98D7-45B0-BEB0-48D345F0BE4B@embeddedalley.com>
References: <C2771B73-A555-4119-AC21-1441D4CC2125@freescale.com>
	<18184.23379.478676.911097@cargo.ozlabs.ibm.com>
	<796C20BF-1592-4F07-B83B-5EA35CADBA01@kernel.crashing.org>
	<B108919F-98D7-45B0-BEB0-48D345F0BE4B@embeddedalley.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CA6DD911-5385-4198-B374-DE4BB75563FB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: TASK_SIZE default 0x80000000 ?
Date: Mon, 8 Oct 2007 08:31:04 -0500
To: Dan Malek <dan@embeddedalley.com>
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 7, 2007, at 1:35 PM, Dan Malek wrote:

>
> On Oct 7, 2007, at 8:02 AM, Kumar Gala wrote:
>
>> It would seem like we should set the default on 8xx & PReP to
>> 0x80000000 and not allow it to be modified
>
> For as much as this has been discussed in the past,
> I don't know why the 8xx doesn't check KERNEL_BASE
> and work properly with the options.  There is no reason
> this can't work.  The history is I wrote the tlb handlers
> to test the MS bit due to a hardcoded address, not that
> the address is hardcoded because I wanted to just
> test a bit.  Unlike PReP, there is no reason to
> disallow modification, if this test was changed.

Ok, I'll work up a patch for 8xx to test against PAGE_OFFSET (as benh  
suggested).

- k
