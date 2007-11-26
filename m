Return-Path: <timur@freescale.com>
Message-ID: <474AEB6A.40408@freescale.com>
Date: Mon, 26 Nov 2007 09:51:06 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>, Jon Smirl <jonsmirl@gmail.com>,
	PowerPC dev list <Linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>
Subject: Re: Revisited, audio codec device tree entries.
References: <9e4733910711181010q50c08d2ek8413af74d58cf0ce@mail.gmail.com>
	<4741A56D.9050808@freescale.com>
	<fa686aa40711190733vd1ffac0k62bf32186eb57aff@mail.gmail.com>
	<9e4733910711190800t5dc9bc40q1b58feae4ff364d0@mail.gmail.com>
	<fa686aa40711190831s2e59ab05h63d10ec8a24eaad5@mail.gmail.com>
	<9e4733910711190851g3e1f2ef9k5f87c7c2dae929ef@mail.gmail.com>
	<fa686aa40711190933r3cbeb51bw7b9073a40f8396ed@mail.gmail.com>
	<9e4733910711191120l45d9257bwf4ccf8c7365393d0@mail.gmail.com>
	<fa686aa40711191128i59245403g3e15e3b6c545b6ee@mail.gmail.com>
	<20071120005941.GC3126@localhost.localdomain>
In-Reply-To: <20071120005941.GC3126@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:

> 	1) We have a "universal" device-tree-based fabric driver which
> parses all the above-described interconnection information in the
> device tree and handles any situation.  Cool, but probably a lot of
> work and fiddly to get right.

Definitely a lot of work.  I suggest we wait until there are a few PowerPC ASOC 
v2 audio drivers in the kernel before we even consider this.  And it may not 
even be possible.  I can easily imagine situations where we need board-specific 
code that belongs in a machine-specific fabric driver.

-- 
Timur Tabi
Linux kernel developer at Freescale
