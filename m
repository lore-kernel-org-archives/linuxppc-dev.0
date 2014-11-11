Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2ECE91A0063
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 05:38:13 +1100 (AEDT)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1XoGKR-001ECM-BM
 for linuxppc-dev@lists.ozlabs.org; Tue, 11 Nov 2014 18:38:11 +0000
Date: Tue, 11 Nov 2014 10:37:52 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] hwmon: (ibmpowernv) Use platform 'id_table' to probe
 the device
Message-ID: <20141111183752.GA23539@roeck-us.net>
References: <20141105110848.6183.55611.stgit@localhost.localdomain>
 <20141105142149.GA23212@roeck-us.net>
 <1415574297.29291.3.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1415574297.29291.3.camel@concordia>
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

On Mon, Nov 10, 2014 at 10:04:57AM +1100, Michael Ellerman wrote:
> On Wed, 2014-11-05 at 06:21 -0800, Guenter Roeck wrote:
> > On Wed, Nov 05, 2014 at 04:45:14PM +0530, Neelesh Gupta wrote:
> > > The current driver probe() function assumes the sensor device to be
> > > alwary present and gets executed every time if the driver is loaded,
> > > but the appropriate hardware could not be present.
> > > 
> > > So, move the platform device creation as part of platform init code
> > > and use the 'id_table' to check if the device present or not.
> > > 
> > > Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
> > 
> > Looks good. We'll need an ack from one of the powerpc maintainers to proceed.
> 
> Looks OK to me.
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> 
Applied to -next.

Thanks,
Guenter
