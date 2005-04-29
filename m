Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 5E76B67A01
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Apr 2005 21:40:49 +1000 (EST)
Received: from linux.local (linux.prtnl [192.168.1.97])
	by protonic.prtnl (Postfix) with ESMTP id 1DEEE40A0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Apr 2005 13:40:59 +0200 (CEST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Fri, 29 Apr 2005 13:40:43 +0200
References: <BAY17-F312F5680735EFB466C3993BE240@phx.gbl>
In-Reply-To: <BAY17-F312F5680735EFB466C3993BE240@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200504291340.44146.david.jander@protonic.nl>
Subject: Re: porting linux on power pc mpc8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Prinson,

On Friday 29 April 2005 12:32, prinson varghese wrote:
> I am new to the embedded system development .How i can port linux kenel to
> power pc MPC 8XX

It is already ported to most known mpc8xx devices. You should start off, going 
through the archives of this mailing-list, and visit this site:
http://www.denx.de

There you can download actual sources of linux-2.4 kernels. My advice, use 
linux_2_4_devel cvs tree if you have no particular reason to use another 
tree.

What processor do you use? What board? Is it a custom design or an existing 
board?

You might be interested in u-boot also (the most commonly used bootloader for 
these kind of embedded processors).

> and where i can get the kernel for the same?

www.denx.de, but probably also from www.mvista.com, and many others.

> awaiting rpaly ASAP

I am OK with this, but "ASAP" does not sound as polite as you should be 
addressing a mailing list ;-)

Sincerely,

-- 
David Jander
Protonic Holland.
