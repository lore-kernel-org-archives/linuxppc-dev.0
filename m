Return-Path: <Jogi95@web.de>
Received: from fmmailgate04.web.de (fmmailgate04.web.de [217.72.192.242])
	by ozlabs.org (Postfix) with ESMTP id 7A2FBDDE3D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jan 2008 07:19:07 +1100 (EST)
Date: Thu, 17 Jan 2008 21:19:04 +0100
Message-Id: <540794314@web.de>
MIME-Version: 1.0
From: Joachim Meyer <Jogi95@web.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: ml310 kernel2.6 booting problems
Content-Type: text/plain; charset=iso-8859-15
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

My Linux runs finally. Thx again for the help.
But 3 Questions remain:

1. After mounting the rootfs there came an message, 
"fatal error, couldn't find modprobe in /lib/modules/2.6.24-rc3/..." or something like that.
so I changed the folder /lib/modules/2.6.19.2 to /lib/modules/2.6.24-rc3.
Is this a solution or will I get Problems with this?
Can I say ELDK that I have Kernel 2.6.24.rc3 ?
I only installed and ran the 2 scripts, like they say in the docs.

2. There came also something, that the it couldn't read the time or clock. Is it an error
or has the Board no clock?

3. I still need a network connection. Because of some special reasons
I prefer the ml310, so changing to a XUP would be the last possible solution.
Because of the Problems I had when I tried to compile the 2.4-kernel
(where the pci bridge works, I think) and can't find the proper 2.4 kernel-Version
to compile it successfully, theres only one solution, beside the XUP, left.
I need to bring up the pci bridge for the ml310.
I read at the mailing list this:
-----------------------------------------------------------------------------
I ended up using Secret Lab's GIT tree as my source archive, so I'll
let you know if I need to fix some code.

> You'll have to go back into the mailing list archives to find a patch
> for adding PCI support for a Virtex platform.  I don't have any of
> that in my tree.  It probably only exists for the 2.4 kernel.  You'll
> need to port forward to use it on 2.6 (I'm more than willing to help
> you with this)

Hmmm... I'm not really ready to invest that much time into the PCI for ML-310.
--------------------------------------------------------------------------------
http://ozlabs.org/pipermail/linuxppc-embedded/2007-December/029211.html

How much work would it be (approximated), and do you think I can success (I'm a novice, like you know)?
Would you help me (Tell me where to start & what to do)?


Anyway I ,once more, wanna thank you, I wouldn't come so far, in that time without your help.
Greez
Joachim
_____________________________________________________________________
Der WEB.DE SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
http://smartsurfer.web.de/?mc=100071&distributionid=000000000066
