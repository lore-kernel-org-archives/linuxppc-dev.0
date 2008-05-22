Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 69F01DE08A
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 07:15:05 +1000 (EST)
Message-ID: <4835E295.3080801@freescale.com>
Date: Thu, 22 May 2008 16:16:05 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: JFFS2 FS not writeable
References: <606394.37977.qm@web83507.mail.sp1.yahoo.com>
In-Reply-To: <606394.37977.qm@web83507.mail.sp1.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ron Madrid wrote:
> I'm trying to make new directories, create files, save
> changes to files, etc. and when I reboot my changes
> are not being saved.  I'm sorry if this is vague, but
> I haven't run into this problem before in previous
> kernels.  I'm using 2.6.25 and my configuration is
> very similar to mpc8313erdb_defconfig, with changes to
> include NAND support as my flash device is a NAND. 
> Also, my dts is very similar to mpc8313erdb.dts as
> well.  I don't know where to start looking for the
> problem as there is no error.  Here is what is printed
> on boot.

Try head-of-tree; there have been several fixes to the eLBC FCM NAND driver.

-Scott
