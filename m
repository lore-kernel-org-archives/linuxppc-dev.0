Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3D7742BDA2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Oct 2004 05:34:27 +1000 (EST)
Date: Wed, 13 Oct 2004 12:34:23 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Message-ID: <20041013193423.GA28349@gate.ebshome.net>
References: <Pine.LNX.4.60.0410131423540.12426@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0410131423540.12426@localhost.localdomain>
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: "I2C" versus "IIC"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Oct 13, 2004 at 02:26:23PM -0400, Robert P. J. Day wrote:
> 
>   i was just about to rename some of my variables and macros to be
> consistent with what i *thought* was the standard nomenclature of
> "IIC" as opposed to "I2C".  just checked include/asm-ppc, and grepped
> for case-insensitive instances of both strings ... oh, god.  there's
> really no preferred usage, is there?

Philips' documentation uses I2C, not IIC, so I guess this is 
_official_ name of the _bus_.

Some vendors (like IBM in their 4xx parts) use IIC to name I2C 
_interface_ to distinguish it from I2C _bus_ (they specifically 
mention this in the chip manual).

For example, in the corresponding 4xx driver I used "iic" because it 
was written for IBM IIC _interface_.

--
Eugene.
