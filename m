Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A9958DE395
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 01:36:10 +1000 (EST)
Message-Id: <9EE906F9-120F-4434-9CD2-92DBAB090855@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
In-Reply-To: <200804101720.36975.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: patches for 2.6.26
Date: Thu, 10 Apr 2008 10:36:05 -0500
References: <D9A4BB4A-970C-4E9E-9174-BA8C0191CCA2@kernel.crashing.org>
	<200804101720.36975.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 10, 2008, at 10:20 AM, Laurent Pinchart wrote:
> On Thursday 10 April 2008 16:21, Kumar Gala wrote:
>> Guy's
>>
>> if you have work you want in 2.6.26 related to Freescale PPC's let me
>> know.  Ideally you can provide links to the patches in
>> http://patchwork.ozlabs.org/linuxppc/
>
> Could you please add this one ?
>
> fs_enet: Don't call NAPI functions when NAPI is not used.
> http://patchwork.ozlabs.org/linuxppc/patch?id=17055

Jeff Garzik should ack this first.  (you'll want to send to netdev and  
Jeff).

(also ask him if he want it to go via netdev or ppc tree's).

- k
