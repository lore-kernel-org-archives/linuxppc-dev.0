Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 017DC679E6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 May 2006 20:09:20 +1000 (EST)
To: "tony" <hangtoo@163.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: how to mount /dev/ram0 to / 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 12 May 2006 17:43:59 +0800."
	<44645CBD.00AAC3.19405>
Date: Fri, 12 May 2006 12:09:17 +0200
Sender: wd@denx.de
Message-Id: <20060512100917.B4FCD352B2A@atlas.denx.de>
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <44645CBD.00AAC3.19405> you wrote:
> 
> after boot up,excute df to see the mount point:
> ~ # df
> Filesystem           1k-blocks      Used Available Use% Mounted on
> ~ # 
> nothing was mounted.

Your rc scripts probably did not care to update /etc/mtag as needed.

Check what "cat /proc/mounts" gives.

> the fatab in /etc is like this:
> /dev/ram0               /               ext2    defaults        1 1
> none                    /proc           proc    defaults        0 0
> 
> anything wrong?

Probably no part of your rc scripts did anything with the information
in /etc/fstab ...

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Perl itself is  usually  pretty  good  about  telling  you  what  you
shouldn't do. :-)     - Larry Wall in <11091@jpl-devvax.JPL.NASA.GOV>
