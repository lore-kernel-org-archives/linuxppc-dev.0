Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id BE581DDE0A
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 11:13:50 +1000 (EST)
Date: Mon, 7 May 2007 20:15:50 -0500
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 2/7] Generalize tsi108 PHY types
Message-ID: <20070508011550.GB12613@lixom.net>
References: <1178572962.2990.197.camel@zod.rchland.ibm.com>
	<1178573182.2990.201.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1178573182.2990.201.camel@zod.rchland.ibm.com>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 07, 2007 at 04:26:22PM -0500, Josh Boyer wrote:
> Add a phy_type field to the tsi108 ethernet structures to indicate which PHY
> is used on a board.  This is derived from the "compatible" property in the
> ethernet-phy node of the device tree.  The default remains the MV88E PHY.
> 
> Also, convert the setup code to use of_get_mac_address instead of hard coding
> a lookup for the "address" property in the ethernet node.
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Acked-by: Olof Johansson <olof@lixom.net>
