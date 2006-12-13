Return-Path: <vitalywool@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.189])
	by ozlabs.org (Postfix) with ESMTP id 9770467BA1
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 17:18:26 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id n15so387107nfc
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 22:18:24 -0800 (PST)
Message-ID: <acd2a5930612122218s14f3d1d0n20adaeafa6a492eb@mail.gmail.com>
Date: Wed, 13 Dec 2006 09:18:23 +0300
From: "Vitaly Wool" <vitalywool@gmail.com>
To: "Reeve Yang" <yang.reeve@gmail.com>
Subject: Re: kgdb on mpc834x
In-Reply-To: <198592450612121611o7f7271cbnb1404c7f7f9fda71@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_132382_29847962.1165990703798"
References: <198592450612121611o7f7271cbnb1404c7f7f9fda71@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_132382_29847962.1165990703798
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 12/13/06, Reeve Yang <yang.reeve@gmail.com> wrote:
>
> I applied kgdb patch for 2.6.13 to kernel 2.6.14 (since there is no
> patch for 2.6.14), but gdb client cannot connec to it. I turn on all
> necessary kernel hacking options. Our board is customized with
> MPC834x, can someoen who used kgdb to debug kernel on MPC834x help me
> out? Following are the message from linux boot and gdb client.
>

You need to set up the kernel command line appropriately or add a breakpoint
explicitly.

Vitaly

------=_Part_132382_29847962.1165990703798
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 12/13/06, <b class="gmail_sendername">Reeve Yang</b> &lt;<a href="mailto:yang.reeve@gmail.com">yang.reeve@gmail.com</a>&gt; wrote:<div><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
I applied kgdb patch for 2.6.13 to kernel 2.6.14 (since there is no<br>patch for 2.6.14), but gdb client cannot connec to it. I turn on all<br>necessary kernel hacking options. Our board is customized with<br>MPC834x, can someoen who used kgdb to debug kernel on MPC834x help me
<br>out? Following are the message from linux boot and gdb client.<br></blockquote></div><br>You need to set up the kernel command line appropriately or add a breakpoint explicitly.<br><br>Vitaly<br>

------=_Part_132382_29847962.1165990703798--
