Return-Path: <JTRAILL@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 34739B6F06
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Oct 2010 01:45:52 +1100 (EST)
Message-ID: <4CAB39F4.3030208@freescale.com>
Date: Tue, 5 Oct 2010 15:45:08 +0100
From: John Traill <JTRAILL@freescale.com>
MIME-Version: 1.0
To: Bastiaan Nijkamp <bastiaan.nijkamp@gmail.com>
Subject: Re: Serial RapidIO Maintaintance read causes lock up
References: <0CE8B6BE3C4AD74AB97D9D29BD24E552013B97E8@CORPEXCH1.na.ads.idt.com>
	<AANLkTimCiHWRR-kVuT0ift3CH63Xk_XcaXS22qmVh6fr@mail.gmail.com>
	<4CAB2729.6080402@freescale.com>
	<AANLkTik46NsiMhWo=GkHz4UbdDJeBLwFATJzhk-M3hSP@mail.gmail.com>
In-Reply-To: <AANLkTik46NsiMhWo=GkHz4UbdDJeBLwFATJzhk-M3hSP@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bastiaan,

On 05/10/10 15:28, Bastiaan Nijkamp wrote:
> Hi John,
> 1. Yes, they are both running the exact same kernel and both are
> configured in the same way. With the exception that one is set as host
> and the other as a agent.
> 2. Accept All is set for both boards.
> 3. As i understand, the agent cannot send anything before it is
> enumerated, so it would be safe to first reset the agent and right after
> that the host. In either case, thats the way i am using. The full kernel
> log until the discovery times out after 30 seconds is shown below:
> Using SBC8548 machine description
<snip>

In which case could you check the lawbar initialisation in u-boot for conflicts. 
Would you post a dump of the lawbar registers from uboot.

The TLB's aren't important in this case as linux will reprogram as required.

Cheers

-- 
John Traill
Systems Engineer
Network and Computing Systems Group

Freescale Semiconductor UK LTD
Colvilles Road
East Kilbride
Glasgow G75 0TG, Scotland

Tel: +44 (0) 1355 355494
Fax: +44 (0) 1355 261790

E-mail: john.traill@freescale.com

Registration Number: SC262720
VAT Number: GB831329053

[ ] General Business Use
[ ] Freescale Internal Use Only
[ ] Freescale Confidential Proprietary
