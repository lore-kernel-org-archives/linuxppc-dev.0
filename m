Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 9EF60DDF4D
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 03:34:45 +1000 (EST)
Message-ID: <46362960.2040406@mvista.com>
Date: Mon, 30 Apr 2007 10:37:36 -0700
From: Dave Jiang <djiang@mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add EDAC platform devices for 85xx
References: <20070425213700.GA8814@blade.az.mvista.com>
	<20070426000852.GA2193@localhost.localdomain>
	<20070426003748.GA30730@blade.az.mvista.com>
	<9903F55A-5E4E-42CE-8C27-6B7143B9FE25@kernel.crashing.org>
In-Reply-To: <9903F55A-5E4E-42CE-8C27-6B7143B9FE25@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net,
	david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On Apr 25, 2007, at 7:37 PM, Dave Jiang wrote:
>> +
>> +/* platform device setup for EDAC */
> 
> Why not have the EDAC code for 85xx use of_device?
-- 

Kumar,
After doing some testing and looking around, it seems that for the 85xx only
the mds code calls the mpc85xx_publish_devices() which pulls in the soc devices
from the dts and creates them as of_devices. I do not see similar code for cds
and ads. Should that be added for ads and cds?

------------------------------------------------------
Dave Jiang
Software Engineer
MontaVista Software, Inc.
http://www.mvista.com
------------------------------------------------------
