Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 617F2DDDDB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Nov 2008 04:36:42 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1L0g7T-0004Er-9o
	for linuxppc-embedded@ozlabs.org; Thu, 13 Nov 2008 09:36:39 -0800
Message-ID: <20484920.post@talk.nabble.com>
Date: Thu, 13 Nov 2008 09:36:39 -0800 (PST)
From: saadia dhouib <saadia_dhouib@yahoo.fr>
To: linuxppc-embedded@ozlabs.org
Subject: Re: ifconfig: SIOCSIFNETMASK: No such device (xupv2p+ppc+linux
	2.6.27-rc)
In-Reply-To: <491C58F7.5020108@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <20481642.post@talk.nabble.com> <491C58F7.5020108@freescale.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi scott,
Thanks for the response. do you know why I  have this error: xilinx_emac
40c00000.ethernet: no IRQ found. ?


Scott Wood-2 wrote:
> 
> saadia dhouib wrote:
>> Device Tree Probing 'ethernet'
>> xilinx_emac 40c00000.ethernet: no IRQ found.
> 
> This might be a problem.
> 
>> root:~> ifconfig 172.25.49.123 netmask 255.255.255.0
>> ifconfig: SIOCSIFNETMASK: No such device
>> root:~> ### Application running ...
>> 
>> 
>> 
>> My question is: why I can't assign an IP address ??
> 
> ifconfig eth0 172...
> 
> -Scott
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/Problems-with-ethernet-device-%28xupv2p%2Bppc%2Blinux-2.6.27-rc%29-tp20481642p20484920.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
