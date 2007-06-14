Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.233])
	by ozlabs.org (Postfix) with ESMTP id 53217DDD06
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 16:13:44 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id v1so420023nzb
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 23:13:43 -0700 (PDT)
Message-ID: <fa686aa40706132313h7eb29b3ax9fb417fc54a1e30@mail.gmail.com>
Date: Thu, 14 Jun 2007 00:13:42 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "xu chen" <chenxurcy@yahoo.com.cn>, linuxppc-dev@ozlabs.org
Subject: Re: opb_ethernet driver
In-Reply-To: <20070612034522.GA4198@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <22250.22723.qm@web92006.mail.cnb.yahoo.com>
	<20070612034522.GA4198@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 6/11/07, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Mon, Jun 11, 2007 at 10:37:55AM +0800, xu chen wrote:
> > Hello.
> >       I'm porting an opb_ethernet driver to my ml403 board now, using the 2.6.17 kernel. I know the ethernet support 3 mode: No DMA, simple DMA, scatter gather DMA, when I use the No DMA mode, we can write the skb into the FIFO, but can't ping other PCs in the network. When I use the simple DMA mode, at the time of ping, in the driver, we should initialize the DMA channel, but when transfering the skb, the DMA returns a "DMA bus time out" signal.
> >      Now I'm worry about it. Who had encountered the problem before? I think I need some help.
>
> What's an opb_ethernet?

In this context, it's a Xilinx Ethernet IP core implemented in an FPGA
and connected to the OPB bus.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
