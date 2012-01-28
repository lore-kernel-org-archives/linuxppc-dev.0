Return-Path: <rdunlap@xenotime.net>
Received: from oproxy1-pub.bluehost.com (oproxy1.bluehost.com
 [IPv6:2605:dc00:100:2::a1])
 by ozlabs.org (Postfix) with SMTP id DDFBC1007D1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jan 2012 04:25:40 +1100 (EST)
Message-ID: <4F243D2C.7040709@xenotime.net>
Date: Sat, 28 Jan 2012 10:23:40 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 01/25] irq_domain: add documentation and MAINTAINERS
 entry.
References: <1327700179-17454-1-git-send-email-grant.likely@secretlab.ca>
 <1327700179-17454-2-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <1327700179-17454-2-git-send-email-grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>, Milton Miller <miltonm@bga.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/27/2012 01:35 PM, Grant Likely wrote:
> Documentation for irq_domain library which will be created in subsequent
> patches.

I posted a lot of comments to v2 on Jan. 24.
Looks like they were ignored.

Please see  http://marc.info/?l=linuxppc-embedded&m=132742951211808&w=2


> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Milton Miller <miltonm@bga.com>
> ---
>  Documentation/IRQ-domain.txt |  113 ++++++++++++++++++++++++++++++++++++++++++
>  MAINTAINERS                  |    9 +++
>  2 files changed, 122 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/IRQ-domain.txt


-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
