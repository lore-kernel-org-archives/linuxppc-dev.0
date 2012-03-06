Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6FC94B6F9D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 23:14:38 +1100 (EST)
Subject: Re: [PATCH 1/9] pci_ids: Add device ID for IBM PCI-X bridge
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1331024707-15891-1-git-send-email-chenhui.zhao@freescale.com>
Date: Tue, 6 Mar 2012 06:14:25 -0600
Message-Id: <08B5FFBF-FFF7-45FF-A98D-181CC0E6CEBC@kernel.crashing.org>
References: <1331024707-15891-1-git-send-email-chenhui.zhao@freescale.com>
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 6, 2012, at 3:05 AM, Zhao Chenhui wrote:

> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> ---
> include/linux/pci_ids.h |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)

Just merge this with the 2nd patch that actually uses the ID.

- k
