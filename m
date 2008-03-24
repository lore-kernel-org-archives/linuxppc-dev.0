Return-Path: <tehn.yit.chin@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by ozlabs.org (Postfix) with ESMTP id 8C7DDDDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Mar 2008 10:03:53 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so3697161wag.13
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Mar 2008 16:03:51 -0700 (PDT)
Message-ID: <bf04f99c0803241603v3151865eic80b58a04bce43e2@mail.gmail.com>
Date: Tue, 25 Mar 2008 10:03:51 +1100
From: "Tehn Yit Chin" <tehn.yit.chin@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: interrupt handlers PowerPC via GCC
In-Reply-To: <47E29C60.10300@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_13317_14760976.1206399831442"
References: <bf04f99c0803191706q7e3a43a3i50a1d479650a3f9d@mail.gmail.com>
	<47E29C60.10300@freescale.com>
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

------=_Part_13317_14760976.1206399831442
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hey Scott,

Thanks for the reply, I shall investigate further.

I wasn't talking about interrupt handlers in Linux as such, but using
powerpc-eabi-gcc to write an ISR for the MPC5516. (I guess that could be
off-topic on this mailing list, but I thought the folks on this mailing list
would probably know the answer pretty easily). I was hoping that gcc would
generate the prologue and epilogue code for me via the interrupt attributes.

Many thanks.
Tehn Yit Chin



On Fri, Mar 21, 2008 at 4:18 AM, Scott Wood <scottwood@freescale.com> wrote:

> Tehn Yit Chin wrote:
> > Hi all,
> >
> > Apologies for such a basic question. I am trying to write an ISR on a
> > MPC551x. When I tried to use the interrupt attribute with
> > powerpc-eabi-gcc such as
> >
> > _attribute_((interrupt_handler)) foobarISR(void)
> > {
> > }
>
> Assuming you're talking about an interrupt handler in Linux, you don't
> need to do anything like that.  The actual interrupt entry is assembly
> code.  Search existing drivers for "irqreturn_t" to find examples of
> what an interrupt handler looks like, and "request_irq" for how to hook
> the handler into the interrupt.
>
> -Scott
>

------=_Part_13317_14760976.1206399831442
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hey Scott, <br><br>Thanks for the reply, I shall investigate further. <br><br>I wasn&#39;t talking about interrupt handlers in Linux as such, but using powerpc-eabi-gcc to write an ISR for the MPC5516. (I guess that could be off-topic on this mailing list, but I thought the folks on this mailing list would probably know the answer pretty easily). I was hoping that gcc would generate the prologue and epilogue code for me via the interrupt attributes.<br>
<br>Many thanks.<br>Tehn Yit Chin<br><br><br><br><div class="gmail_quote">On Fri, Mar 21, 2008 at 4:18 AM, Scott Wood &lt;<a href="mailto:scottwood@freescale.com">scottwood@freescale.com</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">Tehn Yit Chin wrote:<br>
&gt; Hi all,<br>
&gt;<br>
&gt; Apologies for such a basic question. I am trying to write an ISR on a<br>
&gt; MPC551x. When I tried to use the interrupt attribute with<br>
&gt; powerpc-eabi-gcc such as<br>
&gt;<br>
&gt; _attribute_((interrupt_handler)) foobarISR(void)<br>
&gt; {<br>
&gt; }<br>
<br>
</div>Assuming you&#39;re talking about an interrupt handler in Linux, you don&#39;t<br>
need to do anything like that. &nbsp;The actual interrupt entry is assembly<br>
code. &nbsp;Search existing drivers for &quot;irqreturn_t&quot; to find examples of<br>
what an interrupt handler looks like, and &quot;request_irq&quot; for how to hook<br>
the handler into the interrupt.<br>
<font color="#888888"><br>
-Scott<br>
</font></blockquote></div><br>

------=_Part_13317_14760976.1206399831442--
