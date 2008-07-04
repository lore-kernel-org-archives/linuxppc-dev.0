Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 14C92DDED0
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jul 2008 09:15:12 +1000 (EST)
In-Reply-To: <40B88BFD-1FEB-4E36-9917-54C7380FF801@kernel.crashing.org>
References: <40B88BFD-1FEB-4E36-9917-54C7380FF801@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <502593fa15ea72d549693f843651afd2@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: New fsl device bindings file
Date: Sat, 5 Jul 2008 01:14:53 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I'm sure you'll hate for doing this,

No, it's an excellent move :-)

> but I've asked Kim to create a new 
> Documentation/powerpc/fsl-device-tree-bindings.txt as part of his SEC 
> patch.

As a separate patch, that (at first) _only_ moves the content into 
separate
files, please.


Segher
