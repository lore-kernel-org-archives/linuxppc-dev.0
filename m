Return-Path: <adrian@it-live.co.uk>
Received: from ns1.it-live.co.uk (ns1.it-live.co.uk [195.10.233.36])
	by ozlabs.org (Postfix) with ESMTP id 12C2667BB6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Oct 2006 02:26:42 +1000 (EST)
Received: from adrianlaptop (63.Red-83-37-241.dynamicIP.rima-tde.net
	[83.37.241.63])
	by ns1.it-live.co.uk (8.13.6/8.13.3) with SMTP id k9BFQdGv024214
	for <linuxppc-embedded@ozlabs.org>; Wed, 11 Oct 2006 15:26:44 GMT
Message-ID: <010001c6ed49$aa8ab390$3a0da8c0@adrianlaptop>
From: "Adrian" <adrian@it-live.co.uk>
To: <linuxppc-embedded@ozlabs.org>
Subject: PPChameleonEVB Newbie question
Date: Wed, 11 Oct 2006 17:24:34 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Reply-To: Adrian <adrian@it-live.co.uk>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Folks.

I'm a newbie to embedded and am getting stuck.

I have a PPChameleonEVB board running a 405EP processor.

I have tried many things, and can now boot Linux 2.6.15 on the board using 
an NFS share as both root fs and swap.

When I try to compile & install the kernel modules on the board, i get an 
message about perl and then it errors.

So i'm trying to install perl. And failing.

Can someone tell me the following please, from a working setup (i.e. where 
you can compile/install kernel 2.6.15 + modules) :-

1) Kernel version/Linux distroof the i386 PC used for the cross-compiling.
2) ELDK version and if there are any patches needed.
2) Perl version (or how to stop the Kernel build using perl)

I'm using Slack 8.1, kernel 2.4.18 and perl 5.6.1 on the cross-compiler pc. 
Anything newer fell apart a lot earlier.

Many thanks in advance.

Adrian Atkins
IT Live Limited

tel: 0161 408 3327
fax: 08702 360 443
skype: adrianitlive
ES mob: (0034) 606806236 
