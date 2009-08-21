Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 84EF8B707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 22 Aug 2009 01:01:15 +1000 (EST)
Received: from mail-yw0-f171.google.com (mail-yw0-f171.google.com
	[209.85.211.171]) by ozlabs.org (Postfix) with ESMTP id E185FDDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Aug 2009 01:01:13 +1000 (EST)
Received: by ywh1 with SMTP id 1so1068190ywh.9
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 08:01:12 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1250834729.7625.5.camel@pasglop>
References: <20090821052714.2289.41279.stgit@localhost.localdomain>
	<20090821053014.2289.59798.stgit@localhost.localdomain>
	<1250834729.7625.5.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 21 Aug 2009 08:54:41 -0600
Message-ID: <fa686aa40908210754v2bc58553u90b10b87a6f1dc6a@mail.gmail.com>
Subject: Re: [PATCH 2/3] powerpc/pci: move pci_64.c device tree scanning code
	into pci-common.c
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 21, 2009 at 12:05 AM, Benjamin
Herrenschmidt<benh@kernel.crashing.org> wrote:
> On Thu, 2009-08-20 at 23:30 -0600, Grant Likely wrote:
>> From: Grant Likely <grant.likely@secretlab.ca>
>>
>> The PCI device tree scanning code in pci_64.c is some useful functionality.
>> It allows PCI devices to be described in the device tree instead of being
>> probed for, which in turn allows pci devices to use all of the device tree
>> facilities to describe complex PCI bus architectures like GPIO and IRQ
>> routing (perhaps not a common situation for desktop or server systems,
>> but useful for embedded systems with on-board PCI devices).
>>
>> This patch moves the device tree scanning into pci-common.c so it is
>> available for 32-bit powerpc machines too.
>
> I'd rather move it into a separate pci-of-scan.c file so we can more
> easily try to move it to drivers/of or drivers/pci for use by other
> archs later on.

Okay, I'll do that.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
