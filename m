Return-Path: <michael.neuling@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2DF2F1A1A34
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 11:32:52 +1000 (AEST)
Message-ID: <1437528771.13836.38.camel@au1.ibm.com>
Subject: Re: [PATCH] Fix crash due to processing "memory-controller" nodes
 as "memory"
From: Michael Neuling <michael.neuling@au1.ibm.com>
To: jeremy@ozlabs.au.ibm.com
Cc: Anton Blanchard <anton@samba.org>, Michael Ellerman
 <mpe@ellerman.id.au>,  ian@ozlabs.au.ibm.com, benh@ozlabs.au.ibm.com,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, "sonal.santan"
 <sonal.santan@xilinx.com>,  sam@ozlabs.au.ibm.com
Date: Wed, 22 Jul 2015 11:32:51 +1000
In-Reply-To: <55AEE639.6060002@au.ibm.com>
References: <1437380450-25555-1-git-send-email-imunsie@au.ibm.com>
 <20150721124554.332dd228@kryten>	<1437447984.30722.3.camel@ellerman.id.au>
 <20150722091844.114ea023@kryten> <55AEE639.6060002@au.ibm.com>
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

On Wed, 2015-07-22 at 08:39 +0800, jeremy@ozlabs.au.ibm.com wrote:
> Hi Anton,
>=20
> > [PATCH] Fix crash due to processing "memory-controller" nodes as "memor=
y"
>=20
> Looks good to me. If you apply this to your kexec-lite repo, I'll update
> op-build to use the new version, and send the merge requests for op-build=
.
>=20
> I'd expect we'd have those changes upstream in the next couple of days.
> Xilinx folks: how are you consuming op-build? Do you need a new PNOR
> image, or are you constructing those yourself?

jk, Sonal (from Xilinx) is on a Tulleta not an openpower box.  So we
need to go through the IBM process to get the firmware updated rather
than op-build.

Mikey
