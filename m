Return-Path: <ron_madrid@sbcglobal.net>
Received: from web83511.mail.sp1.yahoo.com (web83511.mail.sp1.yahoo.com
	[216.252.120.167]) by ozlabs.org (Postfix) with SMTP id 07C21DDF9B
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 06:26:17 +1000 (EST)
Date: Tue, 27 May 2008 13:26:16 -0700 (PDT)
From: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: JFFS2 FS not writeable
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <483C4DF6.8060006@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <850932.26140.qm@web83511.mail.sp1.yahoo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In which function should I start searching for this
problem?  What would cause a block to be marked bad?

Ron
--- Scott Wood <scottwood@freescale.com> wrote:

> Ron Madrid wrote:
> > I have tried the latest code and now, I'm able to
> > write a limited amount.  After which when I
> reboot,
> > more than 100 contiguous blocks have been marked
> bad,
> > through the end of the device (according to the
> dts). 
> > Is this something that has been seen before?
> 
> Yes, but not with the latest code.
> 
>  > My NAND device is a large page.
> 
> I've only had small page devices to test on, so it's
> quite likely that 
> there's a large page bug in the driver somewhere.
> 
> If your erase block size is not 128K, try the latest
> set_addr patch in 
> the mtd-2.6.22.1 branch of u-boot-nand-flash (I
> still need to send it 
> out for Linux).
> 
> -Scott
> 
