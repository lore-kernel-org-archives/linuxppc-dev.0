Return-Path: <glikely@gmail.com>
Received: from qproxy.gmail.com (qproxy.gmail.com [72.14.204.195])
	by ozlabs.org (Postfix) with ESMTP id 3A90A6838F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Sep 2005 02:54:41 +1000 (EST)
Received: by qproxy.gmail.com with SMTP id q12so24580qba
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Sep 2005 09:54:40 -0700 (PDT)
Message-ID: <528646bc05092309543d4e2c2f@mail.gmail.com>
Date: Fri, 23 Sep 2005 10:54:40 -0600
From: Grant Likely <glikely@gmail.com>
To: bennett78@digis.net, linuxppc-embedded <linuxppc-embedded@ozlabs.org>
In-Reply-To: <528646bc0509230933251d6600@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <43335991.1040004@digis.net>
	<528646bc0509230933251d6600@mail.gmail.com>
Subject: Re: SPI bus master driver for the Freescale MPC52xx
Reply-To: Grant Likely <glikely@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Bah!  Your reply-to: address is broken.  Check your email client.

let me try that again...

On 9/23/05, Grant Likely <glikely@gmail.com> wrote:
> Hi.
>
> First off, I've included the linuxppc-embedded mailing list in my
> reply.  It's better to mail the list and CC: me rather than just
> mailing me.  There are many others far brighter than me on the list
> who can provide far more help.
>
> On 9/22/05, Frank Bennett <bennett78@digis.net> wrote:
> >  Gary:
> My name is Grant
>
> >
> >  I saw your patch on http://patchwork.ozlabs.org/linuxppc
> >  I'm developing a SPI driver for the Lite5200.
> Are you using a PSC or the SPI peripheral?  The driver I've written is fo=
r a PSC
> >
> >  What distribution of Linux is this for?
> Any distro you want.  It should apply cleanly against any recent 2.6.x ke=
rnel
>
> >  What is this patch registry all about?
> Are you refering to the bit about device drivers registering to the
> SPI subsystem?  If so, the first patch provides the generic SPI
> infrastructure.  Device drivers for SPI masters and SPI slaves
> register to the SPI subsystem.  That way SPI master device drivers are
> decoupled from SPI slave device drivers.  It follows the new device
> model in the 2.6.x kernels.  (See "Linux Device Drivers" book from
> O'reilly for details.
>
> >  Can I get a snapshot of the mpc52xx driver stuff?
> I've made no changes since posting the patch.
>
> Eventually I'll have a public git tree with all my changes posted in
> it; but not yet.
>
> >  How can I contribute to this effort?
> Write code, write documentation and post patches.  Also, look in the
> LKML archives.  There are two other competing SPI implementations that
> are being developed.  I've been pulled off onto other work so I've not
> done any additional work.  The other code looks more promising.
>
> That being said, my code works for me so it may be usable for you as-is.
>
> cheers,
> g.
>
