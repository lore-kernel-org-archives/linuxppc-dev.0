Return-Path: <wd@denx.de>
Received: from mailout06.sul.t-online.com (mailout06.sul.t-online.com
	[194.25.134.19]) by ozlabs.org (Postfix) with ESMTP id 4C8CD67A64
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Feb 2005 22:43:08 +1100 (EST)
To: srinivas.surabhi@wipro.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 17 Feb 2005 10:50:06 +0530."
	<EF9B29C78F41FA488927FCBC7750AF0E08DA14@hyd-mdp-msg.wipro.com>
Date: Thu, 17 Feb 2005 12:42:54 +0100
Sender: wd@denx.de
Message-Id: <20050217114259.B974DC1430@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Mounta Vista Linux prompt on serial console 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <EF9B29C78F41FA488927FCBC7750AF0E08DA14@hyd-mdp-msg.wipro.com> you wrote:
> 
> But the problem is that it was stopping at
> 
> "No init found.  Try passing init= option to kernel". Before that there
>  were no errors. Everthing looks fine Mounted VFS root file system was also

Fine. So you can mount the root filesystem, but it obviously does not
contain all the required files.

>  seen. From the net I understood is that the fstab file was the cause. So
>  edited the filesytem parameter for / as /dev/ram earlier it used to be
>  /dev/root.

No. /etc/fstab has absolutley nothing to do with  your  problem.  The
kernel  cannot  start  the  init  porocess - make sure init is in the
filesystem, plus all required libraries.

> So please tell me whether the given fstab file will suffice? The filesystem

This is completley unrelated.

> 2. I have one more doubt /sbin/init utility comes with what package?
>  Because in /sbin directory although the init binary is present, not shown
>  in the file system heirarchy view. For eg. if I select DHCPD package then
>  able to see dhcpd related binary in the /sbin similarly my question was
>  which package has to be selected to have init included.

Please contact MV support. I have no  idea  how  they  package  their
distribution,  or  how  their  config  tools might work. You paid for
their stuff, so ask _them_.

Best regards,

Wolfgang Denk

-- 
See us @ Embedded World, Nuremberg, Feb 22 - 24,  Hall 10.0 Booth 310
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The most exciting phrase to hear in science, the one that heralds new
discoveries, is not "Eureka!" (I found it!) but "That's funny ..."
                                                      -- Isaac Asimov
