Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 754A8682E6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Sep 2005 02:18:18 +1000 (EST)
Date: Wed, 14 Sep 2005 09:18:15 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Jeff Garzik <jgarzik@pobox.com>
Message-ID: <20050914161815.GA21263@gate.ebshome.net>
References: <20050831045847.GA17017@gate.ebshome.net>
	<20050831050048.GB17017@gate.ebshome.net>
	<43281B7D.5000106@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43281B7D.5000106@pobox.com>
Cc: netdev@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 1/2] New PowerPC 4xx on-chip ethernet controller driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Sep 14, 2005 at 08:45:49AM -0400, Jeff Garzik wrote:
> Eugene Surovegin wrote:
> >Remove old PPC4xx EMAC driver
> >
> >Signed-off-by: Eugene Surovegin <ebs@ebshome.net>
> 
> Please post a diff, along with a description of the changes.
> 
> One huge patch to "remove emac driver" and another huge patch to "add 
> emac driver" is quite silly.

Jeff, it's not silly. I can post combined patch, but you won't be 
able to read it (and combined patch is still big).

As I said, it's a _complete_ re-write. It's a _new_ driver, not just 
some "changes". Description of what was done was in the first e-mail.

I've split it into two parts specifically, so _you_ will be able to 
read new patch and comment on it.

-- 
Eugene
