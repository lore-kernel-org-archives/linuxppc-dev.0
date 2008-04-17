Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C408FDE143
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 07:53:40 +1000 (EST)
Message-Id: <2F36BD63-363C-4BA6-AA42-8002A09FD937@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080417192850.GC28286@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 3/5] [POWERPC] QE: split par_io_config_pin()
Date: Thu, 17 Apr 2008 16:53:34 -0500
References: <20080417192656.GA19107@polina.dev.rtsoft.ru>
	<20080417192850.GC28286@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 17, 2008, at 2:28 PM, Anton Vorontsov wrote:
> This patch splits par_io_config_pin so we can use it with GPIO LIB  
> API.
>
> Also add a comment regarding #ifdef CONFIG_PPC_85xx being legacy.

legacy to what?

- k
