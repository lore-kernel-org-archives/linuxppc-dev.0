Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 3AFD767A41
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Mar 2006 07:11:30 +1100 (EST)
To: linuxppc-embedded@ozlabs.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Kernel for MPC Lite 5200 will not compile 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 29 Mar 2006 17:39:41 +0200."
	<20060329153941.GD95498@server.idefix.loc>
Date: Wed, 29 Mar 2006 22:11:28 +0200
Sender: wd@denx.de
Message-Id: <20060329201128.2FB713535EE@atlas.denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Matthias,

in message <20060329153941.GD95498@server.idefix.loc> you wrote:
> 
> i tried the following trees:
> linux-2.6.15 (from kernel.org)
> linux-2.6-denx (from cg-clone http://www.denx.de/git/<project_name>)

MPC5200 support known to be broken in these two.

> linux-2.6-denx-git (see above)

Does not exist...

> linuxppc_2_4_mpc5200 (see above)

Is NOT a git repository and marked as obsolete.

The only stable tree we offer  for  5200  is  the  linuxppc_2_4_devel
tree.

> > > I copied the file arch/ppc/configs/lite5200_defconfig to .config, and
> > > tried the following one:
> > > make ARCH=ppc CROSS_COMPILE=ppc_6xx- uImage
> > 
> > That's not the official way to build images.
> 
> oh, sry I played with crosscompiling the firt time, it would be a
> pleasure for me if you could correct me.

Read the README, and probably the DULG. You missed at leat the  "make
oldconfig" step which is essential.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Blast medicine anyway!  We've learned to tie into every organ in the
human body but one.  The brain!  The brain is what life is all about.
	-- McCoy, "The Menagerie", stardate 3012.4
