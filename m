From: Pantelis Antoniou <panto@intracom.gr>
To: Wolfgang Denk <wd@denx.de>
Cc: Stephan Linke <Stephan.Linke@epygi.de>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3EE853AA.9020106@intracom.gr>
Date: Thu, 12 Jun 2003 13:19:22 +0300
MIME-Version: 1.0
Subject: Re: running 8xx without UART
References: <20030612100504.22A9FC5FD7@atlas.denx.de>
In-Reply-To: <20030612100504.22A9FC5FD7@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

>In message <FCEAKDJJAPHPLJFINDAJAEHGDCAA.Stephan.Linke@epygi.de> you wrote:
>
>
>>is it possible to make a 8xx kernel without setting up one of the serial interfaces for UART mode? It seames to me like it is only
>>
>>
>
>Yes, this is possible.
>
>
>
>>possible to choose between the CPM interfaces.
>>We are experiencing problems with SCC3 running ethernet and SMC1 as console interface on a 852.
>>
>>
>
>I think it would be better to solve this problem instead of just  not
>using SMC1 and leaving an unresolved bug in the kernel...
>
>
>Best regards,
>
>Wolfgang Denk
>
>--
>Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
>Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
>Immortality consists largely of boredom.
>	-- Zefrem Cochrane, "Metamorphosis", stardate 3219.8
>
>
>
>
>
I just pop up here to say that I have done this for a previous board
with a 850
and instead we used a netconsole.

In a new board we have the same problem, and I'll have to make the patch
again. Since we need a serial port we used a max3100 spi to serial converter
and I have a driver for that ready (but not yet as a console).

When I get around to add support for this chip in u-boot I'll also send the
patches for the kernel.

Regards

Pantelis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
