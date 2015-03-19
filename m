Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D61611A09AE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 15:05:35 +1100 (AEDT)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1YYRi9-002yRl-Rd
 for linuxppc-dev@lists.ozlabs.org; Thu, 19 Mar 2015 04:05:33 +0000
Message-ID: <550A4B03.5070306@roeck-us.net>
Date: Wed, 18 Mar 2015 21:05:23 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?UTF-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@fr.ibm.com>,
 lm-sensors@lm-sensors.org
Subject: Re: [PATCH 0/5] hwmon: (ibmpowernv) remove dependency on OPAL index
References: <1423117857-32759-1-git-send-email-clg@fr.ibm.com>
 <1426693665-10797-1-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1426693665-10797-1-git-send-email-clg@fr.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org, Jean Delvare <jdelvare@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/18/2015 08:47 AM, Cédric Le Goater wrote:
> Hello !
>
> The current implementation of the driver uses an index for the hwmon
> attribute which is extracted from the device node name. This index
> is calculated by the OPAL firmware and its usage creates a dependency
> with the driver which makes changes a little more complex in OPAL.
>
> This patchset changes the ibmpowernv code to use its own index. It
> starts with a few cleanups, mostly code shuffling around the creation
> of the hwmon sysfs attributes and completes by removing the dependency.
>
> It also prepares ground for future OPAL changes :
>
>     https://lists.ozlabs.org/pipermail/skiboot/2015-March/000639.html
>
> which will be addressed in a other small patchset.
>
>
> The patches are based on Linux 4.0.0-rc4 and were tested on IBM Power
> and Open Power systems running Trusty.
>

I commented on two of the patches; the others are ok.

Please re-send the entire series after addressing my comments.

Thanks,
Guenter
