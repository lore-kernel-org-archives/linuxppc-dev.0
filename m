From: "Chris Backas" <cbackas@rcn.com>
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Date: Thu, 13 Jul 2000 09:03:10 -0400 (EDT)
Reply-To: "Chris Backas" <cbackas@bigfoot.com>
In-Reply-To: <20000713085324.18396@mailhost.mipsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: Re: iBook woes
Message-Id: <E13CjFi-0007hP-00@smtp01.mrf.mail.rcn.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 13 Jul 2000 10:53:24 +0200, Benjamin Herrenschmidt wrote:

>
>>what does cat /dev/sndstat say ?
>>you should also find some lines in dmesg with "DMA sound" stuff in them...
>>
>>I'd be interested to know what soundchip you have (AWACS version or is it a
>>Burgundy) etc.  which you can either find from those entries or from the
>>MacOS side...
>
>The iBook don't have an AWACS derivative. It's a different chip. The
>basic DBDMA operations are the same, but all the controls go thru an i2c
>bus. There's a driver for it in Darwin but not yet in Linux (but someone
>is working on it).
>
>Ben.

So I take it this means sound won't be working for awhile =)

Any ideas on the video problems I described then?  I find that more important anyway.

Chris Backas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
