Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6A68C2BDA5
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Oct 2004 03:49:28 +1000 (EST)
Date: Thu, 21 Oct 2004 10:49:23 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: linuxppc <linuxppc@4bridgeworks.com>
Message-ID: <20041021174923.GB6234@gate.ebshome.net>
References: <C18BA5DDB58DD511BD0700C0DF0DD4502941E6@NTSERVER4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C18BA5DDB58DD511BD0700C0DF0DD4502941E6@NTSERVER4>
Cc: Linux PPC Dev <linuxppc-dev@ozlabs.org>
Subject: Re: Problem with PPC 440 GX Transmit Path
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 21, 2004 at 03:20:55PM +0100, linuxppc wrote:
> I have found a problem with the driver for the PPC440GX (ibm_emac), while
> reading from the PPC (OCOTEA) BOX doesn't always transmit the last packet, I
> have managed to get it to continue by pinging it or from it, or if the root
> filesystem is mounted as nfs (I am assuming communications using nfs use a
> keepalive test or equivalent). I have also found that by turning on the
> debug options in ibm_emac_core.c (PKT_DEBUG) fixes the problem!! I have
> removed all but one of the debug messages and as long as they are in the tx
> functions (not the rx functions) I have no problems. Any help or guidance
> will be appreciated, for now I am going to try and implement gdb.....

Which kernel version you are using?

--
Eugene
