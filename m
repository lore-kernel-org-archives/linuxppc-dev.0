Return-Path: <greg@kroah.com>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DB5D1DDDFF
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2007 18:27:58 +1000 (EST)
Date: Mon, 25 Jun 2007 00:30:42 -0700
From: Greg KH <greg@kroah.com>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch] PS3: Fix USB return value
Message-ID: <20070625073042.GA24605@kroah.com>
References: <20070606024407.786638029@am.sony.com>>
	<46662443.9020905@am.sony.com> <4669E4BD.7060002@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4669E4BD.7060002@am.sony.com>
Cc: owen@stampflee.com, gregkh@suse.de, Paul Mackerras <paulus@samba.org>,
	linux-usb-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jun 08, 2007 at 04:22:37PM -0700, Geoff Levand wrote:
> Fix a minor error on the return value of ps3_ehci_driver_register()
> and ps3_ohci_driver_register() when running on non-PS3 systems.
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> ---
> Hi Greg,
> 
> Testers found a problem with my latest PS3 USB patch.  Please
> add it in.

I've merged this with your previous one so that no one hits the bug when
doing a 'git bisect'.

thanks,

greg k-h
