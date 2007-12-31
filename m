Return-Path: <jeynergilcaga@gmail.com>
Received: from hs-out-2122.google.com (hs-out-0708.google.com [64.233.178.250])
	by ozlabs.org (Postfix) with ESMTP id A805CDDE2A
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Dec 2007 22:57:13 +1100 (EST)
Received: by hs-out-2122.google.com with SMTP id x43so3798172hsb.9
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Dec 2007 03:57:12 -0800 (PST)
Message-ID: <cad107560712310357u6edc463al5ed19a6d7b34e52e@mail.gmail.com>
Date: Mon, 31 Dec 2007 19:57:12 +0800
From: "Jeyner Gil Caga" <jeynergilcaga@gmail.com>
To: "Misbah khan" <misbah_khan@engineer.com>, linuxppc-embedded@ozlabs.org
Subject: Re: How to do IO mapped Implimentation ???
In-Reply-To: <14555864.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3425_18323825.1199102232343"
References: <14522349.post@talk.nabble.com> <14555864.post@talk.nabble.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_3425_18323825.1199102232343
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hmmm, I have not touched ppc8248 before, but I guess it will work since it
is only 1 byte, not 2 or 4 byte access. I have used it in ppc 440epx, and
that eval board is big endian as well.

On 12/31/07, Misbah khan <misbah_khan@engineer.com> wrote:
>
>
> I have used in_be32() and out_be32() for ppc8248 in one of my driver for
> FPGA
> in which the fpga memory is mapped here it is Io mapped thats the only
> difference ....remapping and using in_8() and out_8() will it work for
> BigEndian arch ????
>
> -----Misbah <><
>
>
> Misbah khan wrote:
> >
> > Hi all...
> >
> > I am writing a driver in which device port is mapped to CPLD and 8 bit
> > data bus is directly connected from processor to CPLD. Read write on
> CPLD
> > memory mapped (buffer/register) is required to control the device. This
> is
> > now IO mapped to processor.
> >
> > I need to know whether i am right if i impliment like this :-
> >          addr=ioremap(base_addr);          // Remap to Mem mapped
> address
> >          outb(addr) and inb(addr);
> >
> > Please suggest me if i am wrong or there could be better solution to
> this
> > .
> >
> > -----Misbah <><
> >
> >
>
> --
> View this message in context:
> http://www.nabble.com/How-to-do-IO-mapped-Implimentation-----tp14522349p14555864.html
> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

------=_Part_3425_18323825.1199102232343
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hmmm, I have not touched ppc8248 before, but I guess it will work since it is only 1 byte, not 2 or 4 byte access. I have used it in ppc 440epx, and that eval board is big endian as well.<br><br>
<div><span class="gmail_quote">On 12/31/07, <b class="gmail_sendername">Misbah khan</b> &lt;<a href="mailto:misbah_khan@engineer.com">misbah_khan@engineer.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><br>I have used in_be32() and out_be32() for ppc8248 in one of my driver for FPGA<br>in which the fpga memory is mapped here it is Io mapped thats the only
<br>difference ....remapping and using in_8() and out_8() will it work for<br>BigEndian arch ????<br><br>-----Misbah &lt;&gt;&lt;<br><br><br>Misbah khan wrote:<br>&gt;<br>&gt; Hi all...<br>&gt;<br>&gt; I am writing a driver in which device port is mapped to CPLD and 8 bit
<br>&gt; data bus is directly connected from processor to CPLD. Read write on CPLD<br>&gt; memory mapped (buffer/register) is required to control the device. This is<br>&gt; now IO mapped to processor.<br>&gt;<br>&gt; I need to know whether i am right if i impliment like this :-
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;addr=ioremap(base_addr);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;// Remap to Mem mapped address<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;outb(addr) and inb(addr);<br>&gt;<br>&gt; Please suggest me if i am wrong or there could be better solution to this<br>&gt; .
<br>&gt;<br>&gt; -----Misbah &lt;&gt;&lt;<br>&gt;<br>&gt;<br><br>--<br>View this message in context: <a href="http://www.nabble.com/How-to-do-IO-mapped-Implimentation-----tp14522349p14555864.html">http://www.nabble.com/How-to-do-IO-mapped-Implimentation-----tp14522349p14555864.html
</a><br>Sent from the linuxppc-embedded mailing list archive at <a href="http://Nabble.com">Nabble.com</a>.<br><br>_______________________________________________<br>Linuxppc-embedded mailing list<br><a href="mailto:Linuxppc-embedded@ozlabs.org">
Linuxppc-embedded@ozlabs.org</a><br><a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br></blockquote></div><br>

------=_Part_3425_18323825.1199102232343--
