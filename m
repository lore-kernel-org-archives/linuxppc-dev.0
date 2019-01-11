Return-Path: <SRS0=2HDf=PT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B35C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 06:07:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1AF320675
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 06:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1AF320675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bXTW4CgBzDr2P
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 17:07:43 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bXRn0y2fzDr1P
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 17:06:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43bXRm3Kxfz9sCs;
 Fri, 11 Jan 2019 17:06:12 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: Kconfig label updates
In-Reply-To: <83241c8b-8f44-162b-b42a-0f4f9bb858e7@linux.vnet.ibm.com>
References: <20190108223024.GA147017@google.com>
 <87tviiroqy.fsf@concordia.ellerman.id.au>
 <83241c8b-8f44-162b-b42a-0f4f9bb858e7@linux.vnet.ibm.com>
Date: Fri, 11 Jan 2019 17:06:12 +1100
Message-ID: <874lafg23v.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linux-pci@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Tyrel Datwyler <tyreld@linux.vnet.ibm.com> writes:
> On 01/09/2019 04:37 AM, Michael Ellerman wrote:
>> Bjorn Helgaas <helgaas@kernel.org> writes:
>>> I want to update the PCI Kconfig labels so they're more consistent and
>>> useful to users, something like the patch below.  IIUC, the items
>>> below are all IBM-related; please correct me if not.
>>>
>>> I'd also like to expand (or remove) "RPA" because Google doesn't find
>>> anything about "IBM RPA", except Robotic Process Automation, which I
>>> think must be something else.
>> 
>> Yeah I think just remove it, it's not a well known term and is unlikely
>> to help anyone these days.
>> 
>> It stands for "RISC Platform Architecture", which was some kind of
>> specification for Power machines back in the day, but from what I can
>> tell it was never used in marketing or manuals much (hence so few hits
>> on Google).
>
> It is basically the predecessor to PAPR "Power Architecture Platform Reference".
> Which the LoPAPR document is available through power.org. Not sure if there is
> any desire to adopt PAPR in place of RPA. It is the platform reference doc that
> outlines how we do DLPAR and PCI Hotplug.

True. But a user is unlikely to know "PAPR" either, and it googles badly.

LoPAPR I guess is better, you can google for it, though I'm not entirely
sure if everything used by this code is actually in LoPAPR, because some
bits of PAPR were ripped out of LoPAPR.

>>> Ideally the PCI Kconfig labels would match the terms used in
>>> arch/.../Kconfig, e.g.,
>>>
>>>   config PPC_POWERNV
>>>     bool "IBM PowerNV (Non-Virtualized) platform support"
>>>
>>>   config PPC_PSERIES
>>>     bool "IBM pSeries & new (POWER5-based) iSeries"
>> 
>> TBH these are pretty unhelpful too. PowerNV is not a marketing name and
>> so doesn't appear anywhere much in official manuals or brochures and
>> it's also used on non-IBM branded machines. And pSeries & iSeries were
>> marketing names but are no longer used.
>
> pseries is still used as a machine type for PAPR compliant qemu/kvm instances.

Yeah so I guess it's helpful for someone configuring a kernel with that
in mind.

But if you've bought an IBM branded system the "pseries" name is not
used anywhere AFAIK.

cheers
