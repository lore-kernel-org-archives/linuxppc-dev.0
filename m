Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id E4E70DDE25
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 12:03:55 +1000 (EST)
Date: Tue, 17 Jun 2008 18:57:12 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] ibm_emac: Remove the ibm_emac driver
Message-ID: <20080618015712.GC30602@gate.ebshome.net>
References: <20080617193523.028d4cc2@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080617193523.028d4cc2@zod.rchland.ibm.com>
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 17, 2008 at 07:35:23PM -0400, Josh Boyer wrote:
> The arch/ppc sub-tree has been removed in the powerpc git tree.  The old
> ibm_emac driver is no longer used by anything as a result of this.  This
> removes it, leaving the ibm_newemac driver as the proper driver to use for
> PowerPC boards with the EMAC hardware.
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Acked-by: Eugene Surovegin <ebs@ebshome.net>
