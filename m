Return-Path: <huangjq@cn.ibm.com>
In-Reply-To: <f78eb6c06abb98fbc1cf8ae32bbf2268@penguinppc.org>
To: Hollis Blanchard <hollis@penguinppc.org>
MIME-Version: 1.0
Subject: Re: make install on ppc
Message-ID: <OF57751534.80AB0426-ON4825713F.00159DFD-4825713F.0015D975@cn.ibm.com>
From: Jin Qi Huang <huangjq@cn.ibm.com>
Date: Tue, 28 Mar 2006 11:59:50 +0800
Content-Type: multipart/alternative;
	boundary="=_alternative 0015D96A4825713F_="
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc-dev-bounces+huangjq=cn.ibm.com@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 0015D96A4825713F_=
Content-Type: text/plain; charset="US-ASCII"

Now on ia32, there are also a lot of bootloaders, currently 'make install' 
can update lilo and grub, on ppc desktop and enterprise computing, we 
mainly use yaboot as the bootloader, I think ppc 'make install' can at 
least support yaboot.

--
Regards,

MCP Test, Linux Technology Center, China Systems & Technology Lab
China Development Labs, Beijing      Email: huangjq@cn.ibm.com



Hollis Blanchard <hollis@penguinppc.org> 
Sent by: linuxppc-dev-bounces+huangjq=cn.ibm.com@ozlabs.org
2006-03-28 11:43

To
linuxppc-dev list <linuxppc-dev@ozlabs.org>
cc

Subject
Re: make install on ppc






On Mar 26, 2006, at 7:56 PM, Brent Cook wrote:

> On Sunday 26 March 2006 19:42, Jin Qi Huang wrote:
>> I also think the 'make install' is very useful, now on ia32, the 'make
>> install' provided by the latest kernel linux-2.6.16 not only create
>> initrd, copy vmlinuz and System.map to /boot directory, but also 
>> update
>> grub, ppc32 does not provide this useful feature, maybe it is a pity!

The feature sounds like a good idea to me, even if it's just the 
copying files part. Do any PPC distros provide a working installkernel 
script?

> Maybe narrow it to define 'make install' for new world/old world 
> Macintoshes,
> or IBM machines? I can't see a generic make install being useful for 
> the
> wider range of platforms that fall under ppc.
>
> 'make install' appears to me to be very platform dependent. Sure, on 
> x86, you
> can reasonably assume that the majority of systems have the kernel on 
> a disk
> under /boot and the bootloader is grub or lilo. I have 5 ppc machines
> currently, and no two use the same bootloader or kernel image. I've 
> seen
> u-boot, yaboot, quik, powerboot (Motorola/Force), xmon (XES) and more, 
> and
> they all required different post-processing to the kernel image to 
> boot. For
> most of these, there is no way to programmatically guess where a 
> particular
> kernel image should go to work with the boot loader.

If you have an unusual platform, don't run make install and you have 
lost nothing... :)

-Hollis

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev


--=_alternative 0015D96A4825713F_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Now on ia32, there are also a lot of
bootloaders, currently 'make install' can update lilo and grub, on ppc
desktop and enterprise computing, we mainly use yaboot as the bootloader,
I think ppc 'make install' can at least support yaboot.</font>
<br>
<br><font size=2 face="sans-serif">--<br>
Regards,<br>
<br>
MCP Test, Linux Technology Center, China Systems &amp; Technology Lab<br>
China Development Labs, Beijing &nbsp; &nbsp; &nbsp;Email: huangjq@cn.ibm.com</font>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td width=40%><font size=1 face="sans-serif"><b>Hollis Blanchard &lt;hollis@penguinppc.org&gt;</b>
</font>
<br><font size=1 face="sans-serif">Sent by: linuxppc-dev-bounces+huangjq=cn.ibm.com@ozlabs.org</font>
<p><font size=1 face="sans-serif">2006-03-28 11:43</font>
<td width=59%>
<table width=100%>
<tr>
<td>
<div align=right><font size=1 face="sans-serif">To</font></div>
<td valign=top><font size=1 face="sans-serif">linuxppc-dev list &lt;linuxppc-dev@ozlabs.org&gt;</font>
<tr>
<td>
<div align=right><font size=1 face="sans-serif">cc</font></div>
<td valign=top>
<tr>
<td>
<div align=right><font size=1 face="sans-serif">Subject</font></div>
<td valign=top><font size=1 face="sans-serif">Re: make install on ppc</font></table>
<br>
<table>
<tr valign=top>
<td>
<td></table>
<br></table>
<br>
<br>
<br><font size=2><tt>On Mar 26, 2006, at 7:56 PM, Brent Cook wrote:<br>
<br>
&gt; On Sunday 26 March 2006 19:42, Jin Qi Huang wrote:<br>
&gt;&gt; I also think the 'make install' is very useful, now on ia32, the
'make<br>
&gt;&gt; install' provided by the latest kernel linux-2.6.16 not only create<br>
&gt;&gt; initrd, copy vmlinuz and System.map to /boot directory, but also
<br>
&gt;&gt; update<br>
&gt;&gt; grub, ppc32 does not provide this useful feature, maybe it is
a pity!<br>
<br>
The feature sounds like a good idea to me, even if it's just the <br>
copying files part. Do any PPC distros provide a working installkernel
<br>
script?<br>
<br>
&gt; Maybe narrow it to define 'make install' for new world/old world <br>
&gt; Macintoshes,<br>
&gt; or IBM machines? I can't see a generic make install being useful for
<br>
&gt; the<br>
&gt; wider range of platforms that fall under ppc.<br>
&gt;<br>
&gt; 'make install' appears to me to be very platform dependent. Sure,
on <br>
&gt; x86, you<br>
&gt; can reasonably assume that the majority of systems have the kernel
on <br>
&gt; a disk<br>
&gt; under /boot and the bootloader is grub or lilo. I have 5 ppc machines<br>
&gt; currently, and no two use the same bootloader or kernel image. I've
<br>
&gt; seen<br>
&gt; u-boot, yaboot, quik, powerboot (Motorola/Force), xmon (XES) and more,
<br>
&gt; and<br>
&gt; they all required different post-processing to the kernel image to
<br>
&gt; boot. For<br>
&gt; most of these, there is no way to programmatically guess where a <br>
&gt; particular<br>
&gt; kernel image should go to work with the boot loader.<br>
<br>
If you have an unusual platform, don't run make install and you have <br>
lost nothing... :)<br>
<br>
-Hollis<br>
<br>
_______________________________________________<br>
Linuxppc-dev mailing list<br>
Linuxppc-dev@ozlabs.org<br>
https://ozlabs.org/mailman/listinfo/linuxppc-dev<br>
</tt></font>
<br>
--=_alternative 0015D96A4825713F_=--
