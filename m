Return-Path: <greg@kroah.com>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BA9411007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  9 Jul 2011 08:30:18 +1000 (EST)
Date: Fri, 8 Jul 2011 15:29:51 -0700
From: Greg KH <greg@kroah.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: tty/powerpc: introduce the ePAPR embedded hypervisor byte
	channel driver
Message-ID: <20110708222951.GA27363@kroah.com>
References: <1305830092-20104-1-git-send-email-timur@freescale.com>
	<20110708220654.GA19146@kroah.com> <4E178193.2090905@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E178193.2090905@freescale.com>
Cc: arnd@arndb.de, kumar.gala@freescale.com, linux-kernel@vger.kernel.org,
	akpm@kernel.org, linux-console@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 08, 2011 at 05:15:47PM -0500, Timur Tabi wrote:
> Greg KH wrote:
> > Doesn't apply at all to the tty-next tree, so I can't apply it here :(
> 
> Um, where exactly is the tty-next tree?  The only thing I see that looks like it
> is this:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty-2.6.git
> 
> But the description of this tree says, "junk tree, please ignore".

Don't ignore it, that's the one :)
