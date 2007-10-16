Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B7B67DDE3F
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 23:46:11 +1000 (EST)
In-Reply-To: <fa686aa40710160617o57564cb4r260a40cd66407852@mail.gmail.com>
References: <20071016050217.GA9052@localhost.localdomain>
	<fa686aa40710160617o57564cb4r260a40cd66407852@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <44F555C7-4324-4F70-8812-17883AFEFFE4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Merge dtc
Date: Tue, 16 Oct 2007 08:41:06 -0500
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 16, 2007, at 8:17 AM, Grant Likely wrote:

> On 10/15/07, David Gibson <david@gibson.dropbear.id.au> wrote:
>> This very large patch incorporates a copy of dtc into the kernel
>> source, in arch/powerpc/boot/dtc-src.  This means that dtc is no
>> longer an external dependency to build kernels with configurations
>> which need a dtb file.
>
> Powerpc is probably not going to be the only user of dtc.  Microblaze
> will be using it too.  Can it be put somewhere more common?

mkimage should also be put somewhere common since other archs use it.

- k
