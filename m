Message-ID: <3FCEF441.2030808@dgt-lab.com.pl>
Date: Thu, 04 Dec 2003 09:45:53 +0100
From: Wojciech Kromer <krom@dgt-lab.com.pl>
MIME-Version: 1.0
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: memory problem with fec on 8250
References: <3FCD956B.8030604@gazeta.pl>
In-Reply-To: <3FCD956B.8030604@gazeta.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


U¿ytkownik Kromer napisa³:

>
> hi there
>
> i have some problems with using fec device on my custom 8250 board
> while sending a lot of data (at least 300MB) through this device causes
> lack of memory
> sending same amount of data through loopback works fine
>
> i'm using 2.4.19 kernel
> any idea?

cached memory keeps growing slowly, and free is going down same way,
after putting ~300MB ftp data (from 8250 board to another host), VM
starts killing some applications

same situation is with latest linuxppc_2_4_devel kernel from denx.de,
but there is additional information from kernel

<5>__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
<5>__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
<5>__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
<5>__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
<5>__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
<4>VM: killing process sshd

what's wrong ???


--
* * * * * * * * * * * *
* per pedes ad astra! *
* * * * * * * * * * * *    mailto:krom@dgt-lab.com.pl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
