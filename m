In-Reply-To: <1088516489.20324.12.camel@localhost>
References: <1088516489.20324.12.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <F5009B2E-C9DF-11D8-A76E-000393DBC2E8@freescale.com>
Cc: Adrian Cox <adrian@humboldt.co.uk>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH] OCP for MP10x
Date: Tue, 29 Jun 2004 10:21:13 -0500
To: Tom Rini <trini@kernel.crashing.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom,

This patch looks good to me.

- kumar

On Jun 29, 2004, at 8:41 AM, Adrian Cox wrote:

> Attached is the latest version of my OCP patch for MPC107/8240/8245.
> This unifies some openpic setup code, and ensures that the OCP devices
> are only added to the bus on chip variants which have them.
> All interested parties seem happy, and this patch is necessary to
> provide a unified I2C driver for 85xx and 107/824x.
> Signed-off-by: Adrian Cox <adrian@humboldt.co.uk>
> - Adrian Cox
> Humboldt Solutions Ltd.
>
> <ocp3.patch>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
