Date: Thu, 4 Dec 2003 01:15:36 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Wojciech Kromer <krom@dgt-lab.com.pl>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: memory problem with fec on 8250
Message-ID: <20031204091536.GA1050@gate.ebshome.net>
References: <3FCD956B.8030604@gazeta.pl> <3FCEF441.2030808@dgt-lab.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3FCEF441.2030808@dgt-lab.com.pl>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Dec 04, 2003 at 09:45:53AM +0100, Wojciech Kromer wrote:
> >i have some problems with using fec device on my custom 8250 board
> >while sending a lot of data (at least 300MB) through this device causes
> >lack of memory
> >sending same amount of data through loopback works fine
> >
> >i'm using 2.4.19 kernel
> >any idea?
>
> cached memory keeps growing slowly, and free is going down same way,
> after putting ~300MB ftp data (from 8250 board to another host), VM
> starts killing some applications
>
> same situation is with latest linuxppc_2_4_devel kernel from denx.de,
> but there is additional information from kernel
>
> <5>__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> <5>__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> <5>__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> <5>__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> <5>__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> <4>VM: killing process sshd
>
> what's wrong ???

It means that this box is really out of memory.

Could you provide output from utility called 'free' and from file
/proc/slabinfo at two points of time: 1) when you just booted your
boax and 2) just before it starts failing.

Thanks,

Eugene.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
