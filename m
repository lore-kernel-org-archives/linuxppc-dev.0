Return-Path: <mail4mz@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.187])
	by ozlabs.org (Postfix) with ESMTP id DD312DDEC5
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Aug 2007 06:47:49 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so1342120rvf
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Aug 2007 13:47:48 -0700 (PDT)
Message-ID: <5c9cd53b0708241347q6128f74fn644a20df4e39045c@mail.gmail.com>
Date: Fri, 24 Aug 2007 16:47:48 -0400
From: "mike zheng" <mail4mz@gmail.com>
To: "Andy Fleming" <afleming@freescale.com>
Subject: Re: 8555CDS BSP on 8548CDS board
In-Reply-To: <59B03E9A-3FE0-4F11-AEB5-CEAE6AB38F92@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_18392_2386098.1187988468535"
References: <5c9cd53b0708240900y6537e42cn5ee59b2a2a707768@mail.gmail.com>
	<59B03E9A-3FE0-4F11-AEB5-CEAE6AB38F92@freescale.com>
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

------=_Part_18392_2386098.1187988468535
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Andy,

Uboot is fine, I will re-use the current uboot on 8548CDS board. But the BSP
linux kernel is 2.6, I have to use 2.4 kernel.

I merged E500 support (8548CDS BSP and Kernel) from 2.6 back to my
2.4source tree. I managed to make the serial port driver (Poll mode)
working. The code already passed "console_init()". However the console does
NOT come out. What shall I check, exception, interrupt or decrementor?

Thus I am think to re-start from a 8555CDS BSP on 2.4 kernel, and modify
it for 8548CDS board. I am not sure which approach is easier. Maybe both are
difficult for me. :-(

Thanks,


On 8/24/07, Andy Fleming <afleming@freescale.com> wrote:
>
>
> On Aug 24, 2007, at 11:00, mike zheng wrote:
>
> > Hi,
> >
> > I was told Freescale's 8555CDS board is very similar to 8548CDS
> > board. I just wonder what exactly the differences are. can I just
> > put the 8555CDS BSP onto the 8548CDS board?
> >
> > Thanks  in advance,
>
>
> The 8555 u-boot is different from the 8548 u-boot.  There are also
> differences in the device-tree (I'm not sure what version of the
> kernel is in the BSP, so I can't say for sure).  Recent versions of
> the Linux kernel merged all of the CDS systems into one kernel.
>
> As for the differences, off the top of my head:
>
> * 8555 vs 8548 chip
> * PCI slot on the carrier card is PCI on 8555, PCIe on 8548.
> * 8548 has 4 eTSECs, 8555 has 2 TSECs (and the # of ethernet ports
> reflects this).
>
> Andy
>

------=_Part_18392_2386098.1187988468535
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Andy,</div>
<div>&nbsp;</div>
<div>Uboot is fine, I will re-use the current uboot on 8548CDS board. But the BSP linux kernel is 2.6,&nbsp;I&nbsp;have to use 2.4 kernel.</div>
<div>&nbsp;</div>
<div>I&nbsp;merged E500 support (8548CDS BSP and Kernel) from 2.6 back to my 2.4 source tree. I managed to make the serial port driver (Poll mode) working.&nbsp;The code already passed &quot;console_init()&quot;. However the console does NOT come out. What shall I check, exception, interrupt or decrementor?&nbsp;
</div>
<div>&nbsp;</div>
<div>Thus I am think to re-start from&nbsp;a 8555CDS&nbsp;BSP on 2.4 kernel, and&nbsp;modify it&nbsp;for 8548CDS board. I am not sure which approach is easier. Maybe both&nbsp;are difficult for me. :-(</div>
<div>&nbsp;</div>
<div>Thanks,&nbsp;<br><br>&nbsp;</div>
<div><span class="gmail_quote">On 8/24/07, <b class="gmail_sendername">Andy Fleming</b> &lt;<a href="mailto:afleming@freescale.com">afleming@freescale.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><br>On Aug 24, 2007, at 11:00, mike zheng wrote:<br><br>&gt; Hi,<br>&gt;<br>&gt; I was told Freescale&#39;s 8555CDS board is very similar to 8548CDS
<br>&gt; board. I just wonder what exactly the differences are. can I just<br>&gt; put the 8555CDS BSP onto the 8548CDS board?<br>&gt;<br>&gt; Thanks&nbsp;&nbsp;in advance,<br><br><br>The 8555 u-boot is different from the 8548 u-boot.&nbsp;&nbsp;There are also
<br>differences in the device-tree (I&#39;m not sure what version of the<br>kernel is in the BSP, so I can&#39;t say for sure).&nbsp;&nbsp;Recent versions of<br>the Linux kernel merged all of the CDS systems into one kernel.<br><br>
As for the differences, off the top of my head:<br><br>* 8555 vs 8548 chip<br>* PCI slot on the carrier card is PCI on 8555, PCIe on 8548.<br>* 8548 has 4 eTSECs, 8555 has 2 TSECs (and the # of ethernet ports<br>reflects this).
<br><br>Andy<br></blockquote></div><br>

------=_Part_18392_2386098.1187988468535--
