Return-Path: <wmaxfield@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id C225A67C47
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Dec 2006 06:14:58 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so586191ugf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Dec 2006 11:14:56 -0800 (PST)
Message-ID: <45a1b53e0612141114w2eb8a89tbf1ee3d288684a5a@mail.gmail.com>
Date: Thu, 14 Dec 2006 13:14:56 -0600
From: "Wade Maxfield" <wmaxfield@gmail.com>
To: "Sharon Feldman" <sharonf@scopus.net>
Subject: Re: system ace programming xf60
In-Reply-To: <8506C3905ED0764F889ADEB33E3A9E8062CF8A@MAIA.scopus.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_175465_6434920.1166123696066"
References: <8506C3905ED0764F889ADEB33E3A9E8062CF8A@MAIA.scopus.net>
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

------=_Part_175465_6434920.1166123696066
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Sharon,

   Thank you!   I found the irlength (called INSTRUCTION_LENGTH) in the file
xc4vfx60_ff1152.bsd and it is indeed 14.

   We are running a custom board that looks like an ml410, with only one
device, the xf60 (in addition to the system ace chip), which is exactly what
the genace.tcl file specifies.  We do have  a cpld as a second part, but we
are not programming it. The genace.tcl file in the Xininx/data/xmd directory
was incorrect in how it listed the device IDCODE on the part.  It had
0x01eb409, the real code is 0x1EB4093.  Once the code was fixed in the file,
the genace.tcl created system.ace bundling the zImage.elf file into it
correctly.

    However, we are not yet getting a xilinx program load.  Onward through
the fog!

    We can program the xilinx through the system ace using the jtag, but we
cannot get the system ace to program it from the system.ace on the compact
flash, generated using the same download.bit we use over the jtag.

wade



On 12/14/06, Sharon Feldman <sharonf@scopus.net> wrote:
>
>  the INSTRUCTION_LENGTH attribute can be found in The Device BSDL File.
>
> As Much As I Know It Is 14 For All FX60 Devices.
>
> BSDL .bsd File Are Found Under :
>
> C:\Xilinx\virtex4\data
>
> Are You Sure You Are Accessing The Wright Device On The Chain ?
> It Is Possible That The Number Of Xilinx FPGA Has Changed In ML410. (It Is
> 3 In ML403),
> In ML410 There Is No CPLD, So I Guess It Is Probebly 2 Now.
>
>
> -----Original Message-----
> *From:* linuxppc-embedded-bounces+sharonf=scopus.net@ozlabs.org [mailto:
> linuxppc-embedded-bounces+sharonf=scopus.net@ozlabs.org]*On Behalf Of *Wade
> Maxfield
> *Sent:* Thursday, December 14, 2006 6:06 PM
> *To:* ppc
> *Subject:* system ace programming xf60
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
>

------=_Part_175465_6434920.1166123696066
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Sharon,<br><br>&nbsp;&nbsp; Thank you!&nbsp;&nbsp; I found the irlength (called INSTRUCTION_LENGTH) in the file xc4vfx60_ff1152.bsd and it is indeed 14.<br><br>&nbsp;&nbsp; We are running a custom board that looks like an ml410, with only one device, the xf60 (in addition to the system ace chip), which is exactly what the 
genace.tcl file specifies.&nbsp; We do have&nbsp; a cpld as a second part, but we are not programming it. The genace.tcl file in the Xininx/data/xmd directory was incorrect in how it listed the device IDCODE on the part.&nbsp; It had&nbsp; 0x01eb409, the real code is 0x1EB4093.&nbsp; Once the code was fixed in the file, the 
genace.tcl created system.ace bundling the zImage.elf file into it correctly.<br><br>&nbsp;&nbsp;&nbsp; However, we are not yet getting a xilinx program load.&nbsp; Onward through the fog!<br><br>&nbsp;&nbsp;&nbsp; We can program the xilinx through the system ace using the jtag, but we cannot get the system ace to program it from the 
system.ace on the compact flash, generated using the same download.bit we use over the jtag.<br><br>wade<br><br><br><br><div><span class="gmail_quote">On 12/14/06, <b class="gmail_sendername">Sharon Feldman</b> &lt;<a href="mailto:sharonf@scopus.net">
sharonf@scopus.net</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">





