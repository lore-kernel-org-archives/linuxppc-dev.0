Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F3A3EDE317
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 06:23:12 +1000 (EST)
In-Reply-To: <1214424332-18496-1-git-send-email-timur@freescale.com>
References: <1214424332-18496-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <762468c24d365ca8397b5833aa172b95@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: add of_find_next_property and
	of_get_aliased_index
Date: Wed, 25 Jun 2008 22:22:52 +0200
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, sr@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> of_get_aliased_node() looks up the aliases in the "/aliases" node and 
> returns
> the index of the property that points to a given node.  That is, if 
> you have
> an alias "serial2" that points to a serial port node, 
> of_get_aliased_index()
> returns "2".

It returns 2 for both "i2c-1" and "i2c-2".

Also, alias names do not have any significance in general, they are
just handy shortcut names for humans to use; it would be better not
to overload this.  What do you want to use this for?


Segher
