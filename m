From: Amit.Lubovsky@infineon.com
Message-ID: <AD2F581BD7340A4C908AF1AFB066EA3B0E48FB@ntah901e.savan.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: monta vista MBX860
Date: Wed, 12 Nov 2003 18:47:31 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1255"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I run MontaVista kernel 2.4.18_mv130-mbx860 on MBX860 board connected
through the pc104 connector to a custom board which I want to access through
the pci.

The output of lspci is:

00:03.0 ISA bridge: Symphony Labs W83C553 (rev 17)
00:03:1 IDE interface: Symphony Labs SL82c105 (rev 17)
00:04:0 Network controller: Infineon Technologies AG: Unknown device 0008
(rev 02)

the last device recognized is the custom board connected to the mbx.

Could anyone point me to a working driver as an example of what I have to do
in order to
gain access from the mbx to registers on my custom board ?

Thanks,
Amit.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
