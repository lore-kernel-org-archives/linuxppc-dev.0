Message-ID: <69AB2E42243FD511920200805FE64EAD05AE1D10@zbr01exm01.spo.br.mot.com>
From: Estevam Fabio-R49496 <Fabio.Estevam@freescale.com>
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Internal Address multiplexing  for MCP852
Date: Fri, 28 May 2004 15:06:20 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am using Embedded Planet´s EP852T board and there are 2 MT48LC4M16 SDRAMs in this board .

The .../ppcboot/u-boot-1.0.0x/board/ep852/ep852.c file has the 852 UPM initialization routine and it is configured not to use the address multiplexing capability of the 852. It uses an external address multiplexer chip instead.

I would like to remove the external multiplexer chip and connect the 852 address lines directly  to the SDRAMs  without using a multiplexer.

I know that I will have to set the SAM bit in the SDRAM_OR1VALUE register and also the AMX bits in the UPM RAM words of the const uint sdram table[] array.

Please let me know if someone has already done that setting and would like to share it with me.

Thanks,

Fabio Estevam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
