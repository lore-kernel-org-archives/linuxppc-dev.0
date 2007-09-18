Return-Path: <dgibson@ozlabs.org>
Date: Tue, 18 Sep 2007 16:13:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 02/28] Introduce new CPM device bindings.
Message-ID: <20070918061305.GF30766@localhost.localdomain>
References: <20070917165643.GA6545@loki.buserror.net>
	<20070917165730.GB6563@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070917165730.GB6563@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 17, 2007 at 11:57:30AM -0500, Scott Wood wrote:
> This introduces a new device binding for the CPM and other devices on
> these boards.  Some of the changes include:
> 
> 1. Proper namespace scoping for Freescale compatibles and properties.
> 
> 2. Use compatible rather than things like device_type and model
> to determine which particular variant of a device is present.
> 
> 3. Give the drivers the relevant CPM command word directly, rather than
> requiring it to have a lookup table based on device-id, SCC v. SMC, and
> CPM version.
> 
> 4. Specify the CPCR and the usable DPRAM region in the CPM's reg property.
> 
> Boards that do not require the legacy bindings should select
> CONFIG_PPC_CPM_NEW_BINDING to enable the of_platform CPM devices. Once
> all existing boards are converted and tested, the config option can
> become default y to prevent new boards from using the old model.  Once
> arch/ppc is gone, the config option can be removed altogether.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
