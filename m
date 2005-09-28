Return-Path: <peter.ryser@xilinx.com>
Received: from mail43-haw-R.bigfish.com (mail-haw.bigfish.com [12.129.199.61])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C4BE968400
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Sep 2005 19:39:43 +1000 (EST)
Message-ID: <433A631B.6000602@xilinx.com>
Date: Wed, 28 Sep 2005 02:32:11 -0700
From: Peter Ryser <peter.ryser@xilinx.com>
MIME-Version: 1.0
To: Tony Lee <tony.p.lee@gmail.com>
References: <OF9C3C40D4.4EC5E6BD-ON0725706C.0064A09D-0725706C.0065B9FC@mck.us.ray.com>	
	<4313FA43.1040206@xilinx.com>
	<470b639705083118114bcd2070@mail.gmail.com>
In-Reply-To: <470b639705083118114bcd2070@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="------------060803050704030108050009"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: linuxppc-2.4.30-pre1 crashes with root fs on Xilinx SystemACE
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060803050704030108050009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Some time ago we did some tests with bonnie++ on Linux running on the 
PPC405 in a Virtex-II Pro FPGA. You can expect the following performance:

Read peak: 629 KB/s
Write peak: 299 KB/s

Not considering network overhead, a 10MB file should take less than a 
minute to update.

- Peter


Tony Lee wrote:

> Keith, 
>
> Some suggestions, before you verify your hw board/FPGA works fine with 
> SYSACE,
>     * don't use sysace as root fs.
>     * use a ram fs as root fs.  
>     * Next, load sysace driver a loadable driver module.  It works, I 
> tried it.
>     * check mount read only and see if it works.
>     * Next, mount it writable.
>
> We have some issues with sysace driver initially, everything works out 
> fine later.
> There were small errors in our HW layout.
>
> I had to hack the sysace driver left and right to id the problem.  But 
> at the
> end, after I fixed the layout problem from the fpga's ucf file, the 
> original driver
> run perfectly without any modification.
>
> In my experiences, the ppc linux distribution and its linux sysace 
> driver are good
> if everything is setup correctly.
>
> One minor issues:  The sysace driver's write performance sucks.  I 
> have to explain
> to others why the upgrade 10 MBytes files with usb flash writer takes 
> tens of
> seconds.  When we do it from linux (nfs or ftp), it tooks minutes to sync.
>
> Peter, maybe you can push the xilinx a bit on sysace write 
> performance? :-)
>
> -Tony
>
> On 8/29/05, Peter Ryser <peter.ryser@xilinx.com 
> <mailto:peter.ryser@xilinx.com>> wrote:
>
>     Hi Keith,
>
>     I sent you a private email but for other interested people:
>     Downloading the latest linuxppc-2.4 kernel I could boot from and
>     access
>     System ACE CF without problems on a ML403 (Virtex-4, 4VFX12) and a
>     ML310
>     (Virtex-II Pro, 2VP30) using EDK 7.1.2. In both cases I started with
>     config_xilinx_ml300.
>
>     - Peter
>
>
>
>     Keith J Outwater wrote:
>
>     >Hello -
>     >Per a previous suggestion from this list, I rsynced the linuxppc-2.4
>     >kernel sources from MontaVista and modified the kernel to run on
>     my custom
>     >ppc405/VirtexII Pro based system with U-Boot as the bootloader.
>     >When I try to use the SystemACE device as the root filesystem,
>     the kernel
>     >crashes with a sig 11.  Looking at the 'oops' output it appears  the
>     >SystemACE driver may be to blame.  The crash is random -
>     sometimes I get
>     >all the way to login as root and then things crash on a file copy
>     or a
>     >file read.
>     >Before I start digging deeper, is anyone running a VirtexIIPro based
>     >system with the root filesystem in the CF card attached to a
>     SystemACE?
>     >I'm wondering if I really have the best kernel and SystemACE driver.
>     >BTW, I'm developing the hardware design using Xilinx EDK 7.02i.
>     >Thanks,
>     >Keith
>     >_______________________________________________
>     >Linuxppc-embedded mailing list
>     > Linuxppc-embedded@ozlabs.org <mailto:Linuxppc-embedded@ozlabs.org>
>     >https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>     >
>     >
>     >
>     >
>
>
>
>     _______________________________________________
>     Linuxppc-embedded mailing list
>     Linuxppc-embedded@ozlabs.org <mailto:Linuxppc-embedded@ozlabs.org>
>     https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>     <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>
>
>
>
>
> -- 
> -Tony
> Having fun with FPGA HW + ppc + Linux


