Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id B29CC68901
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Jan 2006 02:57:43 +1100 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 2 Jan 2006 16:57:34 +0100
References: <000701c60fab$9fdca6a0$0760120a@photon>
In-Reply-To: <000701c60fab$9fdca6a0$0760120a@photon>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="big5"
Message-Id: <200601021657.35359.david.jander@protonic.nl>
Cc: HappyPhot <happyphot@gmail.com>
Subject: Re: VFS: Cannot open root device "31:03" or unknown-block(31,3)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Monday 02 January 2006 15:48, HappyPhot wrote:
> Hi,
>   I've suffered for many days and "google" almost every where.
> I would like to boot from the flash with jffs2 (i.e. using jffs2 as my
> root /) . But it alyaws shows:
> VFS: Cannot open root device..... (whole message is as below)
>
>   Anybody knows what may cause this ? Please help and
> thank you.
>[...]

You omitted the interesting part of the log output, the bootarguments at the 
very beginning. What is the value of root= ?
Maybe you made the typical mistake of specifying /dev/mtd3 instead 
of /dev/mtdblock3, or you didn't compile in support for mtd access as a block 
device?

Greetings,

-- 
David Jander
