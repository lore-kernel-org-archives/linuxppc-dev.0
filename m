Return-Path: <ratheeshreddy@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by ozlabs.org (Postfix) with ESMTP id A43E4DDDFB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Sep 2007 14:08:39 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so94085nfd
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Sep 2007 21:08:38 -0700 (PDT)
Message-ID: <c94019ff0709112108o71bd5e25o7e04472d433d9922@mail.gmail.com>
Date: Wed, 12 Sep 2007 09:38:37 +0530
From: Ratheesh <ratheeshreddy@gmail.com>
To: "Yoni Levin" <yoni.l@slyde-tech.com>
Subject: Re: writing to flash from linux
In-Reply-To: <1E2D24B6DA8A4EE68CFFD33998B2BC26.MAI@mail.livedns.co.il>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_16595_10881296.1189570117309"
References: <1E2D24B6DA8A4EE68CFFD33998B2BC26.MAI@mail.livedns.co.il>
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

------=_Part_16595_10881296.1189570117309
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
     You can write into flash from linux if you have mapped the flash in mtd
partition. you can open /dev/mtdx(partition that covers your flash
area) file and use normal read/write function calls to read/write from the
flash. Remember to erase the flash before attempting to write data. You can
refer sourcecode of mtd-utils.

Regards
Ratheesh


On 9/11/07, Yoni Levin <yoni.l@slyde-tech.com> wrote:
>
>  Hi , I have EN29LV640H flash (http://www.eonsdi.com/pdf/EN29LV640.pdf)
>
> On my mpc83xx board.
>
> How can I write data to flash from linux.?
>
> I guess it done with mtd , there is an example somewhere?
>
> Thanks.
>
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

------=_Part_16595_10881296.1189570117309
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi,</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp; You can write into flash from linux if you have mapped the flash in mtd partition. you can open /dev/mtdx(partition that covers&nbsp;your flash area)&nbsp;file and use normal read/write function calls to read/write from the flash. Remember to erase the flash before attempting to write data. You can refer&nbsp;sourcecode of mtd-utils.
</div>
<div>&nbsp;</div>
<div>Regards</div>
<div>Ratheesh<br><br>&nbsp;</div>
<div><span class="gmail_quote">On 9/11/07, <b class="gmail_sendername">Yoni Levin</b> &lt;<a href="mailto:yoni.l@slyde-tech.com">yoni.l@slyde-tech.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div lang="EN-US" vlink="purple" link="blue">
<div dir="rtl">
<p dir="ltr" style="DIRECTION: ltr; TEXT-ALIGN: left"><font face="Arial" size="2"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">Hi , I have EN29LV640H flash (<a onclick="return top.js.OpenExtLink(window,event,this)" href="http://www.eonsdi.com/pdf/EN29LV640.pdf" target="_blank">
http://www.eonsdi.com/pdf/EN29LV640.pdf</a>)</span></font></p>
<p dir="ltr" style="DIRECTION: ltr; TEXT-ALIGN: left"><font face="Arial" size="2"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">On my mpc83xx board.</span></font></p>
<p dir="ltr" style="DIRECTION: ltr; TEXT-ALIGN: left"><font face="Arial" size="2"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">How can I write data to flash from linux.?</span></font></p>
<p dir="ltr" style="DIRECTION: ltr; TEXT-ALIGN: left"><font face="Arial" size="2"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">I guess it done with mtd , there is an example somewhere?</span></font></p>
<p dir="ltr" style="DIRECTION: ltr; TEXT-ALIGN: left"><font face="Arial" size="2"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">Thanks.</span></font></p>
<p dir="ltr" style="DIRECTION: ltr; TEXT-ALIGN: left"><font face="Arial" size="2"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;</span></font></p></div></div><br>_______________________________________________<br>Linuxppc-embedded mailing list
<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded" target="_blank">
https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br></blockquote></div><br>

------=_Part_16595_10881296.1189570117309--
