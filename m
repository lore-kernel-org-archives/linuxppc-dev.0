Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4D8A167A84
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Mar 2005 11:46:04 +1100 (EST)
Date: Fri, 4 Mar 2005 16:46:01 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050305004601.GA4135@gate.ebshome.net>
References: <402824c4830f426df0afdb3515b6df61@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <402824c4830f426df0afdb3515b6df61@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	ppcembed Mailing List <linuxppc-embedded@ozlabs.org>
Subject: Re: RFC: SPR namespace issue
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 04, 2005 at 06:24:37PM -0600, Kumar Gala wrote:
> A while ago Al Viro made some changes to the SPR defines to remove some 
> name space conflicts.  I wanted to see if anyone had any issue with 
> removing the short hand versions of the defines in the various reg*.h 
> headers.  This means all SPR references will be SPRN_<FOO> going 
> forward.

I think it's a good idea.

--
Eugene
