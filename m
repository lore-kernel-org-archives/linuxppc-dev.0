Return-Path: <david-b@pacbell.net>
Received: from smtp115.sbc.mail.sp1.yahoo.com (smtp115.sbc.mail.sp1.yahoo.com
	[69.147.64.88]) by ozlabs.org (Postfix) with SMTP id AD99ADDF20
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 07:42:52 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: "Joakim Tjernlund" <Joakim.Tjernlund@transmode.se>
Subject: Re: [PATCH] usb: add Freescale QE/CPM USB peripheral controllerdriver
Date: Wed, 24 Sep 2008 14:42:48 -0700
References: <1219916613-28827-1-git-send-email-leoli@freescale.com>
	<200809241328.35008.david-b@pacbell.net>
	<07ab01c91e8c$b56f6140$204e23c0$@Tjernlund@transmode.se>
In-Reply-To: <07ab01c91e8c$b56f6140$204e23c0$@Tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809241442.49240.david-b@pacbell.net>
Cc: greg@kroah.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 24 September 2008, Joakim Tjernlund wrote:
> > > I see. If one wants to connect with CDC to Windows, what drivers are
> > > there for Windows that works well with Linux?
> > 
> > I believe MCCI has some.  It also has drivers for a CDC subset,
> > pretty much the same one Linux has used forever except wrapped
> > with a few extra descriptors to make it practical to identify
> > that "SAFE" (!) subset without needing vendor and product IDs.
> 
> Thanks, had a look and it seems like I have to buy these drives. I was
> hoping to find some free ones, do you know of such free drivers?

No, sorry.  Remember MSFT is somewhat rabidly anti-Free...

However, we'd be quite happy to have someone more attuned
to MS-Windows sort out the remaining issues in the Linux
support for RNDIS.  ;)

- Dave
