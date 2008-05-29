Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B4749DDF7E
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 16:33:03 +1000 (EST)
Subject: Re: [PATCH 2/6] Allow create_branch() to return errors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <b5d665dc398cc0822783593ce3a2fc6b62990759.1212042061.git.michael@ellerman.id.au>
References: <33bba4965d9907a8a93e9f92fd5c3874a6e21f90.1212042061.git.michael@ellerman.id.au>
	<b5d665dc398cc0822783593ce3a2fc6b62990759.1212042061.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Thu, 29 May 2008 16:31:52 +1000
Message-Id: <1212042712.8888.44.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-05-29 at 16:20 +1000, Michael Ellerman wrote:
> Currently create_branch() creates a branch instruction for you, and patches
> it into the call site. In some circumstances it would be nice to be able to
> create the instruction and patch it later, and also some code might want
> to check for errors in the branch creation before doing the patching. A
> future patch will change create_branch() to check for errors.
> 
> For callers that don't care, replace create_branch() with patch_branch(),
> which just creates the branch and patches it directly.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