--------------060803050704030108050009
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
Some time ago we did some tests with bonnie++ on Linux running on the
PPC405 in a Virtex-II Pro FPGA. You can expect the following
performance:<br>
<pre wrap="">Read peak: 629 KB/s
Write peak: 299 KB/s</pre>
Not considering network overhead, a 10MB file should take less than a
minute to update.<br>
<br>
- Peter<br>
<br>
<br>
Tony Lee wrote:<br>
<blockquote type="cite"
 cite="mid470b639705083118114bcd2070@mail.gmail.com">Keith,&nbsp; <br>
  <br>
Some suggestions, before you verify your hw board/FPGA works fine with
SYSACE, <br>
&nbsp;&nbsp;&nbsp; * don't use sysace as root fs.<br>
&nbsp;&nbsp;&nbsp; * use a ram fs as root fs.&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; * Next, load sysace driver a loadable driver module.&nbsp; It works, I
tried it.<br>
&nbsp;&nbsp;&nbsp; * check mount read only and see if it works.<br>
&nbsp;&nbsp;&nbsp; * Next, mount it writable.<br>
  <br>
We have some issues with sysace driver initially, everything works out
fine later.<br>
There were small errors in our HW layout.<br>
  <br>
I had to hack the sysace driver left and right to id the problem.&nbsp; But
at the <br>
end, after I fixed the layout problem from the fpga's ucf file, the
original driver<br>
run perfectly without any modification.<br>
  <br>
In my experiences, the ppc linux distribution and its linux sysace
driver are good<br>
if everything is setup correctly.<br>
  <br>
One minor issues:&nbsp; The sysace driver's write performance sucks.&nbsp; I have
to explain<br>
to others why the upgrade 10 MBytes files with usb flash writer takes
tens of <br>
seconds.&nbsp; When we do it from linux (nfs or ftp), it tooks minutes to
sync.<br>
  <br>
Peter, maybe you can push the xilinx a bit on sysace write performance?
:-)<br>
  <br>
-Tony<br>
  <br>
  <div><span class="gmail_quote">On 8/29/05, <b
 class="gmail_sendername">Peter Ryser</b> &lt;<a
 href="mailto:peter.ryser@xilinx.com">peter.ryser@xilinx.com</a>&gt;
wrote:</span>
  <blockquote class="gmail_quote"
 style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi
Keith,<br>
    <br>
I sent you a private email but for other interested people:<br>
Downloading the latest linuxppc-2.4 kernel I could boot from and access<br>
System ACE CF without problems on a ML403 (Virtex-4, 4VFX12) and a
ML310
    <br>
(Virtex-II Pro, 2VP30) using EDK 7.1.2. In both cases I started with<br>
config_xilinx_ml300.<br>
    <br>
- Peter<br>
    <br>
    <br>
    <br>
Keith J Outwater wrote:<br>
    <br>
&gt;Hello -<br>
&gt;Per a previous suggestion from this list, I rsynced the linuxppc-2.4<br>
&gt;kernel sources from MontaVista and modified the kernel to run on my
custom<br>
&gt;ppc405/VirtexII Pro based system with U-Boot as the bootloader.<br>
&gt;When I try to use the SystemACE device as the root filesystem, the
kernel
    <br>
&gt;crashes with a sig 11.&nbsp;&nbsp;Looking at the 'oops' output it appears&nbsp;&nbsp;the<br>
&gt;SystemACE driver may be to blame.&nbsp;&nbsp;The crash is random - sometimes
I get<br>
&gt;all the way to login as root and then things crash on a file copy
or a
    <br>
&gt;file read.<br>
&gt;Before I start digging deeper, is anyone running a VirtexIIPro based<br>
&gt;system with the root filesystem in the CF card attached to a
SystemACE?<br>
&gt;I'm wondering if I really have the best kernel and SystemACE
driver.
    <br>
&gt;BTW, I'm developing the hardware design using Xilinx EDK 7.02i.<br>
&gt;Thanks,<br>
&gt;Keith<br>
&gt;_______________________________________________<br>
&gt;Linuxppc-embedded mailing list<br>
&gt;<a href="mailto:Linuxppc-embedded@ozlabs.org">
Linuxppc-embedded@ozlabs.org</a><br>
&gt;<a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
    <br>
    <br>
    <br>
_______________________________________________
    <br>
Linuxppc-embedded mailing list<br>
    <a href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a><br>
    <a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded
    </a><br>
  </blockquote>
  </div>
  <br>
  <br clear="all">
  <br>
-- <br>
-Tony<br>
Having fun with FPGA HW + ppc + Linux<br>
</blockquote>
</body>
</html>

--------------060803050704030108050009--
