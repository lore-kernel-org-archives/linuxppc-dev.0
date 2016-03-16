Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQ50Z4SzBzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 19:55:10 +1100 (AEDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 3qQ50Z3WzDz9s9G
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 19:55:10 +1100 (AEDT)
Message-ID: <1458118510.6606.7.camel@neuling.org>
Subject: Re: [PATCH] cxl: Configure the PSL for dual port CAPI on Naples
From: Michael Neuling <mikey@neuling.org>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, imunsie@au1.ibm.com
Date: Wed, 16 Mar 2016 19:55:10 +1100
In-Reply-To: <56E91E2D.60004@linux.vnet.ibm.com>
References: <1458052008-29254-1-git-send-email-felix@linux.vnet.ibm.com>
 <1458090911.9668.15.camel@neuling.org> <56E91E2D.60004@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > > +		psl_dsnctl |=3D (phb_index << (63-11));
> >=20
> >=20
> > Looking at the psl docs, cappunitid in the dsndctl is bits 6 to 13.
> >   So
> > why 11 here?
> >=20
> Because on POWER8NVL, dsndctl bit 11 =3D=3D phb_index =3D=3D cappunitid.
> Bits 6-10 and 12-13 do not change between POWER8 and POWER8NVL.

OK, can you document that better as what you're doing now is not clear
even when reading the associated docs.

Mikey
