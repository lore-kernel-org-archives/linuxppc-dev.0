Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 175BBB7B7A
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2009 02:30:41 +1100 (EST)
Message-ID: <4ADDD790.3010306@embedded-sol.com>
Date: Tue, 20 Oct 2009 17:30:24 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: UBIFS problem on MPC8536DS
References: <4AD5ADC9.30503@embedded-sol.com>
	<4AD5C5B4.3060303@nokia.com>	<4AD5D053.9000901@embedded-sol.com>
	<4AD5FFE7.7080703@nokia.com>	<4AD60EF4.4080306@embedded-sol.com>	<4AD614E4.6030005@freescale.com>
	<4AD7811A.6040501@freescale.com>	<4AD7FE37.1060705@embedded-sol.com>	<20091016153128.GA11838@loki.buserror.net>	<4ADAE205.7070106@embedded-sol.com>	<20091019154002.GC19074@loki.buserror.net>	<4ADCC08D.5080207@embedded-sol.com>
	<4ADCC247.6080107@freescale.com>
In-Reply-To: <4ADCC247.6080107@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Felix Radensky wrote:
>> OK, no problem. I just wanted to get an idea of what should be done.
>> Should the NOR code poll some eLBC register to wait for completion of
>> NAND special operation ? Can you tell what register is relevant ?
>
> I was thinking you'd just share a mutex with the NAND code.
>
OK, I have NOR and NAND synchronized properly now.
Thanks a lot for your  help.

Felix.
