Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 2ED3667A6C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Mar 2005 06:09:24 +1100 (EST)
Message-ID: <423732E1.2090906@mvista.com>
Date: Tue, 15 Mar 2005 12:09:21 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Greg Weeks <greg.weeks@timesys.com>
References: <4237320D.9040200@timesys.com>
In-Reply-To: <4237320D.9040200@timesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [patch] mpc8560ads mtd map
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Greg Weeks wrote:

>
> Add an MTD map for the flash on the mpc8560ads board.
>
> Signed-off-by: Greg Weeks <greg.weeks@timesys.com> 


<snip>

Most of the code in this patch can be eliminated if you set up the table 
in your platform file and use the proper CONFIG_MTD_xxx options.

Mark
