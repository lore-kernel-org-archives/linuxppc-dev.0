Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D9702B70A6
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Aug 2010 04:14:17 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 0/9] RapidIO: Set of patches to add Gen2 switches
Date: Tue, 17 Aug 2010 11:13:57 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552011D6336@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <4C6A3AD0.5090005@neli.hopto.org>
References: <1281712686-31308-1-git-send-email-alexandre.bounine@idt.com>
	<4C692F7E.1060208@neli.hopto.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E552011D6061@CORPEXCH1.na.ads.idt.com>
	<4C6A3AD0.5090005@neli.hopto.org>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Micha Nelissen" <micha@neli.hopto.org>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, "Bounine,
	Alexandre" <Alexandre.Bounine@idt.com>, linux-kernel@vger.kernel.org,
	Thomas Moll <thomas.moll@sysgo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Micha Nelissen wrote:
=20
> Can you explain what the difference what you mean with relied on
> proprietary vs standard? E.g. setting the port-write destination ID
> register is standardized? And the format of the port-write message
> itself is also.

The original description should use "error-stopped state recovery" term
instead of simple "error recovery".
And standard based handling of error-stopped states was added. I
mentioned tsi57x in that context because it uses proprietary mechanism
to generate "magic" control symbol to clear error-stopped states. Other
switches do not have similar function and have to rely on standard
implementation.
 =20
