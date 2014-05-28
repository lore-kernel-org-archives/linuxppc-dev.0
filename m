Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1602F1A024F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 17:41:29 +1000 (EST)
Message-ID: <1401262871.8262.22.camel@pasglop>
Subject: Re: [PATCH v2] powerpc/powernv: hwmon driver for power values, fan
 rpm and temperature
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 28 May 2014 17:41:11 +1000
In-Reply-To: <53858F02.2020808@roeck-us.net>
References: <20140519141931.9248.11356.stgit@neelegup-tp-t420.in.ibm.com>
 <53858F02.2020808@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: lm-sensors@lm-sensors.org, sbhat@linux.vnet.ibm.com,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 jdelvare@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-05-28 at 00:23 -0700, Guenter Roeck wrote:
> Consider using of_property_read_u32().
> 
> > +             sdata[count].id = *sensor_id;
> > +             sdata[count].type = type;

Especially since this is broken for Little Endian !

Neelesh, please make sure you test your patch on LE.

Cheers,
Ben.
