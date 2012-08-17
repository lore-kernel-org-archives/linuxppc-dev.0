Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D55222C0188
 for <linuxppc-dev@ozlabs.org>; Sat, 18 Aug 2012 00:07:35 +1000 (EST)
Subject: Re: [v2 PATCH 1/1] booke/wdt: some ioctls do not return values
 properly
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1344304780-13555-1-git-send-email-tiejun.chen@windriver.com>
Date: Fri, 17 Aug 2012 09:07:38 -0500
Message-Id: <4EB00FE4-6A50-47DB-8BAB-3437489DC489@kernel.crashing.org>
References: <1344304780-13555-1-git-send-email-tiejun.chen@windriver.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
Cc: linuxppc-dev@ozlabs.org, B04825@freescale.com,
 linux-watchdog@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 6, 2012, at 8:59 PM, Tiejun Chen wrote:

> Fix some booke wdt ioctls return value error.
> 
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---
> drivers/watchdog/booke_wdt.c |    7 +++----
> 1 files changed, 3 insertions(+), 4 deletions(-)

applied to merge

- k
