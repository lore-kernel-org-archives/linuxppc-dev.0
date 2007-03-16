Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id CA996DDEE9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Mar 2007 05:39:41 +1100 (EST)
Message-ID: <45FAE45D.7000908@ru.mvista.com>
Date: Fri, 16 Mar 2007 21:39:25 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: aldo lab <aldo.lab@gmail.com>
Subject: Re: m8260_map_io
References: <6e41d1460703161136q7afb3077r49b11cb9a123c124@mail.gmail.com>
In-Reply-To: <6e41d1460703161136q7afb3077r49b11cb9a123c124@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello.

aldo lab wrote:

> I've seen a region of 256MB starting from 0xe0000000 that is io
> blocking with a BAT filled with Inhibit cache and guarded.
> do you know which is the reason of this mapping because is not so
> clear from the code.
> 
> 201 static void __init
> 202 m8260_map_io(void)
> 203 {
> 204         uint addr;
> 205
> 206         /* Map IMMR region to a 256MB BAT */
> 207         addr = (cpm2_immr != NULL) ? (uint)cpm2_immr : CPM_MAP_ADDR;
> 208         io_block_mapping(addr, addr, 0x10000000, _PAGE_IO);
> 209
> 210         /* Map I/O region to a 256MB BAT */
> 211         io_block_mapping(IO_VIRT_ADDR, IO_PHYS_ADDR, 0x10000000, _PAGE_IO);
> 212 }
> 213

    MPC82xx SoC registers are mapped there.

> Thank you
> Aldo

WBR, Sergei
