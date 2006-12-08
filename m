Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BE92F67BBE
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 01:44:39 +1100 (EST)
In-Reply-To: <407514.33488.qm@web58414.mail.re3.yahoo.com>
References: <407514.33488.qm@web58414.mail.re3.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EEF5A3A8-9D02-4A35-A2B9-58FA7DF9FFB3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: GPIO driver
Date: Fri, 8 Dec 2006 08:44:33 -0600
To: Shriram Janardhan <shriramjanardhan@yahoo.com>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 8, 2006, at 8:43 AM, Shriram Janardhan wrote:

> Kumar,
>
> Greetings!!  I am trying to port some applications from IBM 405h to  
> MPC8541.  I am using the 2.6.11 kernel distribution from  
> freescale.  I was just wondering if there would be any generic GPIO  
> driver for the 85xx series, something along the lines of  
> ibm_ocp_gpio driver for the 4xx series from Montavista.

There isn't at this point.  There has been some discussion at a  
higher level of a generic GPIO infrastructure, but I have looked at  
what's going on there in a few weeks.

- k
