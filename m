Date: Thu, 4 Dec 2003 02:19:01 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Wojciech Kromer <krom@dgt-lab.com.pl>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: memory problem with fec on 8250
Message-ID: <20031204101901.GB1050@gate.ebshome.net>
References: <3FCD956B.8030604@gazeta.pl> <3FCEF441.2030808@dgt-lab.com.pl> <20031204091536.GA1050@gate.ebshome.net> <3FCF0252.7070202@dgt-lab.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3FCF0252.7070202@dgt-lab.com.pl>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Dec 04, 2003 at 10:45:54AM +0100, Wojciech Kromer wrote:
> >
> >>>i have some problems with using fec device on my custom 8250 board
> >>>while sending a lot of data (at least 300MB) through this device causes
> >>>lack of memory
> >>>sending same amount of data through loopback works fine
> >>>

[snip]

> ==== at begining =========================================
> skbuff_head_cache    131    192    160    8    8    1
> size-2048              5    178   2048    3   89    1
>
> ===after some time (ftp put ~75MB) ================================
>
> skbuff_head_cache  16857  16872    160  703  703    1
> size-2048          16749  16798   2048 8382 8399    1

It looks like skb leaks in the driver. Probably in TX path.

Could you send me by private e-mail source code for ethernet driver in
question or provide a URL.

I'm not a 8250 guy, but I'll try to look at it :)

Eugene.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
