Return-Path: <srs0=qtsl=6p=suse.de=msuchanek@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6xtL1N0jzDqjY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 21:43:54 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3x6xtL0qZbz8sxs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 21:43:54 +1000 (AEST)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3x6xtK4Ndkz9s4s
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Jul 2017 21:43:53 +1000 (AEST)
Date: Wed, 12 Jul 2017 13:31:02 +0200
From: msuchanek <msuchanek@suse.de>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, linuxppc-dev
 <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH v5 2/2] powerpc/fadump: update documentation about
 'fadump_append=' parameter
Message-ID: <20170712133102.2145e393@naga>
In-Reply-To: <dc6ce480-52e0-1cf9-a2ce-252fdf24f79a@linux.vnet.ibm.com>
References: <149383572199.1694.10940679065871920087.stgit@hbathini.in.ibm.com>
 <149383576571.1694.13692135068122879322.stgit@hbathini.in.ibm.com>
 <20170510180132.1fa0c1ec@kitsune.suse.cz>
 <e1485f4d-f346-fea6-ee2a-9c7a6b2f6587@linux.vnet.ibm.com>
 <20170511151637.19d4a23f@kitsune.suse.cz>
 <b1c1c890-fac0-dede-4b80-0fc12f1e95e7@linux.vnet.ibm.com>
 <20170512174209.67ccfd45@kitsune.suse.cz>
 <b6a968fe-378e-1273-a996-43c716f276bd@linux.vnet.ibm.com>
 <20170515112901.67d32e76@kitsune.suse.cz>
 <102276aa-cddb-dc60-269c-b29dedc89eab@linux.vnet.ibm.com>
 <20170609140454.2eb01371@kitsune.suse.cz>
 <a3ac4a10-3315-187b-e29a-01637ba19dff@linux.vnet.ibm.com>
 <20170626141501.6086b6ab@kitsune.suse.cz>
 <dc6ce480-52e0-1cf9-a2ce-252fdf24f79a@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Wed, 12 Jul 2017 00:00:57 +0530
Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:

> Hi Michal,
>=20
>=20
> Thanks for the review..
>=20
>=20
> On Monday 26 June 2017 05:45 PM, Michal Such=C3=A1nek wrote:
> > Hello,
> >
> > On Tue, 20 Jun 2017 21:14:08 +0530
> > Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:
> > =20

> I would prefer documenting over a complex implementation. Actually, I
> am considering a simple approach of replacing every occurrence of
> "fadump_extra_args=3D" with "fadump_extra_args " in fadump capture
> kernel. The cmdline
>=20
>    "root=3D/dev/sda2 ro fadump_extra_args=3D"a b c" crashkernel=3D512M=20
> fadump_extra_args=3Dd"
>=20
> becomes
>=20
>    "root=3D/dev/sda2 ro fadump_extra_args "a b c" crashkernel=3D512M=20
> fadump_extra_args d"

which is totally broken

>=20
> in fadump capture kernel. This must take care of the pitfalls with
> the current approach and also,
> doesn't rely on parse_args() which was not designed for this scenario
> to start with..?

It was designed for parsing arguments. To handle replacing arguments
you have to extend it. You need to get more information from it for
this case.

Best regards

Michal
