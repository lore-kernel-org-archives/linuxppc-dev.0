Return-Path: <dhlii@comcast.net>
Received: from sccrmhc14.comcast.net (sccrmhc14.comcast.net [204.127.202.59])
	by ozlabs.org (Postfix) with ESMTP id 3F7E66878E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Nov 2005 06:43:37 +1100 (EST)
Message-ID: <437CDD65.7020709@comcast.net>
Date: Thu, 17 Nov 2005 14:43:33 -0500
From: "David H. Lynch Jr" <dhlii@comcast.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
References: <437308E6.2070804@ecrin.com> <437C4E07.8020307@comcast.net>
In-Reply-To: <437C4E07.8020307@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: "Now booting the kernel"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

David H. Lynch Jr. wrote:
> I am having similar difficulties on a Xilinx Virtex 4.
>
>    I have some advantages over Nitesh in that I have a 32bit port at 
> 0x70000000 that I can write values to and see what they are (at least 
> until the MMU is enabled)
>    and with some additional complexity use as a sort of UART to write 
> text.
>      Thus far this is what I get:
>
> Starting MonitorX.elf: V3.3.2.0.
> Loading zImage.elf.
Sorry, this is Linux 2.6.14 on a Xilinx-VI
