Return-Path: <wmaxfield@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 2BA4067B5D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Aug 2006 08:13:26 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id e2so647938ugf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 15:13:24 -0700 (PDT)
Message-ID: <45a1b53e0608241513m5b97d34chf7e133eea984cb6c@mail.gmail.com>
Date: Thu, 24 Aug 2006 17:13:24 -0500
From: "Wade Maxfield" <wmaxfield@gmail.com>
To: "T Ziomek" <ctz001@email.mot.com>
Subject: Re: MontaVista 2.6 Kernel support for Xilinx ML40x
In-Reply-To: <Pine.WNT.4.61.0608241432311.200@holyoke.labs.mot.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_136940_8789329.1156457604309"
References: <DADA32856852FC458E0F96B664A6F55E011E2423@kom-mailsrv1.kontron-modular.com>
	<45a1b53e0608240836l52ed51b5u309e31dd8486cc5b@mail.gmail.com>
	<44EDD947.3000105@xilinx.com>
	<45a1b53e0608241057j4ebe519drd1e431a2275ccdde@mail.gmail.com>
	<Pine.WNT.4.61.0608241432311.200@holyoke.labs.mot.com>
Cc: ppc <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_136940_8789329.1156457604309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

  sorry! ;)  See my reply at the right location!

On 8/24/06, T Ziomek <ctz001@email.mot.com> wrote:
>
> [top-posting fixed  :-) ]
>
>
> On Thu, 24 Aug 2006, Wade Maxfield wrote:
> >
> > On 8/24/06, Peter Ryser <peter.ryser@xilinx.com> wrote:
> >>
> >>  Wade,
> >>
> >> are you sure that you did not build your hardware with evaluation cores
> of
> >> the licenses? If you are using the evaluation licenses the hardware
> (FPGA
> >> design) will stop working after a certain amount of time and you will
> see a
> >> lock-up.
> >
> > Good question.  How long before lockup?  The only core that should be
> > licensed is the ethernet, and I know it was sysgened on a system with a
> > license.  This is the Xilinx reference design for the ml403 board.
>
> When we were using the eval version of Xilinx's 10/100 EMAC it would time-
> out after 8 hours (and the kernel would panic since our root fs was NFS-
> mounted).
>
> If your only [to-be-]licensed core is Ethernet, then I take it you're
> using
> the UARTLite, or a non-Xilinx UART?  We used Xilinx's 16550-compatible
> UART,
> which is licensed, but I never ran with the eval version of that IP block
> and so have no idea how long it will function before shutting down.



 We are doing an evaluation right now.  We have operational 8 hours 55
minutes so far and counting on the Xilinx 16550 compatible uart.  I think
that is the cause of the problem for us, but not sure so far.


Tom
> --
> A: Because it breaks the logical        |
>      flow of the message.                |   Email to user 'CTZ001'
>                                          |             at 'email.mot.com'
> Q: Why is top posting frowned upon?     |


x<>y
 A2. but only for algebraic.  RPN likes it that way.

------=_Part_136940_8789329.1156457604309
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

&nbsp; sorry! ;)&nbsp; See my reply at the right location!<br><br><div><span class="gmail_quote">On 8/24/06, <b class="gmail_sendername">T Ziomek</b> &lt;<a href="mailto:ctz001@email.mot.com">ctz001@email.mot.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">[top-posting fixed&nbsp;&nbsp;:-) ]<br><br><br>On Thu, 24 Aug 2006, Wade Maxfield wrote:<br>&gt;<br>&gt; On 8/24/06, Peter Ryser &lt;
<a href="mailto:peter.ryser@xilinx.com">peter.ryser@xilinx.com</a>&gt; wrote:<br>&gt;&gt;<br>&gt;&gt;&nbsp;&nbsp;Wade,<br>&gt;&gt;<br>&gt;&gt; are you sure that you did not build your hardware with evaluation cores of<br>&gt;&gt; the licenses? If you are using the evaluation licenses the hardware (FPGA
<br>&gt;&gt; design) will stop working after a certain amount of time and you will see a<br>&gt;&gt; lock-up.<br>&gt;<br>&gt; Good question.&nbsp;&nbsp;How long before lockup?&nbsp;&nbsp;The only core that should be<br>&gt; licensed is the ethernet, and I know it was sysgened on a system with a
<br>&gt; license.&nbsp;&nbsp;This is the Xilinx reference design for the ml403 board.<br><br>When we were using the eval version of Xilinx's 10/100 EMAC it would time-<br>out after 8 hours (and the kernel would panic since our root fs was NFS-
<br>mounted).<br><br>If your only [to-be-]licensed core is Ethernet, then I take it you're using<br>the UARTLite, or a non-Xilinx UART?&nbsp;&nbsp;We used Xilinx's 16550-compatible UART,<br>which is licensed, but I never ran with the eval version of that IP block
<br>and so have no idea how long it will function before shutting down.</blockquote><div><br><br>&nbsp;We are doing an evaluation right now.&nbsp; We have operational 8 hours 55 minutes so far and counting on the Xilinx 16550 compatible uart.&nbsp; I think that is the cause of the problem for us, but not sure so far.
<br>&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Tom<br>--<br>A: Because it breaks the logical&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<br>&nbsp;&nbsp;&nbsp;&nbsp; flow of the message.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp; Email to user 'CTZ001'
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; at '<a href="http://email.mot.com">email.mot.com</a>'<br>Q: Why is top posting frowned upon?&nbsp;&nbsp;&nbsp;&nbsp; |</blockquote><div><br>x&lt;&gt;y<br>&nbsp;A2. but only for algebraic.&nbsp; RPN likes it that way.
<br>&nbsp; <br>&nbsp;</div><br></div><br>

------=_Part_136940_8789329.1156457604309--
