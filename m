Date: Mon, 18 Aug 2003 17:19:46 +0200
To: Rakesh jagota <j.rakesh@gdatech.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Chris Zimman <chris@cryptoapps.com>
Subject: Re: Problem with kernel loading in PPC IBM405 based board
Message-ID: <20030818151946.GA1076@mars.private.de>
References: <f4sdizk28w071ij.110620032000@gda-server> <20030611151322.GA9573@dingdong.cryptoapps.com> <biw8rj87c7wqoht.120620031114@gda-server>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <biw8rj87c7wqoht.120620031114@gda-server>
From: Frank Neuber <fn@kernelport.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Nov 07, 2003 at 11:19:03AM +0530, Rakesh jagota wrote:
>
> hi
>
> i am using Openbios Bios code downloaded from IBM site. In the boot i have
> initialized sdram. i have downloaded the zImage.treeboot at 0x01000000 using
> JTAG (RISC Watch., since our ethernet in boot is not working ).
Does the Openbios code detect the ethernet adapter?
If not you should check if the GPIO and EBIU register settings are ok to
access the chip.

Frank
--
Dipl.-Ing. Frank Neuber      http://www.kernelport.org
Kernelport                           fn@kernelport.org
Kavelweg 34               Tel/Fax: +49-3338 7010-65/66
16321 Schönow                Mobil: +49-163    6683108

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
