Message-ID: <40E83EFD.8000309@246tNt.com>
Date: Sun, 04 Jul 2004 19:31:41 +0200
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Andy Fleming <afleming@freescale.com>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: IRQ Level / Edge
References: <40E5D609.6090201@246tNt.com> <DE336CD5-CC79-11D8-BA44-000393C30512@freescale.com> <20040703164216.GA22998@pegasos>
In-Reply-To: <20040703164216.GA22998@pegasos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 >
 > Err, i suppose the interesting bit is not how the board designer
 > will know wheter the interrupt is edge or level, but how the kernel
 > running on the board is able to detect it ?
 >
 > Friendly,


Well, the kernel doesn't detect it. You have to tell him !
That's why I asked, because in the interrupt controller code, you have
to set it in the irq_desc[i] structure.

Sylvain


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
