Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 2DE6EDDFE0
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 02:57:44 +1000 (EST)
Message-ID: <463A14E6.5010608@ru.mvista.com>
Date: Thu, 03 May 2007 20:59:18 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: powerpc_flash_init(), wtf!?
References: <20070501051804.GB3881@localhost.localdomain>
	<20070503103534.63ff67b6@localhost.localdomain>
	<20070503070358.GA9430@localhost.localdomain>
	<4639CF44.6020608@ru.mvista.com>
	<20070503122213.GD26659@localhost.localdomain>
	<4639E389.4040604@ru.mvista.com>
	<a8625bde363025ce23393d5b2bb6ec07@kernel.crashing.org>
In-Reply-To: <a8625bde363025ce23393d5b2bb6ec07@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Segher Boessenkool wrote:

>>     BTW, is it legal/appropriate to specify device (not bus) types for
>> of_platform_bus_probe()?

> In almost all cases you should probe on "name"/"compatible",

    Probing on name is not a good idea, since those are mostly generic.

> and not use "device_type" at all.

    Heh, SPARC device trees I saw seem to not have this "useless" prop at all. :-)

> Segher

WBR, Sergei
