Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B9BB32C062E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 22:24:35 +1000 (EST)
Subject: Re: [PATCH] P1021: set IReady in QE Microcode Upload 
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <026483A88B848047A08C3F03E20822D0267B1F4A55@MCHP058A.global-ad.net>
Date: Tue, 10 Jul 2012 07:24:30 -0500
Message-Id: <22C2B39B-2B20-42F6-A5F6-17E437CC14ED@kernel.crashing.org>
References: <026483A88B848047A08C3F03E20822D0267B1F4A55@MCHP058A.global-ad.net>
To: "Kokoris, Ioannis" <ioannis.kokoris@siemens-enterprise.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "timur@freescale.com" <timur@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 11, 2011, at 10:05 AM, Kokoris, Ioannis wrote:

> Hi,
>=20
> QE Microcode Initialization using qe_upload_microcode() does not work =
on P1021 if the IRAM-Ready register is not set after the microcode =
upload. This patch adds a definition for the "I-RAM Ready" register and =
sets it uppon microcode upload completion.
>=20
>=20
> Signed-off-by: Ioannis Kokkoris =
<ioannis.kokoris@siemens-enterprise.com>
>=20

applied to next

- k=
