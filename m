Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 54568DDE24
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 07:40:47 +1000 (EST)
In-Reply-To: <20080506150955.0fdcaa85@zod.rchland.ibm.com>
References: <20080506150955.0fdcaa85@zod.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e568c51ffa5f865094b26827ef959aa1@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: arch/ppc is broken
Date: Tue, 6 May 2008 23:39:34 +0200
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Every arch/ppc defconfig I built today failed.  Someone broke it.

On a related note, arch/ppc defconfig doesn't even configure anymore;
common_defconfig was removed, but it is still the default.  What config
should we use as default now?

Josh, I'll look into the build failure now.


Segher
