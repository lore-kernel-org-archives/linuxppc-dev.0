Return-Path: <tmk@cmcltd.com>
Received: from cmcdns1.cmcltd.com (navint.cmcltd.com [59.160.161.31])
	by ozlabs.org (Postfix) with ESMTP id 57D6467B7F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Sep 2006 01:45:39 +1000 (EST)
From: Mohan Krishna T <tmk@cmcltd.com>
To: 'Grant Likely' <grant.likely@secretlab.ca>
Subject: =?UTF-8?Q?RE=3A_Unable_to_boot_linux_on_Xilinx_ML403_board?=
Date: Tue, 26 Sep 2006 21:14:43 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <528646bc0609260638t16dae54ct266548030e21ffd1@mail.gmail.com>
Message-ID: <smtp_45194964_13E8_0002.eml@>
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

The zImage.initrd.elf is of size 3.4MB. I am getting hanged only when I am
using DMA for Ethernet. Booting is going fine when I am using FIFO Mode.


Thanks
Mohan Krishna

-----Original Message-----
From: glikely=40gmail.com =5Bmailto:glikely=40gmail.com=5D On Behalf Of =
Grant Likely
Sent: Tuesday, September 26, 2006 7:09 PM
To: Mohan Krishna T
Cc: Peter Ryser; linuxppc-embedded=40ozlabs.org
Subject: Re: Unable to boot linux on Xilinx ML403 board

On 9/26/06, Mohan Krishna T <tmk=40cmcltd.com> wrote:
> I have tried the option you have suggested but couldn't boot successfully.
I
> tried to debug where exactly the kernel is getting hanged. I could found
> that its hanging in gunzip() function call. It is never coming out of loop
> that decompress the ramdisk image.

How large is you zImage.embedded?

--=20
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely=40secretlab.ca
(403) 399-0195



DISCLAIMER

=E2=80=9CThe information contained in this e-mail message and/or =
attachments to it may contain confidential or privileged information. If =
you are not the intended recipient, any dissemination, use, review, =
distribution, printing or copying of the information contained in this =
e-mail message and/or attachments to it are strictly prohibited. If you =
have received this communication in error, please notify us by reply =
e-mail or telephone and immediately and permanently delete the message and =
any attachments. Thank you=22=
