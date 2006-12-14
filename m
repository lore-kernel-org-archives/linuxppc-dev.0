Return-Path: <wmaxfield@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id A171567CCD
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Dec 2006 06:46:13 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id b21so227864ana
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Dec 2006 11:46:11 -0800 (PST)
Message-ID: <45a1b53e0612141146x307bf30au7ec3317255ccda53@mail.gmail.com>
Date: Thu, 14 Dec 2006 13:46:10 -0600
From: "Wade Maxfield" <wmaxfield@gmail.com>
To: "Peter Ryser" <peter.ryser@xilinx.com>
Subject: Re: system ace programming xf60
In-Reply-To: <4581A3F2.3010901@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_176125_13394931.1166125570734"
References: <45a1b53e0612140805p589b5bdfpd4fb3347cdb60ded@mail.gmail.com>
	<4581A3F2.3010901@xilinx.com>
Cc: ppc <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_176125_13394931.1166125570734
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Peter,

  Thanks, we had that already.  The 8.1i development environment refused to
build until we fixed that.

  See my other reply to let you know how we did it.  The genace.tcl file
shipped with 8.1i (service pack 3) has an incorrect ID code for the xf60
part.  That threw us off for over a day, as the tool can't find an irlength
for that invalid part (since the part ID does not exist.)  Rather than
erroring with an "invalid id code," it gives an "invalid instruction length"
error, which was not useful at that time.

thanks,
wade

On 12/14/06, Peter Ryser <peter.ryser@xilinx.com> wrote:
>
>  Wade,
>
> the v4fx60 has two PPC405. Please make sure that both PPC405 are connected
> to the jtagppc_cntrl in your MHS hardware project file. You might want to
> compare your setup with the ML410 reference design available at
> http://www.xilinx.com/products/boards/ml410/designs/ml410_bsb_design.zip.
>
> The JTAG IR length of the v4fx60 is 14 (6 for the FPGA + 4 for each
> PPC405, i.e. for the 4vfx60 it's 6+4+4=14)
>
> - Peter
>
>
> Wade Maxfield wrote:
>
> Hi,
>
>   We are trying to generate a system ace file that will program an xf60
> using Xilinx scripts,
> (and even their impact GUI), using 8.1i, service pack 3 EDK.
>
>   Unfortunately, if we choose the ml410 board from Xilinx's genace.tclscript
> in their EDK/data/xmd directory, it errors with an invalid instruction
> register length.
> The irlength is listed as 14 in the xilinx script files.  I looked and
> googled and could
> not find the irlength listed for that xf60 part in any literature.
>
>   Also, if we try to include the zImage.elf file, the script errors out.
>
>   Conversely, if we choose an ml403 board (and switch the project to the
> xf12 chip),
> we can combine the zImage.elf file and generate a system.ace file that
> loads on an
> ml403 board.
>
>   We can take the download.bit file that refuses to load when combined
> into the system.ace,
> and load it over the jtag port.  It programs the xf60 just fine.
>
>   If we create an empty system.ace file,  the system ace chip on our board
> signals everything is ok,
> but of course, the xilinx chip is not programmed.  If we pull the compact
> flash out of the board,
> the system ace chip signals that is can't find the compact flash by
> flashing the error light.
>
>   Has anyone on this list had any experience with this that could lead us
> in a right direction?  We've
> tried about 10 different combinations so far with no luck.
>
> thanks,
> wade
>
> ------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.orghttps://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>

------=_Part_176125_13394931.1166125570734
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Peter,<br><br>&nbsp; Thanks, we had that already.&nbsp; The 8.1i development environment refused to build until we fixed that.<br><br>&nbsp; See my other reply to let you know how we did it.&nbsp; The genace.tcl file shipped with 8.1i (service pack 3) has an incorrect ID code for the xf60 part.&nbsp; That threw us off for over a day, as the tool can't find an irlength for that invalid part (since the part ID does not exist.)&nbsp; Rather than erroring with an &quot;invalid id code,&quot; it gives an &quot;invalid instruction length&quot; error, which was not useful at that time.
<br><br>thanks,<br>wade<br><br><div><span class="gmail_quote">On 12/14/06, <b class="gmail_sendername">Peter Ryser</b> &lt;<a href="mailto:peter.ryser@xilinx.com">peter.ryser@xilinx.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">



  
  

<div bgcolor="#ffffff" text="#000000">
Wade,<br>
<br>
the v4fx60 has two PPC405. Please make sure that both PPC405 are
connected to the jtagppc_cntrl in your MHS hardware project file. You
might want to compare your setup with the ML410 reference design
available at
<a href="http://www.xilinx.com/products/boards/ml410/designs/ml410_bsb_design.zip" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">http://www.xilinx.com/products/boards/ml410/designs/ml410_bsb_design.zip
</a>.<br>
<br>
The JTAG IR length of the v4fx60 is 14 (6 for the FPGA + 4 for each
PPC405, i.e. for the 4vfx60 it's 6+4+4=14)<br>
<br>
- Peter<br>
<br>
<br>
Wade Maxfield wrote:<br>
<blockquote cite="http://mid45a1b53e0612140805p589b5bdfpd4fb3347cdb60ded@mail.gmail.com" type="cite"><div><span class="e" id="q_10f8269ed4e1f096_1">Hi,<br>
  <br>
&nbsp; We are trying to generate a system ace file that will program an xf60
using Xilinx scripts, <br>
(and even their impact GUI), using 8.1i, service pack 3 EDK.<br>
  <br>
&nbsp; Unfortunately, if we choose the ml410 board from Xilinx's genace.tcl
script <br>
in their EDK/data/xmd directory, it errors with an invalid instruction
register length.<br>
The irlength is listed as 14 in the xilinx script files.&nbsp; I looked and
googled and could<br>
not find the irlength listed for that xf60 part in any literature.
  <br>
  <br>
&nbsp; Also, if we try to include the zImage.elf file, the script errors out.<br>
  <br>
&nbsp; Conversely, if we choose an ml403 board (and switch the project to
the xf12 chip), <br>
we can combine the zImage.elf file and generate a system.ace file that
loads on an<br>
ml403 board.<br>
  <br>
&nbsp; We can take the download.bit file that refuses to load when combined
into the system.ace, <br>
and load it over the jtag port.&nbsp; It programs the xf60 just fine.<br>
  <br>
&nbsp; If we create an empty system.ace file,&nbsp; the system ace chip on our
board signals everything is ok,<br>
but of course, the xilinx chip is not programmed.&nbsp; If we pull the
compact flash out of the board,<br>
the system ace chip signals that is can't find the compact flash by
flashing the error light.
  <br>
  <br>
&nbsp; Has anyone on this list had any experience with this that could lead
us in a right direction?&nbsp; We've<br>
tried about 10 different combinations so far with no luck.<br>
  <br>
thanks,<br>
wade<br>
  </span></div><pre><hr size="4" width="90%">
_______________________________________________<br>Linuxppc-embedded mailing list<br><a href="mailto:Linuxppc-embedded@ozlabs.org" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">Linuxppc-embedded@ozlabs.org
</a>
<a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a></pre>
</blockquote>
</div>


<br>_______________________________________________<br>Linuxppc-embedded mailing list<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded" target="_blank">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br><br></blockquote></div>
<br>

------=_Part_176125_13394931.1166125570734--
