Message-ID: <408E554E.3090801@fh-landshut.de>
Date: Tue, 27 Apr 2004 14:42:54 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
MIME-Version: 1.0
To: Magnus Damm <damm@opensource.se>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Initrd and PPCbug, can it work?
References: <Pine.LNX.4.58.0404211503050.20798@ppcproject1>	<20040426220944.GI19246@smtp.west.cox.net>	<408E000A.6040303@fh-landshut.de>	<Pine.LNX.4.56.0404270913230.2035@mag.sysgo.com>	<408E1ED0.4050404@fh-landshut.de>	<Pine.LNX.4.56.0404271119270.2567@mag.sysgo.com>	<408E2AF4.2050907@fh-landshut.de> <20040427124820.2f3aa14c.damm@opensource.se>
In-Reply-To: <20040427124820.2f3aa14c.damm@opensource.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Magnus Damm wrote:
>>Maybe this is an endianess problem in my initrds?
>
>
> As long as you use ext2 you should not have any endian problems.
>
> It might be tempting to use other fancy filesystems, but I don't
> like endian problems so I usually stick to ext2. I create my
> ext2 initrds on x86 systems and use them on ppc without problems.
>

Yeah, I see. But this may be the problem that I had the cramfs error
messages even with a cramfs initrd - this is endian sensitive and only
makes little-endian - won't work without a patch, so I really better
stick with ext2,hm?

Thanks,
Oliver Korpilla

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
