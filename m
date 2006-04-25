Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1D4EF67A00
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 04:24:20 +1000 (EST)
Date: Tue, 25 Apr 2006 11:24:18 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 85xx FDT updates?
Message-ID: <20060425182418.GA1132@gate.ebshome.net>
References: <4C61B597-BD91-4D05-BB40-43DE0319F123@kernel.crashing.org>
	<17017F03-078C-4B7F-A961-EC371F534E27@embeddedalley.com>
	<34C11E8A-ED04-490F-B601-841DC1F94AD6@kernel.crashing.org>
	<20060425074902.GA20228@gate.ebshome.net>
	<66B13296-80E8-4C9E-803D-F4E3D7AABB25@embeddedalley.com>
	<853005AF-8F43-454D-80E6-F39308F89A47@kernel.crashing.org>
	<20060425170857.GE20228@gate.ebshome.net>
	<BEC38EF6-326E-4ED1-8F02-4A3FA928908F@kernel.crashing.org>
	<20060425180119.GF20228@gate.ebshome.net>
	<265F73F8-F641-4EDD-B88F-A2B2F7FA1308@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <265F73F8-F641-4EDD-B88F-A2B2F7FA1308@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 25, 2006 at 01:14:55PM -0500, Kumar Gala wrote:
> 
> >What you will end up with is that that small amount of embedded people
> >who bother to contribute something back will stop doing this. We are
> >more than capable of maintaining our internal kernel trees :).
> 
> I'm not sure what to say to this.  Things need to move forward at  
> some point.  

I don't see how removing features and breaking compatibility with 
almost _all_ current embedded PPC boards boards is "moving forward". 
Enlighten me, please.

> I still not clear as to what exactly you are advocating  
> beyond that we should keep the arch/ppc code around for ever.

Providing compatibility for non-flat-tree firmware. This doesn't mean 
keeping arch/ppc.

-- 
Eugene
