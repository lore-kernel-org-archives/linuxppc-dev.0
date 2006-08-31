Return-Path: <g.jaeger@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id D893E67A2E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Sep 2006 00:08:30 +1000 (EST)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Men em1 MPC5200 kernel don't start using elinos v4.0
Date: Thu, 31 Aug 2006 16:08:15 +0200
References: <20060831133857.67615.qmail@web52605.mail.yahoo.com>
In-Reply-To: <20060831133857.67615.qmail@web52605.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200608311608.15726.g.jaeger@sysgo.com>
Cc: Fodjo Yves-Eric <fodjo@yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 31 August 2006 15:38, Fodjo Yves-Eric wrote:
> Hello 
> In the course of my Thesis I have to Port linux on the board EM01 Rev 01.04.02 of Men  using Elinos V4 PPC.  My host system is Linux Fedora Core 5. I'm using the "menem1" as board. The problem is that the kernel doesn't start at all. After loading the file "hello.img" througth bootp the system give the following output and hang. 
> 
> Searching for server (BOOTP) .
> My IP 192.168.1.10:ffffff00 Server IP 192.168.1.1 GW IP 192.168.1.1
> Loading hello.img...
> to 0x02000000        861 kB
> Loaded 0x000d74e9 bytes
> Detected PPCBOOT header
>     verifiying image CRC...ok
>     Uncompressing Multi-File Image ... ok
>     Moving initrd...ok
>     passing parameters: devfs=mount rootfstype=tmpfs root=dev/ram rw ip=auto
>     Starting Linux Kernel.
> 
> 
> I have tried several combination of kernel parameters without success.
> Here is a part of my ELINOS.sh config file.

Hi,

I guess this is the wrong list for asking disto specific questions ;)

I don't have this board here currently, but one guess is, that you should
add the correct console parameter to the kernelparameter list.

HTH
Gerhard

-- 
Gerhard Jaeger <gjaeger@sysgo.com>            
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.pikeos.com | www.osek.de 
