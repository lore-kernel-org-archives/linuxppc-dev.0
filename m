Return-Path: <mike@compulab.co.il>
Received: from oceanus.site5.com (oceanus.site5.com [67.43.13.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4A29F679E0
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Apr 2006 17:07:16 +1000 (EST)
Message-ID: <44433D88.1060406@compulab.co.il>
Date: Mon, 17 Apr 2006 09:02:32 +0200
From: Mike Rapoport <mike@compulab.co.il>
MIME-Version: 1.0
To: Bastos Fernandez Alexandre <ALEBAS@televes.com>
Subject: Re: Watchdog on MPC82xx
References: <1144835330.443ccd021b40a@webmail.televes.com:443>
	<1144842264.443ce818d6822@webmail.televes.com:443>
In-Reply-To: <1144842264.443ce818d6822@webmail.televes.com:443>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Bastos Fernandez Alexandre wrote:

>
>So, any other idea? Is the WDT on MPC8248 usable at all?
>  
>
I used the watchdog timer on mpc8247 and mpc8271. The mpc8248 watchdog 
should be the same. I used ppc_md.heartbeat to write to the watchdog 
registers and it worked fine. Also, I've added WATCHDOG_RESET()  to 
common/cmd_bootm.c in U-Boot just before the jump to kernel.

>Thanks,
>
>Alex
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
>
>  
>


-- 
Sincerely yours,
Mike Rapoport
-----------------------------------------------------------------
CompuLab Ltd.
Web: http://www.compulab.co.il
