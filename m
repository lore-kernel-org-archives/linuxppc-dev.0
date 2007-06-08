Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 40C11DDEF8
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 18:47:40 +1000 (EST)
In-Reply-To: <1181271180.6026.10.camel@concordia.ozlabs.ibm.com>
References: <f0cd638495b96585dec513f41335154e60675813.1180961962.git.michael@ellerman.id.au>
	<90f8b99fa6a8e4b8898d64630d96036f68668b03.1180961962.git.michael@ellerman.id.au>
	<200706041912.04651.arnd@arndb.de>
	<1181271180.6026.10.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <cc1d6d368ded181bbbdad8e4f4cb37ae@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH 4/4] Add support for MSI on Axon-based Cell systems
Date: Fri, 8 Jun 2007 10:47:28 +0200
To: michael@ellerman.id.au
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +       for_each_compatible_node(node, NULL, "ibm,axon-msic") {
>>> +               if (axon_msi_setup_one(of_node_get(node)) == 0)
>>> +                       found++;
>>> +       }
>>> +       of_node_put(node);

So where is the of_node_put() done for the of_node_get()
inside the loop?


Segher
