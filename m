Return-Path: <msalter@redhat.com>
Subject: Re: [PATCH v5 21/27] irq_domain/c6x: Use library of xlate functions
From: Mark Salter <msalter@redhat.com>
To: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 21 Feb 2012 10:48:33 -0500
In-Reply-To: <1329383368-12122-22-git-send-email-grant.likely@secretlab.ca>
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
 <1329383368-12122-22-git-send-email-grant.likely@secretlab.ca>
Content-Type: text/plain; charset="us-ascii"
Message-ID: <1329839315.17322.5.camel@deneb.redhat.com>
Mime-Version: 1.0
Cc: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Milton Miller <miltonm@bga.com>, Rob Herring <rob.herring@calxeda.com>,
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

On Thu, 2012-02-16 at 02:09 -0700, Grant Likely wrote:
> The c6x irq controllers don't need to define custom .xlate hooks
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/c6x/kernel/irq.c            |    1 +
>  arch/c6x/platforms/megamod-pic.c |   14 +-------------
>  2 files changed, 2 insertions(+), 13 deletions(-)

Acked-by: Mark Salter <msalter@redhat.com>
