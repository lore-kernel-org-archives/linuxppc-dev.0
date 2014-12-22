Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6AEF61A0A16
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 14:55:55 +1100 (AEDT)
Message-ID: <1419220554.20221.4.camel@ellerman.id.au>
Subject: Re: [PATCH] misc: cxl: sysfs.c: Remove unused function
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Mon, 22 Dec 2014 14:55:54 +1100
In-Reply-To: <CAFo99ga9TYf5hnwOcoRPKsTHhhknoz6_axzP7spe0mvd=YPMLw@mail.gmail.com>
References: <1419092024-6701-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <1419134735.27324.41.camel@neuling.org>
 <CAFo99ga9TYf5hnwOcoRPKsTHhhknoz6_axzP7spe0mvd=YPMLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2014-12-21 at 13:46 +0100, Rickard Strandqvist wrote:
> 2014-12-21 5:05 GMT+01:00 Michael Neuling <mikey@neuling.org>:
> >> Remove the function mmio_size_show() that is not used anywhere.
> >
> > Did you compile check this patch?
> >
> >   drivers/misc/cxl/sysfs.c:291:74: error: ‘mmio_size_show’ undeclared here (not in a function)
> >
> > It's used here:
> >         static struct device_attribute afu_attrs[] = {
> >                 __ATTR_RO(mmio_size),
> 
> Hi
> 
> Sorry about that.
> 
> Strange because I compile everything as allyesconfig, allmodconfig and
> allnoconfig.

The allyes should have picked it up, so you must have done something wrong.

Please be more careful with these attribute routines, they are not visible with
grep.

cheers
