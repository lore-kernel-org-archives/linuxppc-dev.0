Return-Path: <m.louvel@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.229])
	by ozlabs.org (Postfix) with ESMTP id 2132EDDE02
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Feb 2008 19:31:07 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so3222878wxd.15
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Feb 2008 00:31:06 -0800 (PST)
Message-ID: <dda529d0802280031o23fb8de1ya5de2db876013e0b@mail.gmail.com>
Date: Thu, 28 Feb 2008 08:31:06 +0000
From: "maxime louvel" <m.louvel@gmail.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: 2.6.25-rc3 on mpc8548amc doesn't boot
In-Reply-To: <dda529d0802272356p5db9066s5a9aaa336e74ab81@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8780_8683398.1204187466181"
References: <dda529d0802270437o3ea1c9beld7d65f5af2011a6f@mail.gmail.com>
	<dda529d0802270825p527fd1b5i3e5a72a16bd95a75@mail.gmail.com>
	<B3C9F997-0D0B-4033-9FED-F8B6B7F5DABC@kernel.crashing.org>
	<dda529d0802272356p5db9066s5a9aaa336e74ab81@mail.gmail.com>
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

------=_Part_8780_8683398.1204187466181
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I have a question for submitting my changes:
As I said I have commented a few line in arch/powerpc/boot/Makefile
#$(obj)/4xx.o: BOOTCFLAGS += -mcpu=405
#$(obj)/ebony.o: BOOTCFLAGS += -mcpu=405
#$(obj)/cuboot-taishan.o: BOOTCFLAGS += -mcpu=405
#$(obj)/cuboot-katmai.o: BOOTCFLAGS += -mcpu=405
#$(obj)/treeboot-walnut.o: BOOTCFLAGS += -mcpu=40

I guess that shouldn't be integrated in my patch, should I ?
For what I have found on websearch that should come from my gcc version (
3.4.3 with specific stuff).
But still I needed that...

thanks,
Maxime

On Thu, Feb 28, 2008 at 7:56 AM, maxime louvel <m.louvel@gmail.com> wrote:

> Hi,
>
> I wanted first to check how the kernel is behaving, with a few tests.
> Then what is the best solution to do this ?
> A patch from the 2.6.25-rc3 vanilla kernel ?
>
> cheers,
> Maxime
>
>
> On Thu, Feb 28, 2008 at 7:03 AM, Kumar Gala <galak@kernel.crashing.org>
> wrote:
>
> >
> > On Feb 27, 2008, at 10:25 AM, maxime louvel wrote:
> >
> > > Hi again,
> > >
> > > I am answering my self sorry for the spam...
> > > Just to say that my problem has been solve if someone has something
> > > similar...
> > > My changes were good, I just didn't compile the good file...
> >
> > Any plans to submit patches to add support for this board to the kernel?
> >
> > - k
> >
> >
>
>
> --
> Maxime Louvel
> 0044 7964 5555 80
> 43 Allen road
> Whitemore reans
> WV60AW Wolverhampton
> United Kingdom
>



-- 
Maxime Louvel
0044 7964 5555 80
43 Allen road
Whitemore reans
WV60AW Wolverhampton
United Kingdom

------=_Part_8780_8683398.1204187466181
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I have a question for submitting my changes:<br>As I said I have commented a few line in arch/powerpc/boot/Makefile<br>#$(obj)/4xx.o: BOOTCFLAGS += -mcpu=405<br>#$(obj)/ebony.o: BOOTCFLAGS += -mcpu=405<br>#$(obj)/cuboot-taishan.o: BOOTCFLAGS += -mcpu=405<br>

#$(obj)/cuboot-katmai.o: BOOTCFLAGS += -mcpu=405<br>#$(obj)/treeboot-walnut.o: BOOTCFLAGS += -mcpu=40<br><br>I guess that shouldn&#39;t be integrated in my patch, should I ?<br>For what I have found on websearch that should come from my gcc version (3.4.3 with specific stuff).<br>
But still I needed that...<br><br>thanks,<br>Maxime<br><br><div class="gmail_quote">On Thu, Feb 28, 2008 at 7:56 AM, maxime louvel &lt;<a href="mailto:m.louvel@gmail.com">m.louvel@gmail.com</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi,<br><br>I wanted first to check how the kernel is behaving, with a few tests.<br>Then what is the best solution to do this ?<br>A patch from the 2.6.25-rc3 vanilla kernel ?<br><br>cheers,<br><font color="#888888">Maxime</font><div>
<div></div><div class="Wj3C7c"><br><br><div class="gmail_quote">
On Thu, Feb 28, 2008 at 7:03 AM, Kumar Gala &lt;<a href="mailto:galak@kernel.crashing.org" target="_blank">galak@kernel.crashing.org</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<div><br>
On Feb 27, 2008, at 10:25 AM, maxime louvel wrote:<br>
<br>
&gt; Hi again,<br>
&gt;<br>
&gt; I am answering my self sorry for the spam...<br>
&gt; Just to say that my problem has been solve if someone has something<br>
&gt; similar...<br>
&gt; My changes were good, I just didn&#39;t compile the good file...<br>
<br>
</div>Any plans to submit patches to add support for this board to the kernel?<br>
<font color="#888888"><br>
- k<br>
<br>
</font></blockquote></div><br><br clear="all"><br></div></div><div><div></div><div class="Wj3C7c">-- <br>Maxime Louvel<br>0044 7964 5555 80<br>43 Allen road<br>Whitemore reans<br>WV60AW Wolverhampton<br>United Kingdom
</div></div></blockquote></div><br><br clear="all"><br>-- <br>Maxime Louvel<br>0044 7964 5555 80<br>43 Allen road<br>Whitemore reans<br>WV60AW Wolverhampton<br>United Kingdom

------=_Part_8780_8683398.1204187466181--
