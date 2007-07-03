Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AA741DDF21
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jul 2007 18:33:00 +1000 (EST)
In-Reply-To: <1183451146.14800.4.camel@localhost.localdomain>
References: <18057.57417.999506.887803@cargo.ozlabs.ibm.com>
	<1183451146.14800.4.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D7FB6C3D-BBA4-45A9-84CA-3D671D1FAEB8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Patches added to 2.6.23 branch
Date: Tue, 3 Jul 2007 03:32:44 -0500
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 3, 2007, at 3:25 AM, Zang Roy-r61911 wrote:

> Paul
>
> Could you help to add these patches:
>
> 1 add cuboot for 7448hpc2 board
> http://ozlabs.org/pipermail/linuxppc-dev/2007-May/036834.html

Reviewing this one.

> 2. Remove redundant pci_read_irq_line() function for 85xx platform
> Acked by Ben
> http://ozlabs.org/pipermail/linuxppc-dev/2007-June/037117.html
>
> 3. Fix e500 v2 core reboot bug
> http://ozlabs.org/pipermail/linuxppc-dev/2007-June/037799.html
>
> 4. Document the global utilities node define and example
>
> http://ozlabs.org/pipermail/linuxppc-dev/2007-June/038136.html
> http://ozlabs.org/pipermail/linuxppc-dev/2007-June/038137.html

I've pulled all these into my tree.

- k
