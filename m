MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-a7e997ec-79a3-4896-bd5f-f99afef74010"
Subject: Problem with PPC 857 MMU
Date: Mon, 15 Jul 2002 14:06:39 +0530
Message-ID: <72D09F11CC09B645ADE2890F6B442FD815E4A5@blr-m3-msg.wipro.com>
From: "rajib  majila" <rajib.majila@wipro.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.

------=_NextPartTM-000-a7e997ec-79a3-4896-bd5f-f99afef74010
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,
We are trying to port mvista linux on Power PC 857T based board. We are =
loading the zImage.initrd file into 0x120000 address and our bootloader =
looks for an elf file at that address and then copies the kernel into =
0x400000 adrress.=20
After that the boot-loader jumps to that location and the pro-kernel =
starts uncompressing the kernel into 0x000000. After that it jumps to =
0x0. From head_8xx.S, control is transffered to start_kernel by using a =
rfi instruction. Our kernel crashes at this location. We would like to =
hear about any such problem faced by any of you and how you solved the =
problem.=20
We are downloading our boot-loader into the RAM (at 0x100000) using BDM =
and we run the boot-loader from there as we are
Not able to write the on-board flash.
All the addresses mentioned above RAM physical address.
Thanx a lot in advance for your help.
--Rajib

------=_NextPartTM-000-a7e997ec-79a3-4896-bd5f-f99afef74010
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

**************************Disclaimer**************************************************

 Information contained in this E-MAIL being proprietary to Wipro Limited is 'privileged'
and 'confidential' and intended for use only by the individual or entity to which it is
addressed. You are notified that any use, copying or dissemination of the information
contained in the E-MAIL in any manner whatsoever is strictly prohibited.

****************************************************************************************

------=_NextPartTM-000-a7e997ec-79a3-4896-bd5f-f99afef74010--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
