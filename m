Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp1.wanadoo.fr (smtp1.wanadoo.fr [193.252.22.30])
	by ozlabs.org (Postfix) with ESMTP id D18A92BDB5
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Dec 2004 20:46:05 +1100 (EST)
Date: Fri, 31 Dec 2004 10:53:10 +0100
To: mikemartin@linux.ca, linuxppc-dev@ozlabs.org
Message-ID: <20041231095310.GA16214@pegasos>
References: <855e88d00412291051792d3daa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <855e88d00412291051792d3daa@mail.gmail.com>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: debian-powerpc@lists.debian.org, debian-kernel@lists.debian.org
Subject: Re: 43p-140 install issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 29, 2004 at 01:51:51PM -0500, Mike Martin wrote:
> I have a 43p-140, It will netboot, start the installer and let be run
> through the motions. It doesn't seem to be able to recognize the cdrom
> or be able to set up the network. This puts a stop on the installation
> pretty quickly. I can't seem to figure it out on my own. Can anyone
> help?
> 
> Attached is a console capture from my latest boot using the Dec. 28th
> image from:
> http://people.debian.org/~luther/debian-installer/daily-powerpc-built/daily/powerpc/netboot/
> 
> Other images are similar.

Could you try to get the /var/log/syslog and /var/log/messages out of that box
? 

> When the installer gets to configuring the network with DHCP, it
> fails. "tcpdump" on the server interface shows no traffic after the
> tftp image is transfered.

Mmm, could this be similar to : 

  http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=283329

I am trying the install on a motorola powerstack (utah board), which has a
decchip (de4x5) ethernet, and things are worse, the machine freezes when
trying to ifup the interface :

  http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=287933

I get some strange feeling that something is seriously wrong with the 2.6
kernels on prep hardware. Let me CC this to linuxppc-dev mailing lists too. 

I will not have time to look into this problem before next year though :), and
probably not before a week or so at that.

Friendly,

Sven Luther
