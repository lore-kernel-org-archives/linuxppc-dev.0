Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 88341DDDA5
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Mar 2009 07:52:36 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so907265yxg.39
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Mar 2009 13:52:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ac3eb2510903281210w689a48dcsa04d67392de06801@mail.gmail.com>
References: <ac3eb2510903281210w689a48dcsa04d67392de06801@mail.gmail.com>
Date: Sat, 28 Mar 2009 14:52:33 -0600
Message-ID: <fa686aa40903281352j239b5e6ct33cd0cf1d23c0579@mail.gmail.com>
Subject: Re: BUS_ID_SIZE is going away
From: Grant Likely <grant.likely@secretlab.ca>
To: Kay Sievers <kay.sievers@vrfy.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Greg Kroah-Hartmann <greg@kroah.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Mar 28, 2009 at 1:10 PM, Kay Sievers <kay.sievers@vrfy.org> wrote:
> Hey,
> care to replace:
> =A0bus_id[BUS_ID_SIZE];
> in:
> =A0include/linux/fsl_devices.h
> with a locally defined limit, or whatever fits your needs? Or let me
> know how you like it to be converted, and I can make a patch, and we
> can push it through the driver-core tree.

gianfar_platform_data and several other symbols in that file are
actually obsolete and unused.  They can be removed entirely from
include/linux/fsl_devices.h.  I'll prepare a patch.

g.


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
