Return-Path: <david-b@pacbell.net>
Received: from smtp107.sbc.mail.mud.yahoo.com (smtp107.sbc.mail.mud.yahoo.com
	[68.142.198.206]) by ozlabs.org (Postfix) with SMTP id 0DF4567B5A
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Aug 2006 02:21:26 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] Fix Freescale high-speed USB
	hostdependency
Date: Tue, 1 Aug 2006 08:38:07 -0700
References: <4879B0C6C249214CBE7AB04453F84E4D07064D@zch01exm20.fsl.freescale.net>
	<93F26879-ECEB-4513-AA77-EE7285DF7961@kernel.crashing.org>
In-Reply-To: <93F26879-ECEB-4513-AA77-EE7285DF7961@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200608010838.08139.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, gregkh@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 20 July 2006 5:59 am, Kumar Gala wrote:

> >
> > -#ifdef CONFIG_PPC_83xx
> > +#ifdef CONFIG_MPC834x

So at the end of all that discussion, was there a USB patch to merge?
If so, I don't see one in my mail folder.
