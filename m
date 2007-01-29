Return-Path: <efault@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id A4CE9DDE06
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 18:08:27 +1100 (EST)
Subject: Re: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
From: Mike Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20070128224834.37482553.akpm@osdl.org>
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>
	<20070127174230.GN6017@stusta.de> <20070128133344.214070@gmx.net>
	<1170051963.6454.7.camel@Homer.simpson.net>
	<20070128224834.37482553.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 29 Jan 2007 08:08:15 +0100
Message-Id: <1170054495.6521.1.camel@Homer.simpson.net>
Mime-Version: 1.0
Cc: nickpiggin@yahoo.com.au, linux-ide@vger.kernel.org, petero2@telia.com,
	linux-kernel@vger.kernel.org, livio@eecg.toronto.edu,
	Adrian Bunk <bunk@stusta.de>, B.Zolnierkiewicz@elka.pw.edu.pl,
	linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org,
	gd@spherenet.de, cijoml@volny.cz, ttb@tentacle.dhs.org,
	rml@novell.com, Uwe Bugla <uwe.bugla@gmx.de>,
	torvalds@linux-foundation.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-01-28 at 22:48 -0800, Andrew Morton wrote:
> On Mon, 29 Jan 2007 07:26:03 +0100
> Mike Galbraith <efault@gmx.de> wrote:
> 
> > FWIW, I just tried it with 2.6.20-rc6, and can confirm.  Once nero is
> > run, the kernel never gives up retrying whatever command failed, so I
> > get...
> > 
> > [ 4362.972995] hdd: status error: status=0x58 { DriveReady SeekComplete
> > DataRequest }
> > [ 4362.981475] ide: failed opcode was: unknown
> > [ 4362.986183] hdd: drive not ready for command
> > 
> > endlessly.
> 
> Do you have time to bisect it?

Unfortunately, I'm git impaired.  I am rummaging as we speak though.

	-Mike
