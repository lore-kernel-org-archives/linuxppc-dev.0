Date: Tue, 5 Nov 2002 01:59:18 -0800
Subject: Re: Off somewhat: Linux Atto UL2D driver?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v546)
Cc: linuxppc-dev@lists.linuxppc.org
To: Stefan Jeglinski <jeglin@4pi.com>
From: Tim Seufert <tas@mindspring.com>
In-Reply-To: <p05100300b9ecf18e2bf6@[192.168.0.8]>
Message-Id: <3F93A084-F0A5-11D6-80CB-003065F22EAA@mindspring.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Monday, November 4, 2002, at 08:51  PM, Stefan Jeglinski wrote:

> I do not see Atto by name
> in the kernel build config. What is the driver so I can look at the
> source?

Atto's cards have Symbios (*) SCSI chips, and use either the Symbios
53c8xx or the new sym2 driver.

(*) actually, these days they're really LSI Logic chips -- Symbios
hasn't existed as an independent entity for some time now.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
