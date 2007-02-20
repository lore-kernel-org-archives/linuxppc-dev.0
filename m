Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 12E58DDE21
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Feb 2007 00:43:38 +1100 (EST)
Date: Tue, 20 Feb 2007 16:44:16 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Manjunath AM <Manjunath.AM@Lntemsys.com>
Subject: Re: enabling two eths
Message-ID: <20070220164416.5a3906bc@vitb.dev.rtsoft.ru>
In-Reply-To: <OFAEAB5385.D1B18D5F-ON65257288.0048394A-65257288.00493E72@lntemsys.com>
References: <OFAEAB5385.D1B18D5F-ON65257288.0048394A-65257288.00493E72@lntemsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: kernelnewbies@nl.linux.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 20 Feb 2007 18:51:41 +0530
Manjunath AM <Manjunath.AM@Lntemsys.com> wrote:

> Hi,
> 
> We are using MPC8272 based target board, we use montavista Linux version 
> 2.6.10 kernel image (with NFS enabled) to our target board,
> 
> Our board has  2 FCCs (eth0 and eth1). bot the eth's works perfectly when 
> we use them independently, but when we are trying to enable second one 
> after the kernel is up using linux command  "ifconfig eth1 192.168.33.64 
> up"(IP address)nothing is working.
> Please suggest how to enable second eth (either 0 or 1) once the kernel is 
> up with NFS file system
> 

I could recall no problems with mpc8272 except stuck PHY which were cured by board power cycle.
I brought up second Ethernet interface a number of times without any problem; even had them replace each 
other serving as NFS root gate.

So I would suggest supplying more information on "nothing is working", prolly kernel output and details about MVL product you are using.

-- 
Sincerely, 
Vitaly
