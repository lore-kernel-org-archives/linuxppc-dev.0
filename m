Return-Path: <radanter@googlemail.com>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.236])
	by ozlabs.org (Postfix) with ESMTP id D31FBDDE25
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Jul 2007 21:20:42 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id e11so1033750qbe
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Jul 2007 04:20:40 -0700 (PDT)
Message-ID: <f75c52840707280420q3a051840s598a30a7bbc35ebc@mail.gmail.com>
Date: Sat, 28 Jul 2007 12:20:40 +0100
From: "Richard Danter" <radanter@googlemail.com>
To: "Chong, Zhia Howe" <zhia.howe.chong@intel.com>
Subject: Re: EST's VisionClick debugger fixes for Elf files from GNU tools
In-Reply-To: <ED3AB1534F018544848A18EE0E01E0AC117CCB@pgsmsx414.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3853_27835189.1185621640094"
References: <ED3AB1534F018544848A18EE0E01E0AC117CCB@pgsmsx414.gar.corp.intel.com>
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

------=_Part_3853_27835189.1185621640094
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 25/07/07, Chong, Zhia Howe <zhia.howe.chong@intel.com> wrote:
>
>  Hi,
>
>             I am currently learning to use VisionClick with the VisionICE
> II debugger. Are you aware of using it in Linux? I can only use in VxWorks
> OS. If you know how to use in Linux, mind show me some steps in doing it?
>

Yes, depending on what version of vClick and vICE  firmware you have it is
possible to debug some things in Linux. What are you trying to do exactly?
Debug the kernel, modules, applications? What is the target? vClick is old
now, Wind River has newer and much better JTAG/BDM tools (Workbench OCD) for
working with Linux.

Rich

------=_Part_3853_27835189.1185621640094
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 25/07/07, <b class="gmail_sendername">Chong, Zhia Howe</b> &lt;<a href="mailto:zhia.howe.chong@intel.com">zhia.howe.chong@intel.com</a>&gt; wrote:<div><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">









<div link="blue" vlink="purple" lang="EN-US">

<div>

<p><font face="Arial" size="2"><span style="font-size: 10pt; font-family: Arial;">Hi,</span></font></p>

<p><font face="Arial" size="2"><span style="font-size: 10pt; font-family: Arial;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
I am currently learning to use VisionClick with the VisionICE II debugger. Are
you aware of using it in Linux? I can only use in VxWorks OS. If you know how
to use in Linux, mind show me some steps in doing it? </span></font></p></div></div></blockquote><div><br>Yes, depending on what version of vClick and vICE&nbsp; firmware you have it
is possible to debug some things in Linux. What are you trying to do
exactly? Debug the kernel, modules, applications? What is the target?
vClick is old now, Wind River has newer and much better JTAG/BDM tools
(Workbench OCD) for working with Linux.<br>
<br>
Rich<br><br></div></div>

------=_Part_3853_27835189.1185621640094--
