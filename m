Return-Path: <alan@akb.net>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.226])
	by ozlabs.org (Postfix) with ESMTP id 2CE0DDDE0D
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 02:31:08 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so189474nzh
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 07:31:01 -0800 (PST)
Message-ID: <bfa0697f0711140731n20ccd8bdme2de6302848f5a4f@mail.gmail.com>
Date: Wed, 14 Nov 2007 08:31:00 -0700
From: "Alan Bennett" <embedded@akb.net>
Sender: alan@akb.net
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: I2C on mpc8248 / device tree
In-Reply-To: <9e4733910711131556r23a38780q39baf15d85c0bd85@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_444_12278554.1195054260760"
References: <bfa0697f0711131539n228f9f21q7b2acc896499b80d@mail.gmail.com>
	<9e4733910711131556r23a38780q39baf15d85c0bd85@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_444_12278554.1195054260760
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Does this patch support the cpm2 as well?

I get conflicting thoughts looking over the latest postings.

-Alan


On 11/13/07, Jon Smirl <jonsmirl@gmail.com> wrote:
>
> I am working on a patch for i2c and device tree. I attached the current
> version.
>
> DTC entry looks like this.
>
>                 i2c@3d40 {
>                         compatible =
> "mpc5200b-i2c","mpc5200-i2c","fsl-i2c";
>                         reg = <3d40 40>;
>                         interrupts = <2 10 0>;
>                         interrupt-parent = <&mpc5200_pic>;
>                         fsl5200-clocking;
>
>                         rtc@51f {
>                                 compatible = "epson,rtc8564";
>                                 reg = <51>;
>                         };
>                 };
>
>
>
> --
> Jon Smirl
> jonsmirl@gmail.com
>
>

------=_Part_444_12278554.1195054260760
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Does this patch support the cpm2 as well?<br><br>I get conflicting thoughts looking over the latest postings.<br><br>-Alan<br><br><br><div><span class="gmail_quote">On 11/13/07, <b class="gmail_sendername">Jon Smirl</b> &lt;
<a href="mailto:jonsmirl@gmail.com">jonsmirl@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">I am working on a patch for i2c and device tree. I attached the current version.
<br><br>DTC entry looks like this.<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i2c@3d40 {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;compatible = &quot;mpc5200b-i2c&quot;,&quot;mpc5200-i2c&quot;,&quot;fsl-i2c&quot;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reg = &lt;3d40 40&gt;;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interrupts = &lt;2 10 0&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interrupt-parent = &lt;&amp;mpc5200_pic&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fsl5200-clocking;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rtc@51f {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;compatible = &quot;epson,rtc8564&quot;;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reg = &lt;51&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;};<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;};<br><br><br><br>--<br>Jon Smirl<br><a href="mailto:jonsmirl@gmail.com">jonsmirl@gmail.com</a><br><br></blockquote></div>
<br>

------=_Part_444_12278554.1195054260760--
