Return-Path: <bhupi.saharan@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id 1F0C8DDF14
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jun 2007 12:30:36 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k40so255786ugc
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Jun 2007 19:30:34 -0700 (PDT)
Message-ID: <720399a30706271930i6a45cbbbsb847dc2dd732ca5c@mail.gmail.com>
Date: Wed, 27 Jun 2007 19:30:33 -0700
From: "Bhupender Saharan" <bhupi.saharan@gmail.com>
To: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
Subject: Re: ARCH=ppc or ARCH=powerpc
In-Reply-To: <F795765B112E7344AF36AA911279641502D1A42C@xmb-sjc-212.amer.cisco.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_32020_15736639.1182997833936"
References: <F795765B112E7344AF36AA911279641502D1A42C@xmb-sjc-212.amer.cisco.com>
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

------=_Part_32020_15736639.1182997833936
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

All the new development is happening in arch/powerpc  architecure. So it is
good to use this architecure if you are upgrading the kernel. But it might
not work with kernel 1.1.2, As arch/powerpc need a structure like open
firmware for the parameters.


If you want to stick to 1.1.2 u-boot version then you shall use arch/ppc
architecure.

Regards
Bhupi


On 6/27/07, Bizhan Gholikhamseh (bgholikh) <bgholikh@cisco.com> wrote:
>
>  Hi All,
> Sorry for asking this question again, I am still not clear on some of the
> issues.
> Background:
> We have developed a custom board based on Freescale reference board:
> MPC8555_CDS with MPC8541E processor running Linux 2.6.11 and uboot 1.1.2version.
>
> I would like to update the Linux kernel to the latest available kernel
> 2.6.21.
> Here are my questions:
> 1- Should I use ARCH=ppc or ARCH=powerpc to build the kernel?
> 2- I have seen similar filenames under arch/ppc and arch/powerpc, which
> one applies to MPC8541E?
> 3- Once I build the kernel, could I load the kernel with uboot version
> 1.1.2 or not? if not what I should do?
>
> Many thanks in advance,
> Bizhan
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

------=_Part_32020_15736639.1182997833936
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>All the new development is happening in arch/powerpc&nbsp; architecure. So it is good to use this architecure if you are upgrading the kernel. But it might not work with kernel 1.1.2, As arch/powerpc need a structure like open firmware for the parameters.
<br><br><br>If you want to stick to 1.1.2 u-boot version then you shall use arch/ppc architecure.<br><br>Regards<br>Bhupi<br>&nbsp;<br><br><div><span class="gmail_quote">On 6/27/07, <b class="gmail_sendername">Bizhan Gholikhamseh (bgholikh)
</b> &lt;<a href="mailto:bgholikh@cisco.com">bgholikh@cisco.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">



<div>
<div><font face="Arial" size="2"><span>Hi 
All,</span></font></div>
<div><font face="Arial" size="2"><span>Sorry for asking 
this question again, I am still not clear on some of the 
issues.</span></font></div>
<div><font face="Arial" size="2"><span>Background:</span></font></div>
<div><font face="Arial" size="2"><span>We have developed 
a&nbsp;custom board based on Freescale reference board: MPC8555_CDS&nbsp;with 
MPC8541E processor running Linux 2.6.11 and uboot 1.1.2 
version.</span></font></div>
<div><font face="Arial" size="2"><span>&nbsp;</span></font></div>
<div><font face="Arial" size="2"><span>I would like to 
update the Linux kernel to the latest available kernel 
2.6.21.</span></font></div>
<div><font face="Arial" size="2"><span>Here are my 
questions:</span></font></div>
<div><font face="Arial" size="2"><span>1- Should I use 
ARCH=ppc or ARCH=powerpc to build the kernel?</span></font></div>
<div><font face="Arial" size="2"><span>2- I have seen 
similar filenames under arch/ppc and arch/powerpc, which one applies to 
MPC8541E?</span></font></div>
<div><font face="Arial" size="2"><span>3- Once I build the 
kernel, could I load the kernel with uboot version 1.1.2 or not? if not what I 
should do?</span></font></div>
<div><font face="Arial" size="2"><span></span></font>&nbsp;</div>
<div><font face="Arial" size="2"><span>Many thanks in 
advance,</span></font></div>
<div><font face="Arial" size="2"><span>Bizhan</span></font></div>
<div><font face="Arial" size="2"><span></span></font>&nbsp;</div></div>
<br>_______________________________________________<br>Linuxppc-embedded mailing list<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded" target="_blank">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br></blockquote></div><br>

------=_Part_32020_15736639.1182997833936--
