Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 38A62B7BAD
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2009 19:21:02 +1100 (EST)
Message-ID: <4AE015DD.1010009@embedded-sol.com>
Date: Thu, 22 Oct 2009 10:20:45 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: UBIFS problem on MPC8536DS
References: <4AD5ADC9.30503@embedded-sol.com>
	<4AD5C5B4.3060303@nokia.com>	<4AD5D053.9000901@embedded-sol.com>
	<4AD5FFE7.7080703@nokia.com>	<4AD60EF4.4080306@embedded-sol.com>	<4AD614E4.6030005@freescale.com>
	<4AD7811A.6040501@freescale.com>	<4AD7FE37.1060705@embedded-sol.com>
	<20091016153128.GA11838@loki.buserror.net>
In-Reply-To: <20091016153128.GA11838@loki.buserror.net>
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

Hi, Scott

Scott Wood wrote:
> On Fri, Oct 16, 2009 at 07:01:43AM +0200, Felix Radensky wrote:
>   
>> Thanks for confirmation. So the real problem is eLBC ?
>> What happens if I access other devices on eLBC (e.g. FPGA)
>> simultaneously with NAND or NOR ?
>>     
>
> AFAICT, the problem is NAND being accessed simultaneously with anything else
> on the eLBC (at least GPCM -- not sure about UPM).  Instead of delaying the
> memory-like transaction until the NAND special operation has completed, it
> seems to just abort the NAND operation.
>
> eLBC can't really tell the difference whether you've got NOR or FPGA hooked
> up to a GPCM chip select, so the problem should still apply.
>   

Are you aware of Freescale plans to fix the problem in new silicon 
revisions ?
Also, can you please tell what CPUs are affected by this, except 8536 
and 8572.

Thanks a lot.

Felix.
