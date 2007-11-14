Return-Path: <w.reissnegger@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 539A6DDDFD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Nov 2007 03:06:21 +1100 (EST)
Message-ID: <473B1CF4.4000506@gmx.net>
Date: Wed, 14 Nov 2007 08:06:12 -0800
From: Wolfgang Reissnegger <w.reissnegger@gmx.net>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Petr_Z=28ejdl?= <zejdlp1@fel.cvut.cz>
Subject: Re: Xilinx EMAC Lite driver
References: <473AEADC.9030603@fel.cvut.cz>
In-Reply-To: <473AEADC.9030603@fel.cvut.cz>
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Petr,

you can clone the Xilinx Linux git tree at:
 
   git://git.xilinx.com/linux-2.6-xlnx.git

The lin26-xlnx branch in the repository is based on 2.6.23 and contains support for the EMACLITE.

Hope this helps,
     Wolfgang

Petr Z(ejdl wrote:
> Hi All,
> 
> I'm running vanilla kernel 2.6.23.1 on Memec board (ppc405, ML300
> compatible) with ethernet Xilinx EMAC Lite. What I need is the driver
> for EMAC Lite. I was looking around without any luck. Do You know any
> solution? Or should I write a new one?
> 
> Thanks,
> Petr
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
