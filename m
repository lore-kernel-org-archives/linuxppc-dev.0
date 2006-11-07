Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 85A1C67CD6
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Nov 2006 06:53:42 +1100 (EST)
In-Reply-To: <1b2aacd80611061551t78cc4f1aoef66377e82c2daed@mail.gmail.com>
References: <1b2aacd80611061551t78cc4f1aoef66377e82c2daed@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2E3AE2D7-49C3-40BB-B939-7FE821EA8C2A@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: ethernet interface problem with kernel 2.6.14 on MPC8343E
Date: Tue, 7 Nov 2006 13:53:38 -0600
To: Luong Ngo <luong.ngo@gmail.com>
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


On Nov 6, 2006, at 17:51, Luong Ngo wrote:

> Hello,
>
> I am having a problem with the interfaces eth0 and eth1 when  
> running 2.6.14 kernel on a board with MPC8343E. The problem I  
> encounters is only one of the eth interface is really working. Only  
> the one that is configured first, using "ifconfig eth[0/1]  
> 192.168.1.1 netmask 255.255.255.0" can ping and be pinged from  
> another host. I wonder if there is setup difference between the  
> TSEC1 and TSEC2 or this is not related to hardware but rather  
> something in the kernel. When I ping from other host, from within  
> the Gianfar driver, I can see the packet is received on both  
> interfaces but only one responds. When pinging from the system  
> itself, only the working interface sending out packet, the other  
> interface does not send anything. Please advise me what I am doing  
> wrong or missing.
>

It sounds like both work for you, but not at the same time?

If you set them both to the same IP address, it won't work.   
Actually, it won't work if you set them to different IP addresses on  
the same subnet (as defined by their netmasks).

I think you are trying to get Linux to do something that it doesn't  
do.  Try setting them to different IP addresses, like 192.168.1.1 and  
192.168.2.1

Andy
