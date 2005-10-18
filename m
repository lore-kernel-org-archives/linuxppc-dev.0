Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9AA83685DE
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Oct 2005 18:47:51 +1000 (EST)
Date: Tue, 18 Oct 2005 09:47:30 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Message-Id: <20051018094730.36aa7b99.ajz@cambridgebroadband.com>
In-Reply-To: <20051017184441.GC1245@mag.az.mvista.com>
References: <20051017123543.51aa7d24.ajz@cambridgebroadband.com>
	<20051017184441.GC1245@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-atm-general@lists.sourceforge.net, linuxppc-embedded@ozlabs.org
Subject: Re: Announce: MPC8272ADS platform support added to mpc8260sar
 project.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 17 Oct 2005 11:44:41 -0700
"Mark A. Greer" <mgreer@mvista.com> wrote:

> On Mon, Oct 17, 2005 at 12:35:43PM +0100, Alex Zeffertt wrote:
> > Hi lists, 
> > 
> > I'm writing to let anybody (who may be interested) know that I've
> > added support for the MPC8272ADS platform to the mpc8260sar ATM
> > device driver:
> > 
> > 	http://mpc8260sar.sourceforge.net
> 
> There is already an ads8272_defconfig in the kernel.org tree and
> AFAIK it works.  Did you add some functionality or change something?
>  Or am I missing something?
> 

I've added support for this platform to the ATM driver.
                                     ^^^^^^^^^^^^^^^^^
Alex
