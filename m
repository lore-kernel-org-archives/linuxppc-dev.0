Message-ID: <3A1AA7D3.A808331C@mvista.com>
Date: Tue, 21 Nov 2000 08:50:27 -0800
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: t.shantha.laxmi@exgate.tek.com
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: init problems with 2.4.0 kernel
References: <21F9768AF088D211BF1C0008C71E578601686C92@ap-bang-m02.india.tek.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


t.shantha.laxmi@exgate.tek.com wrote:
> It is a ppc board running linux kernel 2.4.0-test2-1.2.2-1. I have
> downloaded the kernel from the mvista site. I am using CDK1.0(again got from
> mvista) as the root filesystem. With my earlier version of the kernel
> (2.2.13), I was not facing this problem.
>
> Any help will be greatly appreciated,
> - Shantha
>

First let me say that 2.4 is still considered an unstable kernel.
Montavista only supports the 2.4 kernel for a couple of arch that are
only in 2.4.  If you are looking to upgrade your kernel for a product
release, stick with 2.2.14. otherwise, always use the latest 2.4 kernel
and expect something to be broken.


Matthew Locke
Montavista Software

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
