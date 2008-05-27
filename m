Return-Path: <ron_madrid@sbcglobal.net>
Received: from web83508.mail.sp1.yahoo.com (web83508.mail.sp1.yahoo.com
	[216.252.120.164]) by ozlabs.org (Postfix) with SMTP id C45FCDE328
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 04:04:03 +1000 (EST)
Date: Tue, 27 May 2008 11:03:56 -0700 (PDT)
From: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: JFFS2 FS not writeable
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <4835E295.3080801@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <661239.31265.qm@web83508.mail.sp1.yahoo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have tried the latest code and now, I'm able to
write a limited amount.  After which when I reboot,
more than 100 contiguous blocks have been marked bad,
through the end of the device (according to the dts). 
Is this something that has been seen before?  My NAND
device is a large page.

Ron
--- Scott Wood <scottwood@freescale.com> wrote:

> Ron Madrid wrote:
> > I'm trying to make new directories, create files,
> save
> > changes to files, etc. and when I reboot my
> changes
> > are not being saved.  I'm sorry if this is vague,
> but
> > I haven't run into this problem before in previous
> > kernels.  I'm using 2.6.25 and my configuration is
> > very similar to mpc8313erdb_defconfig, with
> changes to
> > include NAND support as my flash device is a NAND.
> 
> > Also, my dts is very similar to mpc8313erdb.dts as
> > well.  I don't know where to start looking for the
> > problem as there is no error.  Here is what is
> printed
> > on boot.
> 
> Try head-of-tree; there have been several fixes to
> the eLBC FCM NAND driver.
> 
> -Scott
> 
