Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F00F71A2A88
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2015 02:27:34 +1100 (AEDT)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1YYypf-002kd1-3L
 for linuxppc-dev@lists.ozlabs.org; Fri, 20 Mar 2015 15:27:31 +0000
Date: Fri, 20 Mar 2015 08:26:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>
Subject: Re: [PATCH v2 0/5] hwmon: (ibmpowernv) remove dependency on OPAL index
Message-ID: <20150320152611.GA10749@roeck-us.net>
References: <1423117857-32759-1-git-send-email-clg@fr.ibm.com>
 <1426787085-9004-1-git-send-email-clg@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1426787085-9004-1-git-send-email-clg@fr.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, lm-sensors@lm-sensors.org,
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

On Thu, Mar 19, 2015 at 06:44:40PM +0100, Cédric Le Goater wrote:
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
Series applied to hwmon-next (with patch #4 fixed up).

Thanks,
Guenter
