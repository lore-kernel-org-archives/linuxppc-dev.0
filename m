Return-Path: <joakim.tjernlund@transmode.se>
Received: from mail.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id DB440DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Sep 2008 18:15:31 +1000 (EST)
Subject: RE: [PATCH] usb: add Freescale QE/CPM USB peripheral controllerdriver
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Li Yang-R58472 <LeoLi@freescale.com>
In-Reply-To: <0C69E0CDED15E4469A445DE244C1B9F708CEE6@zch01exm26.fsl.freescale.net>
References: <1219916613-28827-1-git-send-email-leoli@freescale.com>
	<20080901171106.GA13447@oksana.dev.rtsoft.ru>
	<2a27d3730809020035o52d1feepcde60516c607dac6@mail.gmail.com>
	<1220342239.7762.14.camel@gentoo-jocke.transmode.se>
	<0C69E0CDED15E4469A445DE244C1B9F708CEE6@zch01exm26.fsl.freescale.net>
Content-Type: text/plain
Date: Tue, 02 Sep 2008 10:15:29 +0200
Message-Id: <1220343329.7762.23.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: dbrownell@users.sourceforge.net, greg@kroah.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-09-02 at 16:12 +0800, Li Yang-R58472 wrote:
> > -----Original Message-----
> > From: Joakim Tjernlund [mailto:joakim.tjernlund@transmode.se] 
> > Sent: Tuesday, September 02, 2008 3:57 PM
> > To: Li Yang-R58472
> > Cc: avorontsov@ru.mvista.com; greg@kroah.com; 
> > linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org; 
> > dbrownell@users.sourceforge.net; linuxppc-dev@ozlabs.org
> > Subject: Re: [PATCH] usb: add Freescale QE/CPM USB peripheral 
> > controllerdriver
> > 
> > On Tue, 2008-09-02 at 15:35 +0800, Li Yang wrote:
> > > On Tue, Sep 2, 2008 at 1:11 AM, Anton Vorontsov 
> > > <avorontsov@ru.mvista.com> wrote:
> > > > On Thu, Aug 28, 2008 at 05:43:33PM +0800, Li Yang wrote:
> > > >> Some of Freescale SoC chips have a QE or CPM co-processor which 
> > > >> supports full speed USB.  The driver adds device mode support of 
> > > >> both QE and CPM USB controller to Linux USB gadget.  The 
> > driver is 
> > > >> tested with MPC8360 and MPC8272, and should work with 
> > other models 
> > > >> having QE/CPM given minor tweaks.
> > > >>
> > > >> Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
> > > >> Signed-off-by: Li Yang <leoli@freescale.com>
> > > >> ---
> > > >> This is the second submission of the driver.  This 
> > version addressed:
> > > >> Comments from Anton Vorontsov.
> > > >> A lot of cosmetic problem.
> > > >> Sparse and various kernel DEBUG warnings.
> > > >
> > > > Just caught this:
> > > >
> > > > g_ether gadget: high speed config #1: CDC Ethernet (ECM)
> > 
> > Does RNDIS work too? If not, is it possible to add or doesn't 
> > the HW support it?
> 
> RNDIS is a gadget(protocol) level thing.  I believe it can work with
> this driver although not tested myself.
> 
> Noted:  AFAIK, RNDIS gadget in Linux doesn't interoperate with windows
> well enough to be production level.  Use at your own risk.

I see. If one wants to connect with CDC to Windows, what drivers are
there for Windows that works well with Linux?

 Jocke 
