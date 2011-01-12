Return-Path: <jwboyer@linux.vnet.ibm.com>
Date: Wed, 12 Jan 2011 10:58:50 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH] Globally s/struct irq_host/struct irq_domain/
Message-ID: <20110112155849.GA32425@zod.rchland.ibm.com>
References: <E1Pd18R-0002d3-US@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1Pd18R-0002d3-US@jdl.com>
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 12, 2011 at 07:53:11AM -0600, Jon Loeliger wrote:
>From: Jon Loeliger <jdl@jdl.com>
>
>Just rename the irq_host structure as irq_domain to lessen the
>confusion around the word "host".  Updated a few comments and
>error messages to use "irq_domain" when refering to the structure.
>
>Suggested by Ben Herrenschmidt on the device-tree mailing list.
>
>Signed-off-by: Jon Loeliger <jdl@jdl.com>

For the uic.c part:

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

josh
