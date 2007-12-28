Return-Path: <jeynergilcaga@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.226])
	by ozlabs.org (Postfix) with ESMTP id 1676CDDDFD
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Dec 2007 04:35:10 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so853325wxd.15
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Dec 2007 09:35:09 -0800 (PST)
Message-ID: <cad107560712280935w6b232f03vd4653e4715191c20@mail.gmail.com>
Date: Sat, 29 Dec 2007 01:35:09 +0800
From: "Jeyner Gil Caga" <jeynergilcaga@gmail.com>
To: "Misbah khan" <misbah_khan@engineer.com>, linuxppc-embedded@ozlabs.org
Subject: Re: How to do IO mapped Implimentation ???
In-Reply-To: <14522349.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_367_3884992.1198863309699"
References: <14522349.post@talk.nabble.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_367_3884992.1198863309699
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Misbah,

If I am not mistaken, ioremap takes 2 parameters,
ioremap(base_addr,size_to_remap). i have tried out_8() and in_8() to issue
the command.


Regards,
gil

On 12/28/07, Misbah khan <misbah_khan@engineer.com> wrote:
>
>
> Hi all...
>
> I am writing a driver in which device port is mapped to CPLD and 8 bit
> data
> bus is directly connected from processor to CPLD. Read write on CPLD
> memory
> mapped (buffer/register) is required to control the device. This is now IO
> mapped to processor.
>
> I need to know whether i am right if i impliment like this :-
>         addr=ioremap(base_addr);          // Remap to Mem mapped address
>         outb(addr) and inb(addr);
>
> Please suggest me if i am wrong or there could be better solution to this
> .
>
> -----Misbah <><
>
> --
> View this message in context:
> http://www.nabble.com/How-to-do-IO-mapped-Implimentation-----tp14522349p14522349.html
> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

------=_Part_367_3884992.1198863309699
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Misbah,</div>
<div>&nbsp;</div>
<div>If I am not mistaken, ioremap takes 2 parameters, ioremap(base_addr,size_to_remap). i have tried out_8() and in_8() to issue the command.<br>&nbsp;</div>
<div>&nbsp;</div>
<div>Regards,</div>
<div>gil<br>&nbsp;</div>
<div><span class="gmail_quote">On 12/28/07, <b class="gmail_sendername">Misbah khan</b> &lt;<a href="mailto:misbah_khan@engineer.com">misbah_khan@engineer.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><br>Hi all...<br><br>I am writing a driver in which device port is mapped to CPLD and 8 bit data<br>bus is directly connected from processor to CPLD. Read write on CPLD memory
<br>mapped (buffer/register) is required to control the device. This is now IO<br>mapped to processor.<br><br>I need to know whether i am right if i impliment like this :-<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;addr=ioremap(base_addr);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;// Remap to Mem mapped address
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;outb(addr) and inb(addr);<br><br>Please suggest me if i am wrong or there could be better solution to this .<br><br>-----Misbah &lt;&gt;&lt;<br><br>--<br>View this message in context: <a href="http://www.nabble.com/How-to-do-IO-mapped-Implimentation-----tp14522349p14522349.html">
http://www.nabble.com/How-to-do-IO-mapped-Implimentation-----tp14522349p14522349.html</a><br>Sent from the linuxppc-embedded mailing list archive at <a href="http://Nabble.com">Nabble.com</a>.<br><br>_______________________________________________
<br>Linuxppc-embedded mailing list<br><a href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a><br><a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded
</a><br></blockquote></div><br>

------=_Part_367_3884992.1198863309699--
