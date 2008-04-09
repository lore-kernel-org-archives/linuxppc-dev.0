Return-Path: <neko@genesi-usa.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 399CBDDFDB
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 02:46:04 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so879678uge.0
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Apr 2008 09:46:01 -0700 (PDT)
Message-ID: <b5e2fc790804090946s56cea6c0p429044f638595c0e@mail.gmail.com>
Date: Wed, 9 Apr 2008 17:46:00 +0100
From: "Matt Sealey" <matt@genesi-usa.com>
Sender: neko@genesi-usa.com
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Subject: Re: Question on mpc52xx_common.c
In-Reply-To: <29c98f1cd48092a67f9c7e431063e656@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_4833_20706532.1207759560856"
References: <m21w5map5f.fsf@ohwell.denx.de> <47FAA0A8.7050602@genesi-usa.com>
	<200804080414.42867.arnd@arndb.de>
	<fa686aa40804071925v6c7d28edna529e6122fdc9cf7@mail.gmail.com>
	<23d2e4300804071926n57746a3cj551ef38bf10486c7@mail.gmail.com>
	<47FB3CD6.2090706@genesi-usa.com>
	<fa686aa40804080752g595196det8f576df1884bac5d@mail.gmail.com>
	<20080408194517.GX13814@pengutronix.de>
	<fa686aa40804081426u2c2a530ej8ecb6ce9f8fb49a0@mail.gmail.com>
	<29c98f1cd48092a67f9c7e431063e656@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_4833_20706532.1207759560856
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, Apr 8, 2008 at 10:51 PM, Segher Boessenkool <
segher@kernel.crashing.org> wrote:

>
> Let's flat out refuse any patch series that uses a non-documented
> binding.
>

I would love this, it makes life easier, but let's make sure that the
documented binding is actually
fairly future proof, first, and not going to cause a billion problems
further down the line when kernels
and device trees diverge in their implementation/requirements as the
MPC5200B ethernet driver
has.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

------=_Part_4833_20706532.1207759560856
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div class="gmail_quote">On Tue, Apr 8, 2008 at 10:51 PM, Segher Boessenkool &lt;<a href="mailto:segher@kernel.crashing.org">segher@kernel.crashing.org</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
Let&#39;s flat out refuse any patch series that uses a non-documented<br>
binding.<br></blockquote><div><br>I would love this, it makes life easier, but let&#39;s make sure that the documented binding is actually<br>fairly future proof, first, and not going to cause a billion problems further down the line when kernels<br>
and device trees diverge in their implementation/requirements as the MPC5200B ethernet driver<br>has.</div></div><br>-- <br>Matt Sealey &lt;<a href="mailto:matt@genesi-usa.com">matt@genesi-usa.com</a>&gt;<br>Genesi, Manager, Developer Relations

------=_Part_4833_20706532.1207759560856--
