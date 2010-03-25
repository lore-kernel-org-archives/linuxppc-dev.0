Return-Path: <wmb@firmworks.com>
Received: from rs35.luxsci.com (rs35.luxsci.com [66.216.127.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B4FA9B7CB9
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 02:29:45 +1100 (EST)
Message-ID: <4BAB816F.5060405@firmworks.com>
Date: Thu, 25 Mar 2010 05:29:51 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/fsl: add device tree binding for QE firmware
References: <1269380552-10418-1-git-send-email-timur@freescale.com>	<fa686aa41003232307s39af071bn6377800951d6615c@mail.gmail.com>	<ed82fe3e1003240505h59d29c83x6948f8b3b70c4570@mail.gmail.com>	<90D93687-940F-47FB-8CEA-F3C065EA611D@kernel.crashing.org>	<fa686aa41003241007mf6052d5s4643795f4a87cdcf@mail.gmail.com>	<4BAA4C8A.70104@freescale.com>	<65327.84.105.60.153.1269481760.squirrel@gate.crashing.org>
	<4BAB7E67.6040707@freescale.com>
In-Reply-To: <4BAB7E67.6040707@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It seems to me that there are plausible use cases for both 
direct-inclusion and indirection.  I don't see any real problems with 
either, so I would vote for specifying both alternatives.
