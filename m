Return-Path: <bwarren@qstreams.com>
Received: from smtp110.biz.mail.re2.yahoo.com (smtp110.biz.mail.re2.yahoo.com
	[206.190.53.9]) by ozlabs.org (Postfix) with SMTP id 372C1DDEC7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Jul 2007 00:16:06 +1000 (EST)
Subject: Re: ping command
From: Ben Warren <bwarren@qstreams.com>
To: Nethra <nethra_gmit@yahoo.co.in>
In-Reply-To: <11779249.post@talk.nabble.com>
References: <11779249.post@talk.nabble.com>
Content-Type: text/plain
Date: Thu, 26 Jul 2007 10:09:25 -0400
Message-Id: <1185458965.6839.8.camel@saruman.qstreams.net>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Nethra,

On Wed, 2007-07-25 at 02:29 -0700, Nethra wrote:
> hi,
> 
> I m using custom board same as eval board MPC8272ADS board.
> 
> IP assigned for both ethernets are...
> 
>               ifconfig eth1 192.168.33.135 up
> 	 ifconfig eth1 netmask 255.255.248.0
>  	 route add default gw 192.168.32.47 eth1
>  
> 
> 	 ifconfig eth0 192.168.178.89 up
> 	 ifconfig eth0netmask 255.255.255.0
> 	 route add default gw 192.168.178.47 eth0
> 
> but if i try for ping 192.168.33.135 command pails by the server of 178
> series
> similarly ping 192.168.178.89 command pails by the server of 33 series..
> 
> what is the problem..and whre i m going wrong..?

What does your routing table show?  (route -n).  It wouldn't hurt to
also post the output of ifconfig for both interfaces.

regards,
Ben
