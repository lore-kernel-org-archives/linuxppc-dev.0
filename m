Message-ID: <3FB26B87.4060300@primagraphics.co.uk>
Date: Wed, 12 Nov 2003 17:19:03 +0000
From: Mark Powell <medp@primagraphics.co.uk>
MIME-Version: 1.0
To: llandre <r&d@wawnet.biz>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Silicon Motion VGA controllers and PPC architecture
References: <5.1.1.6.0.20031112173538.01bd2e78@dns.struinfo.it>
In-Reply-To: <5.1.1.6.0.20031112173538.01bd2e78@dns.struinfo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


llandre wrote:

>
> I'm looking for a VGA controller to use with an embedded PPC405-based
> system.
> I had a look at the Silicon Motion chips (712/722) and they seem very
> suited for embedded applications.
> Unfortunately the techical support claims that these chips, because the
> presence of x86 BIOS, support only the x86 architecture. Anybody can
> confirm this?

We have used the 3DM/3DM+ and ran into this problem.
There is no documentation on how to initialise the chip and the
documentation that there is contains little description or explanation
and is just plain wrong in places.

--
Mark Powell, Senior Software Engineer, Primagraphics Limited
New Cambridge House, Litlington, nr.Royston, Herts, SG8 0SS, UK
Tel. +44 1763 852222, Fax. 853324, http://www.primagraphics.co.uk


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
