Message-ID: <000401c08812$be4d4de0$12c809c0@farout>
From: "Wang Chao Feng" <chfwang@sina.com.cn>
To: "Gregory Allen" <gallen@arlut.utexas.edu>,
        <linuxppc-embedded@lists.linuxppc.org>
References: <200101181805.MAA88737@ns5.arlut.utexas.edu>
Subject: Re: Ethernet controller
Date: Sat, 20 Jan 2001 11:26:11 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I don't think RTL8139 is a good choice because it's bad performance and it's hard to use.
In rtl8139, the data must copy from chip's fifo to your sk_buf.
In the driver of rtl8139 for linux, can can find the driver reset the chip in transmit function,
because of the bug of this chip.
When I flood ping the rtl8139 from a linux host, I find I must reset the chip every several minutes.

regards
wang


----- Original Message -----
From: Gregory Allen <gallen@arlut.utexas.edu>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Friday, January 19, 2001 2:05 AM
Subject: Ethernet controller


>
> I am designing an embedded PPC8240 board with an ethernet interface. I am down to 2 choices: i82559 and RTL8139
>
> I prefer to avoid the BGA package of the i82559, but the RTL8139 driver support is listed as having "limited PowerPC testing". I am also curious about their relative performance.
>
> Can anyone speak to this?
>
> Thanks,
> -Greg
>
> ------
>  Gregory E. Allen, MSEE Research Engineer
>  Applied Research Laboratories:
>  The University of Texas at Austin
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
