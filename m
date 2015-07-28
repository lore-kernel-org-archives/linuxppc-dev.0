Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 489171A036E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 20:15:22 +1000 (AEST)
Message-ID: <1438078495.7562.135.camel@kernel.crashing.org>
Subject: Re: [PATCH v8 3/3] leds/powernv: Add driver for PowerNV platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, linux-leds@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, j.anaszewski@samsung.com,
 mpe@ellerman.id.au, rpurdie@rpsys.net, cooloney@gmail.com,
 khandual@linux.vnet.ibm.com, j.anaszewski81@gmail.com, arnd@arndb.de,
 stewart@linux.vnet.ibm.com
Date: Tue, 28 Jul 2015 20:14:55 +1000
In-Reply-To: <55B72369.5040102@gmail.com>
References: <1437801670-23705-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
 <1437801670-23705-4-git-send-email-hegdevasant@linux.vnet.ibm.com>
 <55B5540B.1000301@gmail.com> <55B5A853.3080909@linux.vnet.ibm.com>
 <55B72369.5040102@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-07-28 at 08:38 +0200, Jacek Anaszewski wrote:
> >>> +    /* Register the classdev */
> >>> +    rc = devm_led_classdev_register(dev, &powernv_led->cdev);
> >>> +    if (rc) {
> >>> +        dev_err(dev, "%s: Classdev registration failed for %s\n",
> >>> +            __func__, powernv_led->cdev.name);
> >>> +    }
> 
> Braces are not needed here,

Putting my old maintainer hat on for a minute ... this is serious nit
picking :-)

Arguably, the function being multi-line, the braces do make the code
more readable. This is a matter of taste which in such as case
which isn't a blatant violation of an important rule should be left to
the choice of the code implementor/maintainer.

Cheers,
Ben.
