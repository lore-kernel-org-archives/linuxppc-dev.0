Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 9CDBFDE145
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 10:11:31 +1000 (EST)
Date: Tue, 17 Jun 2008 20:11:27 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] ibm_emac: Remove the ibm_emac driver
Message-ID: <20080617201127.6388ff78@lappy.seanm.ca>
In-Reply-To: <20080617193523.028d4cc2@zod.rchland.ibm.com>
References: <20080617193523.028d4cc2@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 17 Jun 2008 19:35:23 -0400
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> The arch/ppc sub-tree has been removed in the powerpc git tree.  The
> old ibm_emac driver is no longer used by anything as a result of
> this.  This removes it, leaving the ibm_newemac driver as the proper
> driver to use for PowerPC boards with the EMAC hardware.

Would it make any sense to rename the ibm_newemac driver ibm_emac?

Cheers,
   Sean
