Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id C149ADDEE4
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 03:29:11 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so286493wag
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 10:29:08 -0700 (PDT)
Message-ID: <fa686aa40710181029o6852b1b0pf6259f27cabfd085@mail.gmail.com>
Date: Thu, 18 Oct 2007 11:29:08 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Milton Miller" <miltonm@bga.com>
Subject: Re: [PATCH 1/2] qemu platform, v2
In-Reply-To: <440d60abf1ef533839cf5d9beb0584c9@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <boot-8-00.miltonm@bga.com> <qemu-8-01.miltonm@bga.com>
	<20070922095546.GA14185@lst.de> <200709221416.21580.rob@landley.net>
	<18165.60185.316393.213864@cargo.ozlabs.ibm.com>
	<4d27912d86d1373ca01d43bd296e237b@kernel.crashing.org>
	<20071001053326.GA15132@localhost.localdomain>
	<fa686aa40710171328y195aca9k6ee8a1a5502fcf57@mail.gmail.com>
	<47172E80.6090902@genesi-usa.com>
	<440d60abf1ef533839cf5d9beb0584c9@bga.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Rob Landley <rob@landley.net>, Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/18/07, Milton Miller <miltonm@bga.com> wrote:
> On Oct 18, 2007, at 4:59 AM, Matt Sealey wrote:
> > Which begs the question; why cloning?
> >
> > Why can't development be MOVED to in-kernel?
>
> Because we don't put userspace testsuites there for one.
>
> And its a stand alone tool and should have its own packaging for a
> second (ie the kernel provides the kernel and modules, but not random
> user space utilities, in its tarbal).
>
> If we say only some boards or ports are special and need to build then
> I would vote for shipping asm files.  If we think we need to build any
> random embedded platform without installing dtc then we should merge
> dtc.

I don't think we do.  It's looking like there are going to be out of
tree users of dtc also (The are some patches floating around for
u-boot to use the device tree for it's own initialization).  I don't
think it's unreasonable to install dtc for embedded development.

I like the idea of shipping asm files to support the qemu target; at
least until qemu gets better firmware.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
