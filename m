Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 92735DDE1E
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 00:26:46 +1000 (EST)
In-Reply-To: <20070717023957.GL3925@crusty.rchland.ibm.com>
References: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
	<1184162389.32199.65.camel@weaponx.rchland.ibm.com>
	<4EAC985A-2F04-465D-AB69-C67807310D7B@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA3030669AF@az33exm25.fsl.freescale.net>
	<28A3F6B9-512B-4D86-8E0D-A7680CCE2354@kernel.crashing.org>
	<1184622446.25235.89.camel@localhost.localdomain>
	<20070717023957.GL3925@crusty.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7CC79D53-5C52-453D-B43D-5B9E074DDB45@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC][PATCH 6/8] Walnut DTS
Date: Tue, 17 Jul 2007 16:26:00 +0200
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: Yoder Stuart-B08248 <stuart.yoder@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Right.  See, there are people like me that don't know what the  
> default values
> are/should be.  Having them explicitly listed, even if it's  
> redundant, serves
> as a good learning aid.

_Only_ if it's redundant.  Not if it has a meaning different
from having the property not there at all.

> Now, realistically I do know what the default is in this case.  But  
> I only
> learned that recently.  With hopefully more people starting to port  
> things
> over to arch/powerpc it might be a good idea to document them at  
> least.

Definitely, we need more good examples, and maybe some
public stonings or something like that.

> Otherwise, I fear we'd wind up repeating ourselves over and over.
>
> Could we get a 'thou shalt not rely on defaults' added to
> booting-without-of.txt?  Or maybe something less draconian ;).

Such a statement is too vague to be meaningful.  It would
be a good idea in separate cases; but _do_ describe it more
carefully than just talking about "defaults", and _do_ put
a comment at any such entry that this is different from how
Open Firmware defines this, so that people looking at the
Linux code won't get hopelessly confused.


Segher
