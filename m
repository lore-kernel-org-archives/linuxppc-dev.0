Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D3E152BF40
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Nov 2004 20:18:31 +1100 (EST)
Date: Wed, 10 Nov 2004 01:18:27 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Message-ID: <20041110091827.GA15672@gate.ebshome.net>
References: <4EE0CBA31942E547B99B3D4BFAB348111ECD4C@mail.esn.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB348111ECD4C@mail.esn.co.in>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Linux port for the 440EP processor
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Nov 10, 2004 at 11:36:44AM +0530, Mukund JB. wrote:
> Does 440EP processor come under 4xx type?

Yes. But AFAIK 440EP port isn't available publicly, yet.

> Is there a central repository for Linux distributions for 440 series?

440 isn't something special, currently all 2.6 work is done in 
kernel.org tree. For more info, see http://penguinppc.org/kernel/

> Are there any tools, help Documents that can help build Linux
> distribution for the 440EP Processor?
> In "Linux for PowerPC Embedded Systems HOWTO" Document, the Target
> Hardware's 4xx series points to some site addr & I didn't find any 440
> processor support there? 
> 
> Do I have access to the working 440GP & 440GX in both 2.4 & 2.6
> developed by u? where can I find them?

You can consider MontaVista Linux (www.mvista.com). Currently they 
support 440GP & 440GX. You can also take a look at www.denx.de, 
although I have no idea how good is 44x support they provide.

--
Eugene
