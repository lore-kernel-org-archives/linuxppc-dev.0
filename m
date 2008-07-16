Return-Path: <nobin.mathew@gmail.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.185])
	by ozlabs.org (Postfix) with ESMTP id 432D7DDED2
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 20:07:57 +1000 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so1907482rnf.16
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 03:07:55 -0700 (PDT)
Message-ID: <8d6898730807160307g4455597ck921d55da8f51455d@mail.gmail.com>
Date: Wed, 16 Jul 2008 15:37:54 +0530
From: "Nobin Mathew" <nobin.mathew@gmail.com>
To: dinesh <dinesh.dua@coraltele.com>
Subject: Re: [alsa-devel] WRITING AN SOC DRIVER WITHOUT DMA
In-Reply-To: <1216199130.749.4.camel@dinesh.dua>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_24324_24291417.1216202874428"
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080712083939.15025.31192.stgit@trillian.secretlab.ca>
	<1216199130.749.4.camel@dinesh.dua>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	liam.girdwood@wolfsonmicro.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_24324_24291417.1216202874428
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi dinesh,

If you are working on ARM, see the ARM AACi code, in sound/arm/aaci.c

Thanks
Nobin Mathew.


On 7/16/08, dinesh <dinesh.dua@coraltele.com> wrote:
>
> Hi,
> I am writing a soc sound driver for MPC8323 board linux 2.6.24 in which i
> want to do data transfer to and from device myself using BUFFER DESCRIPTOR
> not with the usual DMA transfer.
> Please help me.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

------=_Part_24324_24291417.1216202874428
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi dinesh,</div>
<div>&nbsp;</div>
<div>If you are working on ARM, see the ARM AACi code, in sound/arm/aaci.c</div>
<div>&nbsp;</div>
<div>Thanks</div>
<div>Nobin Mathew.</div>
<div><br>&nbsp;</div>
<div><span class="gmail_quote">On 7/16/08, <b class="gmail_sendername">dinesh</b> &lt;<a href="mailto:dinesh.dua@coraltele.com">dinesh.dua@coraltele.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi,<br>I am writing a soc sound driver for MPC8323 board linux 2.6.24 in which i want to do data transfer to and from device myself using BUFFER DESCRIPTOR not with the usual DMA transfer.<br>
Please help me.<br>_______________________________________________<br>Alsa-devel mailing list<br><a href="mailto:Alsa-devel@alsa-project.org">Alsa-devel@alsa-project.org</a><br><a href="http://mailman.alsa-project.org/mailman/listinfo/alsa-devel">http://mailman.alsa-project.org/mailman/listinfo/alsa-devel</a><br>
</blockquote></div><br>

------=_Part_24324_24291417.1216202874428--
