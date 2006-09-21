Return-Path: <mikey@ozlabs.org>
To: michael@ellerman.id.au
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [Fastboot] [PATCH] kexec: remove memory reserve patching for
	powerpc device tree
In-reply-to: <1158810033.7062.23.camel@localhost.localdomain> 
References: <20060921011031.4BFEA67BCE@ozlabs.org>
	<1158803944.7062.9.camel@localhost.localdomain>
	<20060921025122.GA8573@verge.net.au>
	<1158810033.7062.23.camel@localhost.localdomain>
Date: Thu, 21 Sep 2006 14:04:03 +1000
Sender: mikey@ozlabs.org
Message-Id: <20060921040405.02A6B67BB1@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Horms <horms@verge.net.au>,
	Fastboot mailing list <fastboot@lists.osdl.org>
Reply-To: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Sure it's hard, but we can at least try. If we put this patch in we'll
> be breaking backward compatibility simply in order to beautify the
> kexec-tools code a little.

Agreed.  

> I think the best option is just to add a note somewhere in the kexec
> sources that we can remove that code sometime in the future.

Agreed.  The code being removed is hacky, but mostly harmless.  

Mikey
