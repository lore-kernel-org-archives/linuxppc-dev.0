Return-Path: <skepper@chara.vm.bytemark.co.uk>
Received: from chara.vm.bytemark.co.uk (chara.vm.bytemark.co.uk [80.68.89.253])
	by ozlabs.org (Postfix) with ESMTP id 5BC85DDE1D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Oct 2008 22:53:03 +1100 (EST)
Date: Tue, 28 Oct 2008 11:36:19 +0000 (GMT)
From: Chris Skepper <skepper@ukf.net>
To: florent manni <mannivelle@gmail.com>
Subject: Re: linux automatic logging and automatic script execution
In-Reply-To: <f451b120810280106n3c495202i87878008d4102833@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0810281124310.9397@chara.vm.bytemark.co.uk>
References: <f451b120810280106n3c495202i87878008d4102833@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: Chris Skepper <skepper@chara.vm.bytemark.co.uk>
Cc: linuxppc-embedded@ozlabs.org
Reply-To: skepper@ukf.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 28 Oct 2008, florent manni wrote:

> I try to make my embedded linux auto-logging and auto-executing a program
> after kernel loads thus I haven't got to use the terminal to logging and
> start my embedded program.
>
> does anyone has got a clue where I should look to set this option (I think
> it might be around /etc/initrd but I'm not sure).

Hi Florent,

You might be thinking of the file /etc/inittab or /etc/init.d/.  These 
file(s) control what process are started by /sbin/init in different 
run-levels.  Look at "man init" on a Linux system for more info, or read 
the documentation for the version of init on the system.  That should 
enable you to start whatever you want on bootup.

If init is too heavyweight you can start any other application with the 
the init= kernel parameter, but that's probably not recommended unless you 
know what you are doing.

Chris.
