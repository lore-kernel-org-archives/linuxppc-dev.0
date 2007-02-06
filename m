Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 8085BDDE32
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Feb 2007 02:57:21 +1100 (EST)
Date: Tue, 6 Feb 2007 18:57:51 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: "Jack Ger" <m_123456_h@hotmail.com>
Subject: Re: Problem with linking customer phy with fs_enet drivers
Message-ID: <20070206185751.797fa195@vitb.ru.mvista.com>
In-Reply-To: <BAY116-F157EB542041BF42BB53FE8CD990@phx.gbl>
References: <BAY116-F157EB542041BF42BB53FE8CD990@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sun, 04 Feb 2007 15:19:41 -0800
"Jack Ger" <m_123456_h@hotmail.com> wrote:

> Hi all,
> 
> I am trying to run the customer LXT970 phy with MPC870, porting from
> MPC885.  I have the lxt phy driver installed and fs_enet driver installed 
> during
> the kernel bootup.  But during the the fs_enet_open, when trying to link
> the specific phy, it fails to find the bus_id.   Since we already know that 
> the FEC
> is working in 2.4 kernel runing the 8xx_io fec,  it must be something I have 
> done
> wrong with the fs_enet, 2 questions:
> 
It would be easier not to repeat myself to figure out the reason, and have a look 
at the patch. Mind posting it here? 

If that is a problem, send it to me and I'll try to get a few hins out...

> 1) I understood that probably I didn't activate the bus, since I am porting 
> it
> from MPC885fads_setup.c, there is something I missed.  Currently I am using
> montavista 4.0.1 which runing on kernel 2.6.10.; I noticed that the 
> mdiobus_register
> never get called.
> 
> 2) what is the right way to do the mdiobus_register to register the phy bus?
> 
> TIA for your help.
> 
> A Jones
> 
> _________________________________________________________________
> Laugh, share and connect with Windows Live Messenger 
> http://clk.atdmt.com/MSN/go/msnnkwme0020000001msn/direct/01/?href=http://imagine-msn.com/messenger/launch80/default.aspx?locale=en-us&source=hmtagline
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


-- 
Sincerely, 
Vitaly
