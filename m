Return-Path: <dan@embeddedalley.com>
Received: from smtp107.biz.mail.re2.yahoo.com (smtp107.biz.mail.re2.yahoo.com
	[206.190.52.176]) by ozlabs.org (Postfix) with SMTP id 554F3DDE48
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Oct 2007 03:29:19 +1000 (EST)
In-Reply-To: <C2771B73-A555-4119-AC21-1441D4CC2125@freescale.com>
References: <C2771B73-A555-4119-AC21-1441D4CC2125@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6915E3C3-52FA-4E8B-8D83-33F7EEF89F84@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: TASK_SIZE default 0x80000000 ?
Date: Sat, 6 Oct 2007 10:22:38 -0700
To: Kumar Gala <kumar.gala@freescale.com>
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


On Oct 6, 2007, at 6:36 AM, Kumar Gala wrote:

> In a discussion with Hollis over beer he raised the question why
> TASK_SIZE is 0x80000000 on ppc32.

Left over from the old days (2.1) of the PReP port when
things were hard coded.  We used some of the space
between 0x80000000 and 0xc0000000 for mapping
IO devices in the kernel.

> I was wondering if anyone know why this was still the case?  Seems
> like we have a 1Gb whole between TASK_SIZE & KERNELBASE.

I thought all of this was now configurable in the
advanced options.  The configuration files should
set the default to remove this gap.

	-- Dan
