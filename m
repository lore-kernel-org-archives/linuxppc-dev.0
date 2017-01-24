Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v74N06Km8zDqJh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 21:36:00 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Darren Stevens <darren@stevens-zone.net>, linuxppc-dev@lists.ozlabs.org
Cc: Pat Wall <pjwall@mac.com>, "R.T.Dickinson" <rtd@a-eon.com>,
 Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: [PATCH v2] powerpc/pasemi: Remove hardcoded bus numbers on smbus
In-Reply-To: <49760dd87cb.596db16f@auth.smtp.1and1.co.uk>
References: <49760dd87cb.596db16f@auth.smtp.1and1.co.uk>
Date: Tue, 24 Jan 2017 21:35:59 +1100
Message-ID: <877f5kagog.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Darren Stevens <darren@stevens-zone.net> writes:
> The pasemi smbus controller uses PCI_FUNC(dev->devfn) to define which
> number bus to attach to, however this fails when something else is 
> probed first, for example an ATI Radeon graphics card will claim 9 or
> 10 busses, including the ones the pasemi wants.
> Patch the driver to call i2c_add_adapter rather than
> i2c_add_numbered_adapter.

This is an i2c patch so the subject should be something like:

i2c/pasemi: Remove hardcoded bus numbers on smbus

And it should be sent to:

wsa@the-dreams.de
linux-i2c@vger.kernel.org
linuxppc-dev@lists.ozlabs.org
linux-kernel@vger.kernel.org

cheers
