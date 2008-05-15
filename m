Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from WA4EHSOBE001.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id D1F9ADE085
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 06:37:26 +1000 (EST)
Message-ID: <482C9815.3030007@am.sony.com>
Date: Thu, 15 May 2008 13:07:49 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [RFC] [PATCH] vmemmap fixes to use smaller pages
References: <1209534108.18023.221.camel@pasglop>
In-Reply-To: <1209534108.18023.221.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> This patch changes vmemmap to use a different region (region 0xf) of the
> address space whose page size can be dynamically configured at boot.

This doesn't seem to cause any problems, and users successfully used it
with the ubuntu hardy kernel, so I think it is OK to proceed with it.

  https://bugs.launchpad.net/ubuntu-ps3-port/+bug/220524

-Geoff
