Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 19A6467A00
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Mar 2006 02:26:52 +1100 (EST)
In-Reply-To: <3d42041d0603020632o2d75bd7ao99c7b006042a88d9@mail.gmail.com>
References: <200603021012.57955.michael@ellerman.id.au>
	<Pine.LNX.4.44.0603011746320.10931-100000@gate.crashing.org>
	<3d42041d0603020632o2d75bd7ao99c7b006042a88d9@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AA9A461A-06CF-44DE-A8EE-E2D60CA83B00@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [Fastboot] Re: Kexec for booke PPC processors
Date: Thu, 2 Mar 2006 09:26:46 -0600
To: dagriego <dagriego@gmail.com>
Cc: Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@ozlabs.org,
	fastboot@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 2, 2006, at 8:32 AM, dagriego wrote:

> I'm working on the E500 core, particularly the mpc8540/8560ADS boards
> - David

There are patches to u-boot that have been posted to allow mpc8540  
ADS to boot with a flat device tree (needed by kexec).  In addition  
the powerpc.git tree has support in arch/powerpc for building a  
kernel that uses that flat device tree for mpc8540 ads.

I'd recommend you start with getting that going on your system.

- kumar
