Subject: Re: iBook G4 LCD backlight misbehaviours
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: Roland Riegel <roland.riegel.maillist@gmx.de>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <200401030014.07254.roland.riegel.maillist@gmx.de>
References: <200401030014.07254.roland.riegel.maillist@gmx.de>
Content-Type: text/plain
Message-Id: <1073087414.10543.9.camel@gaston>
Mime-Version: 1.0
Date: Sat, 03 Jan 2004 10:50:14 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2004-01-03 at 10:15, Roland Riegel wrote:
> Hi everybody!
>
> Recently I bought an iBook G4 and installed Linux on it. I am using
> linux-2.4.23-ben1 and have the following problem:
>
> When configured with CONFIG_PMAC_BACKLIGHT=y, on startup the screen switches
> completely off (it took me some time to notice that the kernel does not crash
> but only the screen turns dark and the system keeps booting).

This machine isn't currently fully supported by 2.4.23 kernels, you will
have better success using my current 2.6.1-rc1 tree

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
