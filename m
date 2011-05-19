Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE002.bigfish.com (va3ehsobe002.messaging.microsoft.com
	[216.32.180.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 04EC3B6F88
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 00:27:05 +1000 (EST)
Message-ID: <4DD52195.7060104@freescale.com>
Date: Thu, 19 May 2011 08:56:37 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: <kumar.gala@freescale.com>, <benh@kernel.crashing.org>, <greg@kroah.com>,
	<akpm@kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-console@vger.kernel.org>
Subject: Re: [PATCH 0/7] This patchset adds support for running Linux under
	the Freescale hypervisor,
References: <1305813272-31826-1-git-send-email-timur@freescale.com>
In-Reply-To: <1305813272-31826-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> have hypervisor extensions (e.g. the P4080 which has an e500mc core).

Oops, this email got munged.  The first paragraph should say:

This patchset adds support for running Linux under the Freescale hypervisor,
which is an ePAPR-compliant hypervisor that runs on our PowerPC SOCs that
have hypervisor extensions (e.g. the P4080 which has an e500mc core).

-- 
Timur Tabi
Linux kernel developer at Freescale
