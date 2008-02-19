Return-Path: <m.louvel@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.228])
	by ozlabs.org (Postfix) with ESMTP id 474CCDDEB6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Feb 2008 01:42:18 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so2268480wxd.15
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Feb 2008 06:42:16 -0800 (PST)
Message-ID: <dda529d0802190642n56ef7fbcx988ce8825bd315da@mail.gmail.com>
Date: Tue, 19 Feb 2008 14:42:16 +0000
From: "maxime louvel" <m.louvel@gmail.com>
To: "Jon Loeliger" <jdl@freescale.com>
Subject: Re: 2.6.24 for mpc8458amc
In-Reply-To: <47BAE6B3.7090000@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_9486_24828131.1203432136184"
References: <dda529d0802190359r526dc959y8117185e1834e9f4@mail.gmail.com>
	<47BAE6B3.7090000@freescale.com>
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

------=_Part_9486_24828131.1203432136184
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks for your answer,

I am going to check this ppc / powerpc things.
I should use the architecture powerpc, don't I?

I'm not really sure I have understand what do you want to do with a
BDI-2000.
I access the cards through a serial line directly.

cheers,
Maxime

On Feb 19, 2008 2:24 PM, Jon Loeliger <jdl@freescale.com> wrote:

> maxime louvel wrote:
> > Hi,
> >
> > I am trying to make a 2.6.24 vanilla kernel boot (an work fine in a
> > second time) on a mpc8548amc board.
> > I have add the platform specific stuff from the sources of the current
> > kernel running on the cards.
> > What I have basically add is:
> > - a folder mpc8548amc, in the config/platform directory, which allow to
> > select the mpc8548amc as the supported platform
> > - add the following files:
> >   - arch/ppc/configs/mpc8548amc_defconfig
> >   - arch/ppc/configs/platforms/85xx/mpc_8548_amc.h and .c
> > - I have used the dts of an another platform (mpc8548cds) which seems
> > quite the same, but I haven't got any confirmation of that yet.
>
> Uh, let's clear up minor confusion here.  Are you using
> ARCH=ppc or ARCH=powerpc?  I'm surprised to see that there
> is mention of arch/ppc/... above.  Are you sure this is an
> ARCH=ppc build?  You won't need a DTS file at all then.
>
> But if you are using a DTS file, and I suspect you should,
> then this is ARCH=powerpc.
>
> > When I am booting the kernel image I get:
> >
> > AMC=> dhcp 0x1000000 uImage.amc.2.6.24
> > Speed: 1000, full duplex
> > BOOTP broadcast 1
> > DHCP client bound to address 10.255.255.2 <http://10.255.255.2/>
> > Using eTSEC0 device
> > TFTP from server 0.0.0.0 <http://0.0.0.0/>; our IP address is
> > 10.255.255.2 <http://10.255.255.2/>; sending through gateway 10.1.1.1
> > <http://10.1.1.1/>
> > Filename 'uImage.amc.2.6.24'.
> > Load address: 0x1000000
> > Loading: ##############################
> > ###################################
> >
> #################################################################
> >
> #################################################################
> >
> #################################################################
> >
> #################################################################
> >         ###########################
> > done
> > Bytes transferred = 1802102 (1b7f76 hex)
> > AMC=> bootm 0x1000000
> > ## Booting image at 01000000 ...
> >   Image Name:   Linux-2.6.24
> >   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> >   Data Size:    1802038 Bytes =  1.7 MB
> >   Load Address: 00000000
> >   Entry Point:  00000000
> >   Verifying Checksum ... OK
> >   Uncompressing Kernel Image ... OK
> >
> > No further messages...
> >
> > Does someone has an idea ?
> >
> > thanks,
> > Maxime
> >
>
> Did you download a DTB file and use it on the bootm
> command?  Nope.
>
> This is really a FAQ failure mode.  Are you sure
> you have the console set up properly?  Any chance
> you can get to the __log_buf with a BDI-2000?
>
> Thanks,
> jdl
>



-- 
Maxime Louvel
0044 7964 5555 80
43 Allen road
Whitemore reans
WV60AW Wolverhampton
United Kingdom

