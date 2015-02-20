Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF7B11A0B5B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Feb 2015 03:52:20 +1100 (AEDT)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1YOqoL-001y8F-SM
 for linuxppc-dev@lists.ozlabs.org; Fri, 20 Feb 2015 16:52:18 +0000
Date: Fri, 20 Feb 2015 08:52:12 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>
Subject: Re: [RFC PATCH 0/3] hwmon: (ibmpowernv) add DTS support
Message-ID: <20150220165212.GE22752@roeck-us.net>
References: <1423117857-32759-1-git-send-email-clg@fr.ibm.com>
 <1424444857-13805-1-git-send-email-clg@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1424444857-13805-1-git-send-email-clg@fr.ibm.com>
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

On Fri, Feb 20, 2015 at 04:07:34PM +0100, Cédric Le Goater wrote:
> Hello !
> 
> These patches rework the ibmpowernv driver to support the new device 
> tree as proposed by this patchset on the skiboot mailing list :
> 
>   https://lists.ozlabs.org/pipermail/skiboot/2015-February/000457.html
> 
> They are based on Linux 3.19 and were tested on IBM Power and Open Power 
> systems running trusty.
> 
> The main issue is that the new device tree is incompatible with the 
> previous ibmpowernv drivers. The consequence is no powernv sensors 
> on systems with such a opal/linux configuration.
> 
I don't think that would be acceptable. There must be lots of such
systems out there. Why does it have to be incompatible ?
Can't it support both the old and new versions ?

Guenter
