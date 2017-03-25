Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vqmBC4Y4TzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Mar 2017 14:34:43 +1100 (AEDT)
Message-ID: <1490412884.28113.71.camel@neuling.org>
Subject: Re: [PATCH v3 05/10] VAS: Define helpers to init window context
From: Michael Neuling <mikey@neuling.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, stewart@linux.vnet.ibm.com,
 linuxppc-dev@ozlabs.org, apopple@au1.ibm.com, oohall@gmail.com
Date: Sat, 25 Mar 2017 14:34:44 +1100
In-Reply-To: <20170324214757.GE8330@us.ibm.com>
References: <1489721642-5657-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1489721642-5657-6-git-send-email-sukadev@linux.vnet.ibm.com>
 <1490332539.28113.63.camel@neuling.org> <20170324214757.GE8330@us.ibm.com>
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


> > > +	val =3D 0ULL;
> > > +	if (user_win) {
> > > +		val =3D SET_FIELD(VAS_XLATE_MSR_DR, val, true);
> > > +		val =3D SET_FIELD(VAS_XLATE_MSR_TA, val, false);
> > > +		val =3D SET_FIELD(VAS_XLATE_MSR_PR, val, true);
> > > +		val =3D SET_FIELD(VAS_XLATE_MSR_US, val, false);
> > > +		val =3D SET_FIELD(VAS_XLATE_MSR_HV, val, true);
> > > +		val =3D SET_FIELD(VAS_XLATE_MSR_SF, val, true);
> > > +		val =3D SET_FIELD(VAS_XLATE_MSR_UV, val, false);
> > > +	} else {
> > > +		val =3D SET_FIELD(VAS_XLATE_MSR_DR, val, false);
> >=20
> > kernel contexts don't go through the nestmmu?
>=20
> I think so, but will check with Alistair/Ben.

Well it's kinda up to you.  Do you want to use the kernel mapping or not?  =
I
probably would unless there are issues.

Mikey
