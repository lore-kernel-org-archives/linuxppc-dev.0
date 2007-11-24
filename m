Return-Path: <narendra.sisodiya@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.191])
	by ozlabs.org (Postfix) with ESMTP id 765A7DDE00
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Nov 2007 11:09:34 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so2601126rvf
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Nov 2007 16:09:33 -0800 (PST)
Message-ID: <e3fb97f30711231609o78dae895jd564e32cc447eaf8@mail.gmail.com>
Date: Sat, 24 Nov 2007 05:39:32 +0530
From: "narendra sisodiya" <narendra.sisodiya@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: Linux on ML310
In-Reply-To: <fa686aa40711231517x2f71d8dcv43c58860a052b52c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_42763_8526161.1195862972876"
References: <e3fb97f30711231452t473f7949x901e4921c20ec699@mail.gmail.com>
	<fa686aa40711231517x2f71d8dcv43c58860a052b52c@mail.gmail.com>
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

------=_Part_42763_8526161.1195862972876
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks
after getting driver from your site http://git.secretlab.ca/  will the
2.6kernel work fine completely?
What will be the advantage of 2.6 in context to embedded systems.

Actually
I am trying to design is a Video Streaming over RF. I need to transfer
320x240 @ 60 fps video from machine to one / many display systems.

By some method I will try to add a CMOS digital camera to ML310 board (any
suggestion) and Probability i need to build a small system for frame
buffering and then I heard about the Darwin Streaming server. So i will try
to install a tiny Darwin Streaming server on Linux system. Probably I need
to write a small application (or may be driver ) also which will fetch
frames from frame buffer and handle over to server.

For RF interface i want to go with WUSB2.0 ( wireless USB 2.0 ) but due to
some problem my adviser told me to think about blue tooth interface and
perhaps i need to work with blueZ.

I am unable to think for the whole setup and connectivity between various
module. Actually I need to do this my own but i am not getting the whole
picture on which i should work. Can anybody help me out ?? I will be highly
Thankful

Thanks and Regards

On Nov 24, 2007 4:47 AM, Grant Likely <grant.likely@secretlab.ca> wrote:

> On 11/23/07, narendra sisodiya <narendra.sisodiya@gmail.com> wrote:
> > Hi, I am working ML310 XUP virtex2Pro board. My task is to port a Linux
> > 2.4.26 on PowerPC405. I am on the mid way
> > I have following question.
> >
> >
> > Why in every document Linux kernel 2.4.26 is used, can i use 2.6.xxversion.
> > If yes what will be the modifications,
>
> Mainline 2.6.x has support for the virtex device but it is missing
> some drivers for EMAC, TEMAC and some other devices.
>
> You can get the drivers from my tree at http://git.secretlab.ca/ or
> from the xilinx git server http://git.xilinx.com
>
> > In document some are using busybox for making root file system and in
> some
> > Yellow Dog Linux. so what are the such possible options?
>
> Yellow Dog isn't a very good choice for the ppc405 with no floating
> point unit.  Use an embedded distro like ELDK, or build your own using
> buildroot or openembedded
>
> > If any body has done some project then Please share your experience with
> me.
> >
> >
> > --
> > Narendra Sisodiya
> > MTech (Computer Technology), IIT Delhi
> > +91-9999232792
> > http://www.techfandu.org/index.html
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> grant.likely@secretlab.ca
> (403) 399-0195
>



-- 
Narendra Sisodiya
MTech (Computer Technology), IIT Delhi
+91-9999232792
http://www.techfandu.org/index.html

------=_Part_42763_8526161.1195862972876
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks <br>after getting driver from your site  <a href="http://git.secretlab.ca/" target="_blank">http://git.secretlab.ca/</a>&nbsp; will the 2.6 kernel work fine completely? <br>What will be the advantage of 2.6 in context to embedded systems.
<br><br>Actually <br>I am trying to design is a Video Streaming over RF. I need to transfer 320x240 @ 60 fps video from machine to one / many display systems.<br><br>By some method I will try to add a CMOS digital camera to ML310 board (any suggestion) and Probability i need to build a small system for frame buffering and then I heard about the Darwin Streaming server. So i will try to install a tiny Darwin Streaming server on Linux system. Probably I need to write a small application (or may be driver ) also which will fetch frames from frame buffer and handle over to server.
<br><br>For RF interface i want to go with WUSB2.0 ( wireless USB 2.0 ) but due to some problem my adviser told me to think about blue tooth interface and perhaps i need to work with blueZ. <br><br>I am unable to think for the whole setup and connectivity between various module. Actually I need to do this my own but i am not getting the whole picture on which i should work. Can anybody help me out ?? I will be highly Thankful
<br><br>Thanks and Regards<br><br><div class="gmail_quote">On Nov 24, 2007 4:47 AM, Grant Likely &lt;<a href="mailto:grant.likely@secretlab.ca">grant.likely@secretlab.ca</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">On 11/23/07, narendra sisodiya &lt;<a href="mailto:narendra.sisodiya@gmail.com">narendra.sisodiya@gmail.com</a>&gt; wrote:<br>&gt; Hi, I am working ML310 XUP virtex2Pro board. My task is to port a Linux
<br>&gt; 2.4.26 on PowerPC405. I am on the mid way<br>&gt; I have following question.<br>&gt;<br>&gt;<br>&gt; Why in every document Linux kernel 2.4.26 is used, can i use 2.6.xx version.<br>&gt; If yes what will be the modifications,
<br><br></div>Mainline 2.6.x has support for the virtex device but it is missing<br>some drivers for EMAC, TEMAC and some other devices.<br><br>You can get the drivers from my tree at <a href="http://git.secretlab.ca/" target="_blank">
http://git.secretlab.ca/</a> or<br>from the xilinx git server <a href="http://git.xilinx.com" target="_blank">http://git.xilinx.com</a><br><div class="Ih2E3d"><br>&gt; In document some are using busybox for making root file system and in some
<br>&gt; Yellow Dog Linux. so what are the such possible options?<br><br></div>Yellow Dog isn&#39;t a very good choice for the ppc405 with no floating<br>point unit. &nbsp;Use an embedded distro like ELDK, or build your own using
<br>buildroot or openembedded<br><div class="Ih2E3d"><br>&gt; If any body has done some project then Please share your experience with me.<br>&gt;<br>&gt;<br>&gt; --<br>&gt; Narendra Sisodiya<br>&gt; MTech (Computer Technology), IIT Delhi
<br>&gt; +91-9999232792<br>&gt; <a href="http://www.techfandu.org/index.html" target="_blank">http://www.techfandu.org/index.html</a><br></div>&gt; _______________________________________________<br>&gt; Linuxppc-embedded mailing list
<br>&gt; <a href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a><br>&gt; <a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded" target="_blank">https://ozlabs.org/mailman/listinfo/linuxppc-embedded
</a><br>&gt;<br><font color="#888888"><br><br>--<br>Grant Likely, B.Sc., P.Eng.<br>Secret Lab Technologies Ltd.<br><a href="mailto:grant.likely@secretlab.ca">grant.likely@secretlab.ca</a><br>(403) 399-0195<br></font></blockquote>
</div><br><br clear="all"><br>-- <br>Narendra Sisodiya<br>MTech (Computer Technology), IIT Delhi<br>+91-9999232792<br><a href="http://www.techfandu.org/index.html">http://www.techfandu.org/index.html</a>

------=_Part_42763_8526161.1195862972876--
