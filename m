Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-129.bluehost.com (outbound-mail-129.bluehost.com
	[67.222.38.29]) by ozlabs.org (Postfix) with SMTP id D1437DDE07
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  1 Jun 2008 03:07:55 +1000 (EST)
Message-ID: <484185E9.6040207@dlasys.net>
Date: Sat, 31 May 2008 13:07:53 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Alan Nishioka <alan@nishioka.com>
Subject: Re: FW: Error occured when appended FPGA image in the section of
	.init.text then bootup
References: <BAY124-W49CC670970046CAE18FB33A8B90@phx.gbl>
	<4841270B.9080805@nishioka.com>
In-Reply-To: <4841270B.9080805@nishioka.com>
Content-Type: text/plain; charset=gb2312
Cc: linuxppc-embedded@ozlabs.org
Reply-To: dhlii@dlasys.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Is there some reason this patch is not getting pushed into mainline ?



Alan Nishioka wrote:
> ÖìÀû´ï wrote:
>   
>>     The request below give rise to the problem.
>>     I have some boards equiped with MPC8247 and FPGA without storage
>>     media which used as a PCI interface. So when the linux bootup
>>     before initialize the PCI, the code of FPGA will download. I
>>     append the FPGA code file in the Kernel section '.init.text'. when
>>     linux bootup firstly it check the board type(different board type
>>     would download different code), and download fpga code. More board
>>     types lead to more FPGA code. I append them all in the section of
>>     '.init.text'. when the total size of the code reach out 2M. The
>>     error occured. I read the '__log_buf' the kernel access some bad
>>     area. As the powerpce603 will map 16M address use two bat, how and
>>     why the problem occured, and how to solved it .
>>
>>     
>
> Since the error occurs at 2M, I am going to guess it is similar to
> problem I had. The default link/load address for booting is 0x200000.
>
> Here is a link:
> <http://patchwork.ozlabs.org/linuxppc-embedded/patch?id=14717>
>
> This fix is for the arch/ppc tree. I don't know if the arch/powerpc tree
> works the same way.
>
> In the future, you should say what kernel version you are using and what
> the error was.
>
> Alan Nishioka
> alan@nishioka.com
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
