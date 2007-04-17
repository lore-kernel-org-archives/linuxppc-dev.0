Return-Path: <laurent.pinchart@technotrade.biz>
Received: from outmx006.isp.belgacom.be (outmx006.isp.belgacom.be
	[195.238.4.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A6B9FDDEC9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Apr 2007 20:29:16 +1000 (EST)
Received: from outmx006.isp.belgacom.be (localhost [127.0.0.1])
	by outmx006.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l3HAT2UK005928
	for <linuxppc-embedded@ozlabs.org>; Tue, 17 Apr 2007 12:29:02 +0200
	(envelope-from <laurent.pinchart@technotrade.biz>)
From: Laurent Pinchart <laurent.pinchart@technotrade.biz>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Problem cloning Linus' GIT tree!
Date: Tue, 17 Apr 2007 12:28:56 +0200
References: <18A49CF3586FC14290887ECC63C9141F0104D042@exchange2003.dspace.de>
In-Reply-To: <18A49CF3586FC14290887ECC63C9141F0104D042@exchange2003.dspace.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200704171228.56848.laurent.pinchart@technotrade.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Gerald,

> stupid newbie question:
>
> I'm trying to get Grant Likelys latest TEMAC driver from his git-tree.
> Follwing the directions on the secretlab.ca website I start by cloning
> Linus' tree.  Since I'm behind a firewall which blocks the git port I use:
>
>    git clone
> http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>
> At first everything is fine and git happily seems to download the tree.
> After a while however, git exits with the following error message:
>
>    error: Couldn't get
> http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/
>tags/v2.6.11 for tags/v2.6.11 The requested URL returned error: 404
>    error: Could not interpret tags/v2.6.11 as something to pull
>    rm: cannot remove directory
> `/cygdrive/c/home/git/linux-2.6/.git/clone-tmp': Directory not empty
>
> Any hint what I did wrong?

Try upgrading git to the last version.

Best regards,

Laurent Pinchart
