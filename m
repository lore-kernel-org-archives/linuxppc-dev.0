Return-Path: <dcb314@hotmail.com>
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-oln040092070064.outbound.protection.outlook.com [40.92.70.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7zN717hLzDqlT
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Oct 2017 05:55:02 +1100 (AEDT)
From: David Binderman <dcb314@hotmail.com>
To: "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "paulus@samba.org"
 <paulus@samba.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: linux-4.14-rc3/arch/powerpc/perf/imc-pmu.c:599: pointless test ?
Date: Fri, 6 Oct 2017 18:54:56 +0000
Message-ID: <HE1PR0802MB23316FCA14FD1F8E51FCAB059C710@HE1PR0802MB2331.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello there,

linux-4.14-rc3/arch/powerpc/perf/imc-pmu.c:599]: (style) Unsigned variable =
'ncpu' can't be negative so it is unnecessary to test it.

Source code is

    if (ncpu >=3D 0 && ncpu < nr_cpu_ids) {

but

    unsigned int ncpu, core_id;

Suggest remove test.

Regards

David Binderman=
