Return-Path: <ioannis.kokoris@siemens-enterprise.com>
Received: from senmx12-mx.siemens-enterprise.com
 (senmx12-mx.siemens-enterprise.com [62.134.46.10])
 by ozlabs.org (Postfix) with ESMTP id C1539B71DE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2011 19:55:09 +1100 (EST)
From: "Kokoris, Ioannis" <ioannis.kokoris@siemens-enterprise.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Date: Mon, 14 Nov 2011 09:55:04 +0100
Subject: RE: [PATCH] P1021: set IReady in QE Microcode Upload
Message-ID: <026483A88B848047A08C3F03E20822D0267B1F4BDB@MCHP058A.global-ad.net>
References: <026483A88B848047A08C3F03E20822D0267B1F4A55@MCHP058A.global-ad.net>
 <4EBD4FB8.2020406@freescale.com>
In-Reply-To: <4EBD4FB8.2020406@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>Kokoris, Ioannis wrote:
>> Hi,
>>
>> QE Microcode Initialization using qe_upload_microcode() does not work
>> on P1021 if the IRAM-Ready register is not set after the microcode
>> upload. This patch adds a definition for the "I-RAM Ready" register and
>> sets it uppon microcode upload completion.
>
>Will this code still work on other QE parts, like the MPC8323?
>

Ready register is needed for ROM-less devices such as P1021, MPC859, MPC830=
6 etc.=20
For ROM-based devices such as MCP8323 the Ready register does not exist.
Is there a global definition for conditionally including this code?

Regards,
Ioannis
