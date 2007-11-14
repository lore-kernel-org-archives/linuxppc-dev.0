Return-Path: <alan@akb.net>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.225])
	by ozlabs.org (Postfix) with ESMTP id 29D3CDDDF4
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 04:49:14 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so233625nzh
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 09:49:13 -0800 (PST)
Message-ID: <bfa0697f0711140949q4cf92442gcb4c1ecf7592b040@mail.gmail.com>
Date: Wed, 14 Nov 2007 10:49:13 -0700
From: "Alan Bennett" <embedded@akb.net>
Sender: alan@akb.net
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: I2C on mpc8248 / device tree
In-Reply-To: <9AADA2CE-A7F0-4C88-BFCF-08D6C8DC09E0@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1065_18226079.1195062553079"
References: <bfa0697f0711131539n228f9f21q7b2acc896499b80d@mail.gmail.com>
	<9e4733910711131556r23a38780q39baf15d85c0bd85@mail.gmail.com>
	<bfa0697f0711140731n20ccd8bdme2de6302848f5a4f@mail.gmail.com>
	<9AADA2CE-A7F0-4C88-BFCF-08D6C8DC09E0@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_1065_18226079.1195062553079
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

ERk.
  So if I needed to read values from four i2c devices (raw access would be
fine) and I need to get this working in a few days, how would you suggest I
proceed?  Kernel = 2.6.23+.

  Do I need to start from scratch?

  Start by using Jon's patch  (or are the 5200 i2c and the cpm2 i2c
completely incompatible?)

  What about other cpm2/i2c threads - Did they ever complete?
     1) On Wednesday, November 23, 2005 8:01 AM Kumar Gala wrote: >* Can we
rename the driver from mpc8260 -> cpm2. The driver should work* >* on any
device that has a "CPM2" which includes a number of MPC82xx* >* and MPC85xx
processors <http://osdir.com/ml/ports.ppc.devel/2005-11/msg00153.html#>. So
calling it and its config options, etc* >* MPC8260 is going to be confusing
to users.* [PATCH] I2C: Add I2C Bus support for MPC with CPM2.





On 11/14/07, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> The patch is orthogonal to your issue.
>
> There is NOT a driver in the kernel tree for the i2c on CPM2 based
> parts like the 8248 (from what I can tell).
>
> - k
>
> On Nov 14, 2007, at 9:31 AM, Alan Bennett wrote:
>
> > Does this patch support the cpm2 as well?
> >
> > I get conflicting thoughts looking over the latest postings.
> >
> > -Alan
> >
> >
> > On 11/13/07, Jon Smirl < jonsmirl@gmail.com> wrote:I am working on
> > a patch for i2c and device tree. I attached the current version.
> >
> > DTC entry looks like this.
> >
> >                 i2c@3d40 {
> >                         compatible = "mpc5200b-i2c","mpc5200-
> > i2c","fsl-i2c";
> >                         reg = <3d40 40>;
> >                         interrupts = <2 10 0>;
> >                         interrupt-parent = <&mpc5200_pic>;
> >                         fsl5200-clocking;
> >
> >                         rtc@51f {
> >                                 compatible = "epson,rtc8564";
> >                                 reg = <51>;
> >                         };
> >                 };
> >
> >
> >
> > --
> > Jon Smirl
> > jonsmirl@gmail.com
> >
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
>

------=_Part_1065_18226079.1195062553079
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

ERk.<br>&nbsp; So if I needed to read values from four i2c devices (raw access would be fine) and I need to get this working in a few days, how would you suggest I proceed?&nbsp; Kernel = 2.6.23+.&nbsp; <br><br>&nbsp; Do I need to start from scratch?
<br><br>&nbsp; Start by using Jon&#39;s patch&nbsp; (or are the 5200 i2c and the cpm2 i2c completely incompatible?)&nbsp; <br><br>&nbsp; What about other cpm2/i2c threads - Did they ever complete?  <br>&nbsp;&nbsp;&nbsp;&nbsp; 1) On Wednesday, November 23, 2005 8:01 AM Kumar Gala wrote:
&gt;<i> Can we rename the driver from mpc8260 -&gt; cpm2. The driver should work</i>
&gt;<i> on any device that has a &quot;CPM2&quot; which includes a number of MPC82xx</i>
&gt;<i> and MPC85xx <a class="kLink" id="KonaLink0" onmouseover="adlinkMouseOver(event,this,0);" style="position: static; text-decoration: underline ! important;" onclick="adlinkMouseClick(event,this,0);" onmouseout="adlinkMouseOut(event,this,0);" href="http://osdir.com/ml/ports.ppc.devel/2005-11/msg00153.html#" target="_top">
<font style="font-weight: 400; font-size: 10pt; color: blue ! important; font-family: Courier New; position: static;" color="blue"><span class="kLink" style="border-bottom: 1px solid blue; font-weight: 400; font-size: 10pt; color: blue ! important; font-family: Courier New; position: relative; background-color: transparent;">
processors</span></font></a>.  So calling it and its config options, etc</i>
&gt;<i> MPC8260 is going to be confusing to users.</i>

[PATCH] I2C:    Add I2C Bus support for MPC with CPM2.
<br><br><br>&nbsp; <br><br><br><div><span class="gmail_quote">On 11/14/07, <b class="gmail_sendername">Kumar Gala</b> &lt;<a href="mailto:galak@kernel.crashing.org">galak@kernel.crashing.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
The patch is orthogonal to your issue.<br><br>There is NOT a driver in the kernel tree for the i2c on CPM2 based<br>parts like the 8248 (from what I can tell).<br><br>- k<br><br>On Nov 14, 2007, at 9:31 AM, Alan Bennett wrote:
<br><br>&gt; Does this patch support the cpm2 as well?<br>&gt;<br>&gt; I get conflicting thoughts looking over the latest postings.<br>&gt;<br>&gt; -Alan<br>&gt;<br>&gt;<br>&gt; On 11/13/07, Jon Smirl &lt; <a href="mailto:jonsmirl@gmail.com">
jonsmirl@gmail.com</a>&gt; wrote:I am working on<br>&gt; a patch for i2c and device tree. I attached the current version.<br>&gt;<br>&gt; DTC entry looks like this.<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2c@3d40 {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible = &quot;mpc5200b-i2c&quot;,&quot;mpc5200-
<br>&gt; i2c&quot;,&quot;fsl-i2c&quot;;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg = &lt;3d40 40&gt;;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts = &lt;2 10 0&gt;;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-parent = &lt;&amp;mpc5200_pic&gt;;
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fsl5200-clocking;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtc@51f {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible = &quot;epson,rtc8564&quot;;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg = &lt;51&gt;;
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>&gt;<br>&gt;<br>&gt;<br>&gt; --<br>&gt; Jon Smirl<br>&gt; <a href="mailto:jonsmirl@gmail.com">jonsmirl@gmail.com</a><br>&gt;<br>&gt;<br>&gt; _______________________________________________
<br>&gt; Linuxppc-dev mailing list<br>&gt; <a href="mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org</a><br>&gt; <a href="https://ozlabs.org/mailman/listinfo/linuxppc-dev">https://ozlabs.org/mailman/listinfo/linuxppc-dev
</a><br><br></blockquote></div><br>

------=_Part_1065_18226079.1195062553079--
