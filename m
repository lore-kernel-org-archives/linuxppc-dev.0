Return-Path: <w@1wt.eu>
Received: from 1wt.eu (1wt.eu [62.212.114.60])
	by ozlabs.org (Postfix) with ESMTP id 581B5B70EA
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Feb 2011 09:11:18 +1100 (EST)
Date: Mon, 7 Feb 2011 23:11:06 +0100
From: Willy Tarreau <w@1wt.eu>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 21/23] hvc_console: Fix race between hvc_close and
	hvc_remove
Message-ID: <20110207221106.GA10317@1wt.eu>
References: <4beed4da27f06efb2c13d6ed48850634@local>
	<20110206232253.421321729@pcw.home.local>
	<20110208081600.1a816af5@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110208081600.1a816af5@kryten>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	linuxppc-dev@ozlabs.org, Amit Shah <amit.shah@redhat.com>,
	stable-review@kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Anton,

On Tue, Feb 08, 2011 at 08:16:00AM +1100, Anton Blanchard wrote:
> 
> Hi,
> 
> > From: Amit Shah <amit.shah@redhat.com>
> > 
> > commit e74d098c66543d0731de62eb747ccd5b636a6f4c upstream.
> > 
> > Alan pointed out a race in the code where hvc_remove is invoked. The
> > recent virtio_console work is the first user of hvc_remove().
> 
> I faintly remember this bug caused boot issues and the following patch
> must be applied to fix it.

The patch you pointed was indeed merged just after this one so we should
be OK. Thanks very much for the double check !

Willy
