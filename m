Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsg6d0bLxzDqhn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 06:53:28 +1000 (AEST)
Date: Tue, 20 Jun 2017 13:53:24 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: clg@kaod.org, stewart@linux.vnet.ibm.com, jdelvare@suse.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com,
 linux-hwmon@vger.kernel.org
Subject: Re: [PATCH V2 0/2] hwmon: (ibmpowernv) Add support for current(A)
 sensors
Message-ID: <20170620205324.GA28761@roeck-us.net>
References: <1497935293-31618-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1497935293-31618-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 20, 2017 at 10:38:11AM +0530, Shilpasri G Bhat wrote:
> The first patch from Cedric in the patchset cleans up the driver to
> provide a neater way to define new sensor types. The second patch adds
> current sensor.
> 
> Cédric Le Goater (1):
>   hwmon: (ibmpowernv) introduce a legacy_compatibles array
> 
> Shilpasri G Bhat (1):
>   hwmon: (ibmpowernv) Add current(A) sensor
> 

Series applied to hwmon-next.

Thanks,
Guenter
