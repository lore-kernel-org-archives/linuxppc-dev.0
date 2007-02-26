Return-Path: <dan@embeddedalley.com>
Received: from smtp106.biz.mail.re2.yahoo.com (smtp106.biz.mail.re2.yahoo.com
	[206.190.52.175]) by ozlabs.org (Postfix) with SMTP id A46BDDDEFE
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Feb 2007 03:26:44 +1100 (EST)
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8E682C13@aquib01a>
References: <F1F6EC0C8B75034F9E3A79FC85122E8E682C13@aquib01a>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: multipart/alternative; boundary=Apple-Mail-5-926465750
Message-Id: <10FD4DC9-4047-43B9-A5DF-C1C29DF15109@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: __pa(dma_alloc_coherent()) doesn't give physical address
Date: Mon, 26 Feb 2007 11:26:33 -0500
To: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
Cc: ppc embedded list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--Apple-Mail-5-926465750
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed


On Feb 26, 2007, at 10:54 AM, DI BACCO ANTONIO - technolabs wrote:

> dma_alloc_coherent gives a kernel virtual address as a return address,

....and more.  Everything you need.
Read Documentation/DMA-API.txt

> applying __pa I expected a physical address.

You don't need to (and shouldn't) do this.


	-- Dan


--Apple-Mail-5-926465750
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1

<HTML><BODY style=3D"word-wrap: break-word; -khtml-nbsp-mode: space; =
-khtml-line-break: after-white-space; "><BR><DIV><DIV>On Feb 26, 2007, =
at 10:54 AM, DI BACCO ANTONIO - technolabs wrote:</DIV><BR =
class=3D"Apple-interchange-newline"><BLOCKQUOTE type=3D"cite"> =
<DIV><FONT face=3D"Arial" size=3D"2"><SPAN =
class=3D"606374515-26022007">dma_alloc_coherent gives a kernel virtual =
address as a return =
address,<BR></SPAN></FONT></DIV></BLOCKQUOTE><DIV><BR =
class=3D"khtml-block-placeholder"></DIV>....and more.=A0 Everything you =
need.</DIV><DIV>Read Documentation/DMA-API.txt</DIV><DIV><BR><BLOCKQUOTE =
type=3D"cite"><DIV><FONT face=3D"Arial" size=3D"2"><SPAN =
class=3D"606374515-26022007"> applying __pa I expected a physical =
address.</SPAN></FONT></DIV></BLOCKQUOTE><DIV><BR =
class=3D"khtml-block-placeholder"></DIV>You don't need to (and =
shouldn't) do this.</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV><SPAN =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</SPAN>-- =
Dan</DIV><BR class=3D"khtml-block-placeholder"></BODY></HTML>=

--Apple-Mail-5-926465750--
