Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2156EDDF9F
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 09:40:52 +1000 (EST)
Subject: Re: [PATCH] ibm_newemac: Add MII mode support to the EMAC RGMII
	bridge.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <1215473518-14245-1-git-send-email-gerickson@nuovations.com>
References: <1215473518-14245-1-git-send-email-gerickson@nuovations.com>
Content-Type: text/plain
Date: Tue, 08 Jul 2008 09:40:42 +1000
Message-Id: <1215474042.8970.171.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sr@denx.de, jgarzik@pobox.com
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-07-07 at 16:31 -0700, Grant Erickson wrote:
>  #define RGMII_FER_GMII(idx)    (0x7 << ((idx) * 4))
> +#define RGMII_FER_MII(idx)     (0x7 << ((idx) * 4))

Hrm... the setting of the register is exactly the same right ?

Do we -really- need that ?

Ben.
