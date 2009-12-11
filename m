Return-Path: <B07421@freescale.com>
Message-ID: <4B22939B.7060101@freescale.com>
Date: Fri, 11 Dec 2009 12:46:51 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Junita Ajith <ajijuni@gmail.com>
Subject: Re: dts file for MPC8343EA
References: <7675847.584551260168085277.JavaMail.nabble@isper.nabble.com>	
	<20091207180719.GB8914@loki.buserror.net>
	<72d214170912101634l1fab97fewc849a819f767415c@mail.gmail.com>
In-Reply-To: <72d214170912101634l1fab97fewc849a819f767415c@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Junita Ajith wrote:
> Hi Scott:
> 
> I am still stuck at Linux kernel booting in MPC8343EA based board.
> 
> I have disabled "Ethernet, PCI, USB, dma engines " in the *.dts file and 
> also in the kernel config.
> I am using MPC8349emitxgp.dts  ; enabled MPC8349ITX support in kernel 
> config also. In fact, I tried building MPC8349emITX; MPC8349MDS also. 
> Same behaviour!
> 
> With this, the kernel boots up (explicitly passing the DTB file and 
> cuImage NEVER worked) and hangs after
> 
> I am using Linux-V-2.6.27.18 and using powerpc-e300c3-gnu  toolchain  - 
> gcc-4.1.69-eglibc-2.5.69-1 to build u-boot-1.3.2 & linux.
> 
> With this, the kernel boots up (explicitly passing the DTB file and 
> cuImage NEVER worked) and hangs after printing
> "Calibrating delay loop... 133.12 BogoMIPS (lpj=266240)"
> 
> With a few debug printks looks like the kernel hangs in
> "cpu_idle" in --main/init.c

Try to find out what threads are blocked where.

There may also have been a problem transitioning to the normal serial 
driver.  Do you have an external debugger than can extract the log buffer?

-Scott
