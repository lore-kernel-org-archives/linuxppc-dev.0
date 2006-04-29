Return-Path: <info@schihei.de>
Received: from schihei.org (schihei.net [81.169.184.117])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A207F679EA
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 16:39:20 +1000 (EST)
In-Reply-To: <84144f020604272332s6101032cy6936096230f3637c@mail.gmail.com>
References: <4450A176.9000008@de.ibm.com>
	<20060427114355.GB32127@wohnheim.fh-wedel.de>
	<1146177388.19236.1.camel@localhost.localdomain>
	<6C4A3B96-4752-4FF9-8FBE-C383B00AE014@schihei.de>
	<84144f020604272332s6101032cy6936096230f3637c@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4044CACC-FB5A-415E-8974-27136269B5C1@schihei.de>
From: Heiko J Schick <info@schihei.de>
Subject: Re: [openib-general] Re: [PATCH 04/16] ehca: userspace support
Date: Sat, 29 Apr 2006 08:38:46 +0200
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
	=?ISO-8859-1?Q? J=F6rn_Engel ?= <joern@wohnheim.fh-wedel.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

On 28.04.2006, at 08:32, Pekka Enberg wrote:

>> The problem I see with pr_debug() is that it could only activated via
>> a compile flag. To use the debug outputs you have to re-compile /
>> compile your own kernel.
>
> Do you really need this heavy debug logging in the first place? You
> can use kprobes for arbitrary run-time inspection anyway, so logging
> everything seems wasteful.

The problem I see with kprobes is that you have to set several kernel
configuration options (e.g. CONFIG_KPROBES, CONFIG_DEBUG_INFO, etc.)
on compile time to use it. Same problem with pr_debug().

Regards,
	Heiko
