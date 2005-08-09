Return-Path: <segher@kernel.crashing.org>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de.ibm.com", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id CEC8167FC5
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Aug 2005 23:08:57 +1000 (EST)
In-Reply-To: <42F79D89.3040709@austin.ibm.com>
References: <17136.13558.773102.465379@cargo.ozlabs.ibm.com>
	<42F79D89.3040709@austin.ibm.com>
Mime-Version: 1.0 (Apple Message framework v622)
Message-Id: <bb9b1e9e1ebdc3ac5b23b3cab327bfd5@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Tue, 9 Aug 2005 15:09:02 +0200
To: Joel Schopp <jschopp@austin.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: Merging ppc32 and ppc64
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> I don't see the merge as changing the actual code that gets executed
>> on any given platform very much, except in one respect: we are going
>> to standardize on a flattened device tree as the way that information
>> about the platform gets passed from the boot loader to the kernel.
>> Comments? Flames? :)
>
> There are several userspace applications that parse the non-flat 
> device tree in /proc/device-tree on pSeries.  While I like the idea of 
> the flattened device tree I think we need to consider how many apps we 
> are going to break with it.

_Please_ don't throw the real device tree away; I'm happy with
the flattened device tree if and only if it is a _minimum_
requirement, and having a _real_ device tree (or even real
Open Firmware support) is still an option.


Segher
