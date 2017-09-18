Return-Path: <dcb314@hotmail.com>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-oln040092067073.outbound.protection.outlook.com [40.92.67.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xwycf3nMnzDqXj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 06:42:42 +1000 (AEST)
From: David Binderman <dcb314@hotmail.com>
To: "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "paulus@samba.org"
 <paulus@samba.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: linux-4.14-rc1/arch/powerpc/perf/hv-24x7.c:541: bad condition ?
Date: Mon, 18 Sep 2017 20:42:29 +0000
Message-ID: <HE1PR0802MB2331572C98E215722EE4411C9C630@HE1PR0802MB2331.eurprd08.prod.outlook.com>
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

linux-4.14-rc1/arch/powerpc/perf/hv-24x7.c:543]: (warning) Identical condit=
ion 's1<s2', second condition is always false

Source code is

    if (s1 < s2)
        return 1;
    if (s2 > s1)
        return -1;

Suggest code rework.

Regards

David Binderman=
