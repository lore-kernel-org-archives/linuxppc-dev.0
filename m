Mime-Version: 1.0
Message-Id: <p05101000b7d57a2c5308@[10.0.0.42]>
In-Reply-To: <20010924150437.I14835@plato.local.lan>
References: <20010923221839.G14835@plato.local.lan>
 <Pine.NEB.4.33.0109241732420.19824-100000@vex.net>
 <20010924150437.I14835@plato.local.lan>
Date: Mon, 24 Sep 2001 17:04:16 -0700
To: linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: More problems with Kernel 2.4.10-pre12 and mounting
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 3:04 PM -0800 9/24/01, Ethan Benson wrote:

>>  Perhaps it is pdisk that doesn't like the new kernel.
>
>i don't really see how.. its not doing much more then reading the
>first 32k of of the disk to parse the partition table.

Actually, I think the LinuxPPC 2000 Q4 version of pdisk does have a
problem with reading block 0 on 2.4.x kernels.  I remember having
that problem.  Doesn't happen with the pdisk from YDL 2.0.
--
Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
