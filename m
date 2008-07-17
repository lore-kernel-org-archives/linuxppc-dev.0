Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id 5D52CDE1DB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jul 2008 01:27:59 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KJVOZ-0005Q2-RH
	for linuxppc-embedded@ozlabs.org; Thu, 17 Jul 2008 15:27:51 +0000
Received: from p5497d67a.dip.t-dialin.net ([84.151.214.122])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 17 Jul 2008 15:27:51 +0000
Received: from dzu by p5497d67a.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 17 Jul 2008 15:27:51 +0000
To: linuxppc-embedded@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: Videomode 800x480
Date: Thu, 17 Jul 2008 17:26:01 +0200
Message-ID: <m24p6o352u.fsf@ohwell.denx.de>
References: <18470632.post@talk.nabble.com> <487CEC85.2070801@denx.de>
	<18482586.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Alex,

> Hello, the physical settings for sync are made by U-Boot and working!
> But in Lunux when I use 800x480, the screen is well, but the Kernel crashes
> at Bootup!
> Using 800x600 works!
> Now I need only "Dummy" settings, that I can tell Linux I would like 800x480
> and the Kernel doesn`t crash!
> I don`t know exactly why the Kernel crashes, I know only that the modedB
> 800x600 and so on work!
> I will try your settings immediately!

Your keymap seems to be broken.  Try to include this in your ~/.Xmodmap
file:

keycode  10 = 1 period

Cheers
  Detlev

-- 
error compiling committee.c: too many arguments to function
