Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 268D4B7C2E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  3 Nov 2009 18:33:23 +1100 (EST)
To: Jignesh Patel <jignesh.patel@onrampwireless.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: enabling USB Host controller on ppc405ex based board
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <D7C6597E47CDAD4BA48EE3D2B03B385102E7C3CE9D@VMBX113.ihostexchange.net>
References: <D7C6597E47CDAD4BA48EE3D2B03B385102E7C3CE9D@VMBX113.ihostexchange.net>
Date: Tue, 03 Nov 2009 08:33:18 +0100
Message-Id: <20091103073318.8FDEA3F6EC@gemini.denx.de>
Cc: Mukunda Saddi <mukunda.saddi@onrampwireless.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	eldk@lists.denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Jignesh Patel,

please do not post the same messages several times to several mailing
lists.

In message <D7C6597E47CDAD4BA48EE3D2B03B385102E7C3CE9D@VMBX113.ihostexchange.net> you wrote:
> 
> We have Kilauea based board using ppc405ex. & it has usb-otg
> tranciever chip on it.
> 
> I am trying to enable USB Host Controller Driver in linux kernel
> (version DENX 2.6.27-stable). For this to be enabled, I also have to

Please note that the Synopsys USB driver in our  tree  has  not  been
maintained  for  a long time. Over time, it detoriated. Only recently
we have put some more efforts into it to at least make it work again.
It still is in a pretty poor state, which is the main reason we never
attempted to push this upstream.  [In  my  opinion  it  needs  to  be
rewritten from scratch.]

For the relevant changes please see for example
http://git.denx.de/?p=linux-2.6-denx.git;a=commit;h=126bae384eacef18bcae302024d49e25a06cb648

> My questions are:
> 1. Why is PCI config required for USB Host Controller options to be enabled in kernel config?
> 2. What needs to be done to boot our board with PCI & USB enabled kernel?

Please use a more recent kernel version - either use top of tree from
the master branch of our repository, or a recent version from our
2.6.30.y or 2.6.31.y stable branches, i. e at least DENX-v2.6.30.3 or
DENX-v2.6.31.4


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Conceptual integrity in turn dictates that the  design  must  proceed
from  one  mind,  or  from  a  very small number of agreeing resonant
minds.               - Frederick Brooks Jr., "The Mythical Man Month"
