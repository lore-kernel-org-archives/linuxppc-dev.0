Return-Path: <eberhard.stoll@berghof.com>
Received: from mail117.messagelabs.com (mail117.messagelabs.com
	[195.245.231.211]) by ozlabs.org (Postfix) with SMTP id 72083DDE3C
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 May 2007 17:45:34 +1000 (EST)
Message-ID: <46514DBE.30708@berghof.com>
Date: Mon, 21 May 2007 09:43:58 +0200
From: Eberhard Stoll <eberhard.stoll@berghof.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200 ethernet communication stops unexpected
References: <1179234357.1668.10.camel@pc-hans>
	<5b525e390705150803l516a5d9x9c214e2b4b00ea0e@mail.gmail.com>
In-Reply-To: <5b525e390705150803l516a5d9x9c214e2b4b00ea0e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
>   xlb = (struct mpc52xx_xlb *)MPC5xxx_XLB;
>   out_be32(&xlb->config,  in_be32(&xlb->config) | MPC52xx_XLB_CFG_BSDIS);
>   
this modification seems to solve my problem, too (ethernet communication 
stops unexpected / best comm tx task deadlock(?))!
As i described before ping -f triggered the problem in between 20 
minutes everytime. With this patch my configuration to trigger the fault 
run from Friday to Monday (> 60h) without any error!
So it seems for me this solved my problem, too!

Best regards,
Eberhard

______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email 
______________________________________________________________________
