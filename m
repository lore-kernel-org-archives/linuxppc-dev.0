Return-Path: <jhautbois@gmail.com>
Received: from mail-bw0-f10.google.com (mail-bw0-f10.google.com
	[209.85.218.10]) by ozlabs.org (Postfix) with ESMTP id 1E033DE25F
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 02:06:15 +1100 (EST)
Received: by bwz3 with SMTP id 3so3407083bwz.9
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 07:06:13 -0800 (PST)
Message-ID: <8cad0aa0901150706u72538941rbc22655d5a8905ea@mail.gmail.com>
Date: Thu, 15 Jan 2009 16:06:06 +0100
From: "Jean-Michel Hautbois" <jhautbois@gmail.com>
To: "Anatolij Gustschin" <agust@denx.de>
Subject: Re: [MPC8272ADS]Cannot start my Linux Kernel
In-Reply-To: <496F4760.1010007@denx.de>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_11823_13410472.1232031966165"
References: <8cad0aa0901150342s2362e53bqf9472c1dc239636c@mail.gmail.com>
	<496F318D.6010302@denx.de>
	<8cad0aa0901150510o7a8146f1m2045e252c5e1cf24@mail.gmail.com>
	<496F4760.1010007@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_11823_13410472.1232031966165
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2009/1/15 Anatolij Gustschin <agust@denx.de>

> Jean-Michel Hautbois wrote:
> > I just tried. I created a dtb from the file
> > arch/powerpc/boot/dst/mpc8272ads.dts file.
> > It is not rebboting, but handling (my "run" led is switching off).
> >
> > => tftp 2000000 mpc8272ads.dtb
> > Using FCC1 ETHERNET device
> > TFTP from server 10.0.0.1; our IP address is 10.0.0.2
> > Filename 'mpc8272ads.dtb'.
> > Load address: 0x2000000
> > Loading: #
> > done
> > Bytes transferred = 4442 (115a hex)
> > => bootm FF800000 FF980000 2000000
> > ## Booting kernel from Legacy Image at ff800000 ...
> >    Image Name:   Linux-2.6.29-rc1-01197-g5a7b6e7-
> >    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> >    Data Size:    1487167 Bytes =  1.4 MB
> >    Load Address: 00000000
> >    Entry Point:  00000000
> >    Verifying Checksum ... OK
> > ## Loading init Ramdisk from Legacy Image at ff980000 ...
> >    Image Name:   Simple Embedded Linux Framework
> >    Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
> >    Data Size:    1730966 Bytes =  1.7 MB
> >    Load Address: 00000000
> >    Entry Point:  00000000
> >    Verifying Checksum ... OK
> > ## Flattened Device Tree blob at 02000000
> >    Booting using the fdt blob at 0x2000000
> >    Uncompressing Kernel Image ... OK
> >    Loading Ramdisk to 039d7000, end 03b7d996 ... OK
> >    Loading Device Tree to 007fb000, end 007ff159 ... OK
> > Unable to update property /cpus/cpu@0:bus-frequency,
> err=FDT_ERR_NOTFOUND
> > Unable to update property /cpus/cpu@0:timebase-frequency,
> > err=FDT_ERR_NOTFOUND
> > Unable to update property /cpus/cpu@0:clock-frequency,
> err=FDT_ERR_NOTFOUND
>
> try to fix "ft_cpu_setup()" in your u-boot source for mpc8272ads
> and use "PowerPC,8272@0" as cpu_path instead of "cpu@0".
>
> Best regards,
> Anatolij
>

I don't have the three errors relative to cpu@0, but it still handles...

------=_Part_11823_13410472.1232031966165
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div class="gmail_quote">2009/1/15 Anatolij Gustschin <span dir="ltr">&lt;<a href="mailto:agust@denx.de">agust@denx.de</a>&gt;</span><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div class="Wj3C7c">Jean-Michel Hautbois wrote:<br>
&gt; I just tried. I created a dtb from the file<br>
&gt; arch/powerpc/boot/dst/mpc8272ads.dts file.<br>
&gt; It is not rebboting, but handling (my &quot;run&quot; led is switching off).<br>
&gt;<br>
&gt; =&gt; tftp 2000000 mpc8272ads.dtb<br>
&gt; Using FCC1 ETHERNET device<br>
&gt; TFTP from server 10.0.0.1; our IP address is 10.0.0.2<br>
&gt; Filename &#39;mpc8272ads.dtb&#39;.<br>
&gt; Load address: 0x2000000<br>
&gt; Loading: #<br>
&gt; done<br>
&gt; Bytes transferred = 4442 (115a hex)<br>
&gt; =&gt; bootm FF800000 FF980000 2000000<br>
&gt; ## Booting kernel from Legacy Image at ff800000 ...<br>
&gt; &nbsp; &nbsp;Image Name: &nbsp; Linux-2.6.29-rc1-01197-g5a7b6e7-<br>
&gt; &nbsp; &nbsp;Image Type: &nbsp; PowerPC Linux Kernel Image (gzip compressed)<br>
&gt; &nbsp; &nbsp;Data Size: &nbsp; &nbsp;1487167 Bytes = &nbsp;1.4 MB<br>
&gt; &nbsp; &nbsp;Load Address: 00000000<br>
&gt; &nbsp; &nbsp;Entry Point: &nbsp;00000000<br>
&gt; &nbsp; &nbsp;Verifying Checksum ... OK<br>
&gt; ## Loading init Ramdisk from Legacy Image at ff980000 ...<br>
&gt; &nbsp; &nbsp;Image Name: &nbsp; Simple Embedded Linux Framework<br>
&gt; &nbsp; &nbsp;Image Type: &nbsp; PowerPC Linux RAMDisk Image (gzip compressed)<br>
&gt; &nbsp; &nbsp;Data Size: &nbsp; &nbsp;1730966 Bytes = &nbsp;1.7 MB<br>
&gt; &nbsp; &nbsp;Load Address: 00000000<br>
&gt; &nbsp; &nbsp;Entry Point: &nbsp;00000000<br>
&gt; &nbsp; &nbsp;Verifying Checksum ... OK<br>
&gt; ## Flattened Device Tree blob at 02000000<br>
&gt; &nbsp; &nbsp;Booting using the fdt blob at 0x2000000<br>
&gt; &nbsp; &nbsp;Uncompressing Kernel Image ... OK<br>
&gt; &nbsp; &nbsp;Loading Ramdisk to 039d7000, end 03b7d996 ... OK<br>
&gt; &nbsp; &nbsp;Loading Device Tree to 007fb000, end 007ff159 ... OK<br>
&gt; Unable to update property /cpus/cpu@0:bus-frequency, err=FDT_ERR_NOTFOUND<br>
&gt; Unable to update property /cpus/cpu@0:timebase-frequency,<br>
&gt; err=FDT_ERR_NOTFOUND<br>
&gt; Unable to update property /cpus/cpu@0:clock-frequency, err=FDT_ERR_NOTFOUND<br>
<br>
</div></div>try to fix &quot;ft_cpu_setup()&quot; in your u-boot source for mpc8272ads<br>
and use &quot;PowerPC,8272@0&quot; as cpu_path instead of &quot;cpu@0&quot;.<br>
<br>
Best regards,<br>
<font color="#888888">Anatolij<br>
</font></blockquote></div><br>I don&#39;t have the three errors relative to cpu@0, but it still handles...<br>

------=_Part_11823_13410472.1232031966165--
