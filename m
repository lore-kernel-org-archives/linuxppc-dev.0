Return-Path: <liml@rtr.ca>
Received: from mail.rtr.ca (rtr.ca [64.26.128.89])
	by ozlabs.org (Postfix) with ESMTP id 6E2C967B15
	for <linuxppc-dev@ozlabs.org>; Sat, 27 May 2006 01:47:13 +1000 (EST)
Message-ID: <447722FF.9020202@rtr.ca>
Date: Fri, 26 May 2006 11:47:11 -0400
From: Mark Lord <liml@rtr.ca>
MIME-Version: 1.0
To: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: [PATCH/2.6.17-rc4 10/10]  bugs fix for marvell SATA on powerp
	c pl atform
References: <9FCDBA58F226D911B202000BDBAD46730626DE6E@zch01exm40.ap.freescale.net>
	<1147935734.17679.93.camel@localhost.localdomain>
	<446C9219.4080300@pobox.com> <446CDE26.8090504@rtr.ca>
	<20060526083931.GA23938@powerlinux.fr> <4476E964.90509@rtr.ca>
	<20060526114245.GA32330@powerlinux.fr>
	<44770065.8070907@rtr.ca> <20060526141535.GA7084@powerlinux.fr>
In-Reply-To: <20060526141535.GA7084@powerlinux.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Alexandre.Bounine@tundra.com, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
	Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sven Luther wrote:
> On Fri, May 26, 2006 at 09:19:33AM -0400, Mark Lord wrote:
>> Sven Luther wrote:
>>> Ok. can i use this tree with a 2.6.16 base ?
>> Not as-is.  Here (attached) is a patch for 2.6.16.17+ that updates
>> the sata_mv driver to the latest source.  Completely untested,
>> but it does compile.
>>
>> I will hopefully test it later today, but in the meanwhile, have a go at it.
> 
> And here is attached my dmesg output. The last bit of mv_host_intr was when i
> tried to access the partition table of the disk with parted.

I don't see anything particularly bad in that dmesg output,
apart from all of the debug output --> did you enable that,
or was it "on" by default?

It finds one SATA drive, with no *known* partition table format.

Can you access the disk?  Eg.  hexdump -C /dev/sda

Meanwhile, I just booted 2.6.17-rc5-git1 (latest kernel.org) on my Mac G3
box here, and sata_mv seems to be behaving for me (thus far).

Cheers
