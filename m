Return-Path: <wd@denx.de>
Received: from mailout06.sul.t-online.com (mailout06.sul.t-online.com
	[194.25.134.19]) by ozlabs.org (Postfix) with ESMTP id 5F1146863E
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Oct 2005 04:30:01 +1000 (EST)
To: Kumar Gala <kumar.gala@freescale.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 24 Oct 2005 10:20:24 CDT."
	<398F469F-357E-445D-B48E-59899230E001@freescale.com>
Date: Mon, 24 Oct 2005 20:29:48 +0200
Sender: wd@denx.de
Message-Id: <20051024182948.BA8D3353444@atlas.denx.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Add PCI support for TQM834x Boards 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Kumar,

in message <398F469F-357E-445D-B48E-59899230E001@freescale.com> you wrote:
>
> * The comment in mpc83xx_setup_hose() may not be 100% correct (see  
> inline)

It probably needs more explanation.

> * Updating of pci_ids.h should be done via http:// 
> pciids.sourceforge.net/.  I can handle doing this for 834x if you  
> want me to.

I'd appreciate if you could handle it this time. I will  remeber  how
to do it correctly from now on. Thanks.

...
> > +#ifdef CONFIG_TQM834x
> 
> Is the following comment 100% correct?  I'm not sure I follow the  
> STK85xx reference.
> 
> > +    /*
> > +     * WARNING! only PCI_CLK_OUTPUT1 is enabled for the TQM834x as this is
> > +     * the one line actually used for clocking all external PCI devices in
> > +     * current setup of the STK85xx.  Enabling other PCI_CLK_OUTPUT lines

This is correct. TQ uses the same eval  board  for  all  TQM83xx  and
TQM85xx  modules.  It  was originally developed for the TQM85xx so it
got named STK85xx (STarter Kit 85xx). Later,  it  was  impossible  to
reflect  the  use for the TQM83xx in the name of the eval board. Yes,
this is confusing...

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Have you lived in this village all your life?"        "No, not yet."
