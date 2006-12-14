Return-Path: <vitalywool@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.185])
	by ozlabs.org (Postfix) with ESMTP id C6F8367BE3
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 17:22:40 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id n15so653649nfc
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 22:22:38 -0800 (PST)
Message-ID: <acd2a5930612132222q453f14datcd26e90cff2637ac@mail.gmail.com>
Date: Thu, 14 Dec 2006 09:22:37 +0300
From: "Vitaly Wool" <vitalywool@gmail.com>
To: "Reeve Yang" <yang.reeve@gmail.com>
Subject: Re: kgdb on mpc834x
In-Reply-To: <198592450612131708h1f5b59ffhdebd1b23d56d628f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_155592_9010302.1166077357662"
References: <198592450612121611o7f7271cbnb1404c7f7f9fda71@mail.gmail.com>
	<1165982456.10549.1.camel@diesel>
	<198592450612131708h1f5b59ffhdebd1b23d56d628f@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_155592_9010302.1166077357662
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 12/14/06, Reeve Yang <yang.reeve@gmail.com> wrote:
>
> I set "debug serial 1" in gdb, now I'm seeing message like this
>
> (gdb) target remote /dev/ttyS0
> Remote debugging using /dev/ttyS0
> [
> r <Timeout: 2 seconds>][<Timeout: 2 seconds>][<Timeout: 2
> seconds>][<Timeout: 2 seconds>][<Timeout: 2 seconds>][<Timeout: 2
> seconds>][<Timeout: 2 seconds>]Ignoring packet error, continuing...
> [<Timeout: 2 seconds>][<Timeout: 2 seconds>][<Timeout: 2
> seconds>][<Timeout: 2 seconds>][<Timeout: 2 seconds>][<Timeout: 2
> seconds>][<Timeout: 2 seconds>]Ignoring packet error, continuing...
> [<Timeout: 2 seconds>][<Timeout: 2 seconds>][<Timeout: 2
> seconds>][<Timeout: 2 seconds>][<Timeout: 2 seconds>][<Timeout: 2
> seconds>][<Timeout: 2 seconds>]Ignoring packet error, continuing...
> Malformed response to offset query, timeout
>
> Does it tell any information?
>

Yes. Apparently your kernel command line is wrong.

Vitaly

------=_Part_155592_9010302.1166077357662
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 12/14/06, <b class="gmail_sendername">Reeve Yang</b> &lt;<a href="mailto:yang.reeve@gmail.com">yang.reeve@gmail.com</a>&gt; wrote:<div><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
I set &quot;debug serial 1&quot; in gdb, now I'm seeing message like this<br><br>(gdb) target remote /dev/ttyS0<br>Remote debugging using /dev/ttyS0<br>[<br>r &lt;Timeout: 2 seconds&gt;][&lt;Timeout: 2 seconds&gt;][&lt;Timeout: 2
<br>seconds&gt;][&lt;Timeout: 2 seconds&gt;][&lt;Timeout: 2 seconds&gt;][&lt;Timeout: 2<br>seconds&gt;][&lt;Timeout: 2 seconds&gt;]Ignoring packet error, continuing...<br>[&lt;Timeout: 2 seconds&gt;][&lt;Timeout: 2 seconds&gt;][&lt;Timeout: 2
<br>seconds&gt;][&lt;Timeout: 2 seconds&gt;][&lt;Timeout: 2 seconds&gt;][&lt;Timeout: 2<br>seconds&gt;][&lt;Timeout: 2 seconds&gt;]Ignoring packet error, continuing...<br>[&lt;Timeout: 2 seconds&gt;][&lt;Timeout: 2 seconds&gt;][&lt;Timeout: 2
<br>seconds&gt;][&lt;Timeout: 2 seconds&gt;][&lt;Timeout: 2 seconds&gt;][&lt;Timeout: 2<br>seconds&gt;][&lt;Timeout: 2 seconds&gt;]Ignoring packet error, continuing...<br>Malformed response to offset query, timeout<br><br>
Does it tell any information?<br></blockquote></div><br>Yes. Apparently your kernel command line is wrong.<br><br>Vitaly<br>

------=_Part_155592_9010302.1166077357662--
