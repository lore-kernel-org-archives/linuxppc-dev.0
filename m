Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1AEA6B71C1
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 08:50:23 +1100 (EST)
Subject: Re: [RFC][PATCH 15/30] powerpc/85xx: Rework P1022DS device tree
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4EC42F6E.2030500@freescale.com>
Date: Wed, 16 Nov 2011 15:50:18 -0600
Message-Id: <EB5A7571-86D7-44BC-BC4C-29BA5D93C629@kernel.crashing.org>
References: <1320941653-29797-1-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-4-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-5-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-6-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-7-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-8-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-9-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-10-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-11-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-12-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-13-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-14-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-15-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-16-git-send-email-galak@kernel.crashing.org>
 <CAOZdJXU6NXgWv=VwShOvEGH5rm0KJmrQgOCVDiSJtKoVMs5=eg@mail.gmail.com>
 <4EC42F6E.2030500@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 16, 2011, at 3:47 PM, Timur Tabi wrote:

> wrote:
>> I just noticed this bug in the original p1022ds.dts, and I see you're
>> carrying it over here.  The reg property should look like this:
>> 
>> reg = <0xf 0xffe05000 0 0x1000>;
>>       ^^^
> 
> It looks like there's also a problem with the 'ranges' property:
> 
> 	ranges = <0x0 0x0 0xf 0xe8000000 0x08000000
> 		  0x1 0x0 0xf 0xe0000000 0x08000000
> 		  0x2 0x0 0x0 0xffa00000 0x00040000
> 		          ^^^
> 		  0x3 0x0 0xf 0xffdf0000 0x00008000>;

Gotcha, existing bug but will fix it.

- k
