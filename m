Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3E21467A9A
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Jan 2005 09:15:14 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sylvain Munaut <tnt@246tNt.com>
In-Reply-To: <41F80CA2.2080603@246tNt.com>
References: <200501221723.j0MHN6eD000684@harpo.it.uu.se>
	<1106441036.5387.41.camel@gaston> <1106529935.5587.9.camel@gaston>
	<41F80CA2.2080603@246tNt.com>
Content-Type: text/plain
Date: Thu, 27 Jan 2005 09:11:54 +1100
Message-Id: <1106777515.6249.79.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: BUG: 2.6.11-rc2 and -rc1 hang during boot on PowerMacs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2005-01-26 at 22:33 +0100, Sylvain Munaut wrote:

> >Finally, try that patch and tell me if it makes a difference. 
> >
> Yup
>  - Without it hangs (not really, it's still half running but serial 
> output is stuck
> due to no interrupts)
>  - With it it works

Well, in the meantime, Ingo made a proper fix to rest_init()

Ben.
