Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 94B7ADE123
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 00:11:45 +1000 (EST)
Message-Id: <EA6AD0FF-DBB4-4835-A77B-EE337BAB53E2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18430.2296.189338.485646@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: Patches added to powerpc.git powerpc-next and master branches
Date: Thu, 10 Apr 2008 09:11:39 -0500
References: <200804101346.32376.laurentp@cse-semaphore.com>
	<18430.2296.189338.485646@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 10, 2008, at 7:32 AM, Paul Mackerras wrote:
> Laurent Pinchart writes:
>
>> could you please add the following patches ?
>
> Sure, if Kumar acks them, since they are all 8xxx-related as far as I
> can see (with the exception of the part of 2/5 that adds the new
> dt_get_virtual_reg function).  Or Kumar can put them in his tree.

I'll deal with them.  There are a larger number of CPM/8xxx related  
patches that I need to go through.

- k
