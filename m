Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 106CAB7088
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Oct 2009 02:40:12 +1100 (EST)
Date: Mon, 19 Oct 2009 10:40:02 -0500
From: Scott Wood <scottwood@freescale.com>
To: Felix Radensky <felix@embedded-sol.com>
Subject: Re: UBIFS problem on MPC8536DS
Message-ID: <20091019154002.GC19074@loki.buserror.net>
References: <4AD5ADC9.30503@embedded-sol.com> <4AD5C5B4.3060303@nokia.com>
	<4AD5D053.9000901@embedded-sol.com> <4AD5FFE7.7080703@nokia.com>
	<4AD60EF4.4080306@embedded-sol.com>
	<4AD614E4.6030005@freescale.com> <4AD7811A.6040501@freescale.com>
	<4AD7FE37.1060705@embedded-sol.com>
	<20091016153128.GA11838@loki.buserror.net>
	<4ADAE205.7070106@embedded-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4ADAE205.7070106@embedded-sol.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	Adrian Hunter <adrian.hunter@nokia.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Oct 18, 2009 at 11:38:13AM +0200, Felix Radensky wrote:
> Hi, Scott
>
> Scott Wood wrote:
>> On Fri, Oct 16, 2009 at 07:01:43AM +0200, Felix Radensky wrote:
>>> Thanks for confirmation. So the real problem is eLBC ?
>>> What happens if I access other devices on eLBC (e.g. FPGA)
>>> simultaneously with NAND or NOR ?
>>
>> AFAICT, the problem is NAND being accessed simultaneously with anything else
>> on the eLBC (at least GPCM -- not sure about UPM).  Instead of delaying the
>> memory-like transaction until the NAND special operation has completed, it
>> seems to just abort the NAND operation.
>>
>> eLBC can't really tell the difference whether you've got NOR or FPGA hooked
>> up to a GPCM chip select, so the problem should still apply.
>>
>
> Can you please provide some code example of synchronizing GPCM and NAND ?

I don't have any.  It's something that would have to be written.

-Scott
