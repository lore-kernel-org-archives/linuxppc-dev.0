Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A8243B6F7B
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Sep 2011 08:34:42 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: Re: [PATCH 1/4] powerpc/85xx: Rename PowerPC core nodes to match
	other e500mc based .dts
Date: Thu, 1 Sep 2011 22:34:38 +0000
Message-ID: <CAOZdJXUX1xLkpSGEbm-PqMR_-D_v1_9hXJtVDQ3V84Ljey-+OQ@mail.gmail.com>
References: <1314905175-4371-1-git-send-email-galak@kernel.crashing.org>
	<4E5FEE40.7080901@freescale.com>
In-Reply-To: <4E5FEE40.7080901@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 1, 2011 at 3:42 PM, Scott Wood <scottwood@freescale.com> wrote:
> On 09/01/2011 02:26 PM, Kumar Gala wrote:
>> The P4080 silicon device tree was using PowerPC,4080 while the other
>> e500mc based SoCs used PowerPC,e500mc. =A0Use the core name to be
>> consistent going forward.
>
> Why are we not using the generic names recommendation?
>
> Is the "PowerPC" vendor string still appropriate here, or should we use
> "fsl"?

And what about a compatible property?

--=20
Timur Tabi
Linux kernel developer at Freescale=
