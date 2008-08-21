Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id EF91CDF960
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 09:14:58 +1000 (EST)
Received: by gxk14 with SMTP id 14so804014gxk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 16:14:57 -0700 (PDT)
Message-ID: <fa686aa40808211614q72f6719btd391830abded58f6@mail.gmail.com>
Date: Thu, 21 Aug 2008 17:14:57 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
In-Reply-To: <48ADDF86.2040200@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080821.001012.265401427.davem@davemloft.net>
	<20080821163256.GC15669@ld0162-tx32.am.freescale.net>
	<20080821.142134.127315039.davem@davemloft.net>
	<48ADDF86.2040200@freescale.com>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org,
	devicetree-discuss@ozlabs.org, paulus@samba.org,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 21, 2008 at 3:35 PM, Scott Wood <scottwood@freescale.com> wrote:
> David Miller wrote:
>>>
>>> On Thu, Aug 21, 2008 at 12:10:12AM -0700, David Miller wrote:
>> If you guys created this format in your compressed openfirmware
>> trees, is it possible for you to "fix" it to match what Sparc
>> systems following the proper bindings do?
>
> Possibly, though it'll cause some pain when old trees are used with a kernel
> that expects the new binding.

Ugh, more like loads of pain.  There are deployed platforms using the
embedded 'invented' bindings.  I don't think it is an option to break
compatibility with older trees.  If there is some backwards
compatibility code then I'm all for migrating to the same binding as
Sparc and PowerMac

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