------=_Part_9486_24828131.1203432136184
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks for your answer,<br><br>I am going to check this ppc / powerpc things.<br>I should use the architecture powerpc, don&#39;t I?<br><br>I&#39;m not really sure I have understand what do you want to do with a BDI-2000.<br>
I access the cards through a serial line directly.<br><br>cheers,<br>Maxime<br><br><div class="gmail_quote">On Feb 19, 2008 2:24 PM, Jon Loeliger &lt;<a href="mailto:jdl@freescale.com">jdl@freescale.com</a>&gt; wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class="Ih2E3d">maxime louvel wrote:<br>&gt; Hi,<br>&gt;<br>&gt; I am trying to make a 2.6.24 vanilla kernel boot (an work fine in a<br>
&gt; second time) on a mpc8548amc board.<br>&gt; I have add the platform specific stuff from the sources of the current<br>&gt; kernel running on the cards.<br>&gt; What I have basically add is:<br>&gt; - a folder mpc8548amc, in the config/platform directory, which allow to<br>
&gt; select the mpc8548amc as the supported platform<br>&gt; - add the following files:<br>&gt; &nbsp; - arch/ppc/configs/mpc8548amc_defconfig<br>&gt; &nbsp; - arch/ppc/configs/platforms/85xx/mpc_8548_amc.h and .c<br>&gt; - I have used the dts of an another platform (mpc8548cds) which seems<br>
&gt; quite the same, but I haven&#39;t got any confirmation of that yet.<br><br></div>Uh, let&#39;s clear up minor confusion here. &nbsp;Are you using<br>ARCH=ppc or ARCH=powerpc? &nbsp;I&#39;m surprised to see that there<br>is mention of arch/ppc/... above. &nbsp;Are you sure this is an<br>
ARCH=ppc build? &nbsp;You won&#39;t need a DTS file at all then.<br><br>But if you are using a DTS file, and I suspect you should,<br>then this is ARCH=powerpc.<br><div class="Ih2E3d"><br>&gt; When I am booting the kernel image I get:<br>
&gt;<br>&gt; AMC=&gt; dhcp 0x1000000 uImage.amc.2.6.24<br>&gt; Speed: 1000, full duplex<br>&gt; BOOTP broadcast 1<br></div>&gt; DHCP client bound to address <a href="http://10.255.255.2" target="_blank">10.255.255.2</a> &lt;<a href="http://10.255.255.2/" target="_blank">http://10.255.255.2/</a>&gt;<br>
&gt; Using eTSEC0 device<br>&gt; TFTP from server <a href="http://0.0.0.0" target="_blank">0.0.0.0</a> &lt;<a href="http://0.0.0.0/" target="_blank">http://0.0.0.0/</a>&gt;; our IP address is<br>&gt; <a href="http://10.255.255.2" target="_blank">10.255.255.2</a> &lt;<a href="http://10.255.255.2/" target="_blank">http://10.255.255.2/</a>&gt;; sending through gateway <a href="http://10.1.1.1" target="_blank">10.1.1.1</a><br>
&gt; &lt;<a href="http://10.1.1.1/" target="_blank">http://10.1.1.1/</a>&gt;<br><div class="Ih2E3d">&gt; Filename &#39;uImage.amc.2.6.24&#39;.<br>&gt; Load address: 0x1000000<br>&gt; Loading: ##############################<br>
&gt; ###################################<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; #################################################################<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; #################################################################<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; #################################################################<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; #################################################################<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; ###########################<br>&gt; done<br>&gt; Bytes transferred = 1802102 (1b7f76 hex)<br>&gt; AMC=&gt; bootm 0x1000000<br>
&gt; ## Booting image at 01000000 ...<br>&gt; &nbsp; Image Name: &nbsp; Linux-2.6.24<br>&gt; &nbsp; Image Type: &nbsp; PowerPC Linux Kernel Image (gzip compressed)<br>&gt; &nbsp; Data Size: &nbsp; &nbsp;1802038 Bytes = &nbsp;1.7 MB<br>&gt; &nbsp; Load Address: 00000000<br>
&gt; &nbsp; Entry Point: &nbsp;00000000<br>&gt; &nbsp; Verifying Checksum ... OK<br>&gt; &nbsp; Uncompressing Kernel Image ... OK<br>&gt;<br>&gt; No further messages...<br>&gt;<br>&gt; Does someone has an idea ?<br>&gt;<br>&gt; thanks,<br>&gt; Maxime<br>
&gt;<br><br></div>Did you download a DTB file and use it on the bootm<br>command? &nbsp;Nope.<br><br>This is really a FAQ failure mode. &nbsp;Are you sure<br>you have the console set up properly? &nbsp;Any chance<br>you can get to the __log_buf with a BDI-2000?<br>
<br>Thanks,<br>jdl<br></blockquote></div><br><br clear="all"><br>-- <br>Maxime Louvel<br>0044 7964 5555 80<br>43 Allen road<br>Whitemore reans<br>WV60AW Wolverhampton<br>United Kingdom

------=_Part_9486_24828131.1203432136184--
