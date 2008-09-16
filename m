Return-Path: <adams.ppc@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.234])
	by ozlabs.org (Postfix) with ESMTP id 74570DDE17
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Sep 2008 08:40:52 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id s6so1227610wxc.15
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Sep 2008 15:40:51 -0700 (PDT)
Message-ID: <4a21eaea0809161540xa2135d5j2f22cfac2e012dc8@mail.gmail.com>
Date: Tue, 16 Sep 2008 16:40:50 -0600
From: "bhanu jampala" <adams.ppc@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: dma_to_virt() on PPC?
In-Reply-To: <4a21eaea0809161437y2d3ba52et3803831828a62e4d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_95664_14708557.1221604851008"
References: <4a21eaea0809161437y2d3ba52et3803831828a62e4d@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_95664_14708557.1221604851008
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi guys,

I have tried these calls to covert part of my DMA address to Virtual and it
seems to work fine.
I am curious to know more about these calls.

dma_map_single(NULL, dev->buf_addr, tx_cnt, DMA_TO_DEVICE));
dma_map_single(NULL, dev->buf_addr, tx_cnt, DMA_FROM_DEVICE));

The reason I am suspect these calls is:

I allocated a single DMA memory of 4K bytes size.
No I want to split and distribute the so allocated buffer between each
device.
in that case of my starting address is ADDR. the address I submit to the
device would be something like

ADDR + 32* device_num.

But, I realize that it is not actually returning the Virtual address.

Regards,
Adams



On Tue, Sep 16, 2008 at 3:37 PM, bhanu jampala <adams.ppc@gmail.com> wrote:

> Hi All,
>
> How do I convert a DMA buffer to virtual address on Linux PPC?
>
> I know there is some thing like dma_to_virt(), but I don't think if there
> is one for PPC.
> In this scenario where I have submitted some dma buffer form a chunk of
> memory to Device.
> Now at the end of successful receive, how do I convert it back to Virtual
> address?
> Any pointers?
>
>
>
>

------=_Part_95664_14708557.1221604851008
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi guys,<br><br>I have tried these calls to covert part of my DMA address to Virtual and it seems to work fine.<br>I am curious to know more about these calls.<br><br>dma_map_single(NULL, dev-&gt;buf_addr, tx_cnt, DMA_TO_DEVICE));<br>

dma_map_single(NULL, dev-&gt;buf_addr, tx_cnt, DMA_FROM_DEVICE));<br>
<br>The reason I am suspect these calls is:<br><br>
I allocated a single DMA memory of 4K bytes size.<br>No I want to split and distribute the so allocated buffer between each device.<br>in that case of my starting address is ADDR. the address I submit to the device would be something like <br>
<br>ADDR + 32* device_num.<br><br>But, I realize that it is not actually returning the Virtual address.<br><br>Regards,<br>Adams<br><br><br><br><div class="gmail_quote">On Tue, Sep 16, 2008 at 3:37 PM, bhanu jampala <span dir="ltr">&lt;<a href="mailto:adams.ppc@gmail.com">adams.ppc@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div dir="ltr">Hi All,<br><br>How do I convert a DMA buffer to virtual address on Linux PPC?<br>
<br>I know there is some thing like dma_to_virt(), but I don&#39;t think if there is one for PPC.<br>In this scenario where I have submitted some dma buffer form a chunk of memory to Device.<br>
Now at the end of successful receive, how do I convert it back to Virtual address?<br>Any pointers?<br>
<br><br><br></div>
</blockquote></div><br></div>

------=_Part_95664_14708557.1221604851008--