<div>
<div><span><font color="#0000ff" face="Arial" size="2">the 
INSTRUCTION_LENGTH attribute can be found in The Device BSDL 
File.</font></span></div>
<div><span><font color="#0000ff" face="Arial" size="2"></font></span>&nbsp;</div>
<div><span><font color="#0000ff" face="Arial" size="2">As 
Much As I Know It Is 14 For All FX60 Devices.</font></span></div>
<div><span><font color="#0000ff" face="Arial" size="2"></font></span>&nbsp;</div>
<div><span><font color="#0000ff" face="Arial" size="2">BSDL 
.bsd File Are Found Under :</font></span></div>
<div><span><font color="#0000ff" face="Arial" size="2"></font></span>&nbsp;</div>
<div><span><font color="#0000ff" face="Arial" size="2">C:\Xilinx\virtex4\data</font></span></div>
<div><span><font color="#0000ff" face="Arial" size="2"></font></span>&nbsp;</div>
<div><span><font color="#0000ff" face="Arial" size="2">Are 
You Sure You Are Accessing The Wright Device On The Chain ?</font></span></div>
<div><span><font color="#0000ff" face="Arial" size="2">It Is 
Possible That The Number Of Xilinx FPGA Has Changed In ML410. (It Is 3 In 
ML403),</font></span></div>
<div><span><font color="#0000ff" face="Arial" size="2">In 
ML410 There Is No CPLD, So I Guess It Is Probebly 2 Now.</font></span></div>
<div><span><font color="#0000ff" face="Arial" size="2"></font></span>&nbsp;</div>
<blockquote>
  <div dir="ltr" align="left"><font face="Tahoma" size="2">-----Original Message-----<br><b>From:</b> 
  linuxppc-embedded-bounces+sharonf=<a href="mailto:scopus.net@ozlabs.org" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">scopus.net@ozlabs.org</a> 
  [mailto:<a href="mailto:linuxppc-embedded-bounces+sharonf=scopus.net@ozlabs.org" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">linuxppc-embedded-bounces+sharonf=scopus.net@ozlabs.org</a>]<b>On Behalf 
  Of </b>Wade Maxfield<br><b>Sent:</b> Thursday, December 14, 2006 6:06 
  PM<br><b>To:</b> ppc<br><b>Subject:</b> system ace programming 
  xf60<br><br></font></div>Hi,<br><br>&nbsp; We are trying to generate a system 
  ace file that will program an xf60 using Xilinx scripts, <br>(and even their 
  impact GUI), using 8.1i, service pack 3 EDK.<br><br>&nbsp; Unfortunately, if 
  we choose the ml410 board from Xilinx's genace.tcl script <br>in their 
  EDK/data/xmd directory, it errors with an invalid instruction register 
  length.<br>The irlength is listed as 14 in the xilinx script files.&nbsp; I 
  looked and googled and could<br>not find the irlength listed for that xf60 
  part in any literature. <br><br>&nbsp; Also, if we try to include the 
  zImage.elf file, the script errors out.<br><br>&nbsp; Conversely, if we choose 
  an ml403 board (and switch the project to the xf12 chip), <br>we can combine 
  the zImage.elf file and generate a system.ace file that loads on an<br>ml403 
  board.<br><br>&nbsp; We can take the download.bit file that refuses to load 
  when combined into the system.ace, <br>and load it over the jtag port.&nbsp; 
  It programs the xf60 just fine.<br><br>&nbsp; If we create an empty system.ace 
  file,&nbsp; the system ace chip on our board signals everything is ok,<br>but 
  of course, the xilinx chip is not programmed.&nbsp; If we pull the compact 
  flash out of the board,<br>the system ace chip signals that is can't find the 
  compact flash by flashing the error light. <br><br>&nbsp; Has anyone on this 
  list had any experience with this that could lead us in a right 
  direction?&nbsp; We've<br>tried about 10 different combinations so far with no 
  luck.<br><br>thanks,<br>wade<br></blockquote></div>

</blockquote></div><br>

------=_Part_175465_6434920.1166123696066--
