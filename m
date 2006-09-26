Return-Path: <tmk@cmcltd.com>
Received: from cmcdns1.cmcltd.com (navint.cmcltd.com [59.160.161.31])
	by ozlabs.org (Postfix) with ESMTP id 5655267BF4
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Sep 2006 01:59:36 +1000 (EST)
From: Mohan Krishna T <tmk@cmcltd.com>
To: 'Grant Likely' <grant.likely@secretlab.ca>
Subject: =?UTF-8?Q?RE=3A_Unable_to_boot_linux_on_Xilinx_ML403_board?=
Date: Tue, 26 Sep 2006 21:28:42 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <528646bc0609260856y69339eb2nb237e53efc2d6de5@mail.gmail.com>
Message-ID: <smtp_45194CAB_1724_0002.eml@>
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

I am using the same image for FIFO mode. It is booting without any problem.
The problem is only coming in DMA mode. Is there any restriction on size if
it is DMA mode? Or should I tale any extra care of RAMDISK if I am in DMA
mode?

Thanks and Regards
Mohan Krishna T

-----Original Message-----
From: glikely=40gmail.com =5Bmailto:glikely=40gmail.com=5D On Behalf Of =
Grant Likely
Sent: Tuesday, September 26, 2006 9:26 PM
To: Mohan Krishna T
Cc: Peter Ryser; linuxppc-embedded=40ozlabs.org
Subject: Re: Unable to boot linux on Xilinx ML403 board

On 9/26/06, Mohan Krishna T <tmk=40cmcltd.com> wrote:
> The zImage.initrd.elf is of size 3.4MB. I am getting hanged only when I am
> using DMA for Ethernet. Booting is going fine when I am using FIFO Mode.

You may be hitting the 4MB upper limit for zImages.  I had the same
problem with slightly smaller images, and it would hang at (seemingly)
random places everytime I changed something.  Making the image smaller
made the problem go away.

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
