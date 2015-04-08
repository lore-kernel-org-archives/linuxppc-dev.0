Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 91A521A0A05
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 03:34:00 +1000 (AEST)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1YftrQ-002Wyi-NO
 for linuxppc-dev@lists.ozlabs.org; Wed, 08 Apr 2015 17:33:56 +0000
Date: Wed, 8 Apr 2015 10:32:36 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>
Subject: Re: [PATCH v5 0/4] hwmon: (ibmpowernv) add DTS support
Message-ID: <20150408173236.GB26109@roeck-us.net>
References: <1428513590-5773-1-git-send-email-clg@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1428513590-5773-1-git-send-email-clg@fr.ibm.com>
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

On Wed, Apr 08, 2015 at 07:19:46PM +0200, Cédric Le Goater wrote:
> Hello !
> 
> These patches extend the ibmpowernv driver to support the new OPAL firmware 
> which now exposes in its device tree the Digital Temperature Sensors of 
> a P8 system.
> 
> They are based on Linux 4.0.0-rc7 + the initial cleanup serie :
> 
>      http://lists.lm-sensors.org/pipermail/lm-sensors/2015-March/043670.html
> 
> and were tested on IBM Power and Open Power systems running Trusty.
> 
Series applied to -next.

Thanks,
Guenter
