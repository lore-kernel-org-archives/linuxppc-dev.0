Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B59E1A00B5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Nov 2014 10:04:58 +1100 (AEDT)
Message-ID: <1415574297.29291.3.camel@concordia>
Subject: Re: [PATCH v2] hwmon: (ibmpowernv) Use platform 'id_table' to probe
 the device
From: Michael Ellerman <mpe@ellerman.id.au>
To: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 10 Nov 2014 10:04:57 +1100
In-Reply-To: <20141105142149.GA23212@roeck-us.net>
References: <20141105110848.6183.55611.stgit@localhost.localdomain>
 <20141105142149.GA23212@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: benh@au1.ibm.com, michaele@au1.ibm.com, linux-kernel@vger.kernel.org,
 lm-sensors@lm-sensors.org, Neelesh Gupta <neelegup@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, jdelvare@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-11-05 at 06:21 -0800, Guenter Roeck wrote:
> On Wed, Nov 05, 2014 at 04:45:14PM +0530, Neelesh Gupta wrote:
> > The current driver probe() function assumes the sensor device to be
> > alwary present and gets executed every time if the driver is loaded,
> > but the appropriate hardware could not be present.
> > 
> > So, move the platform device creation as part of platform init code
> > and use the 'id_table' to check if the device present or not.
> > 
> > Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
> 
> Looks good. We'll need an ack from one of the powerpc maintainers to proceed.

Looks OK to me.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
