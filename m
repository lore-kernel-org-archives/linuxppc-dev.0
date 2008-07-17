Return-Path: <nobin.mathew@gmail.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.191])
	by ozlabs.org (Postfix) with ESMTP id 94691DE00D
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 21:26:55 +1000 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so2282643rnf.16
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 04:26:53 -0700 (PDT)
Message-ID: <8d6898730807170426wac4719cv7cd925cfcd91aa68@mail.gmail.com>
Date: Thu, 17 Jul 2008 16:56:52 +0530
From: "Nobin Mathew" <nobin.mathew@gmail.com>
To: dinesh <dinesh.dua@coraltele.com>, "Nobin Mathew" <nobin.mathew@gmail.com>,
	"Grant Likely" <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com
Subject: Re: [alsa-devel] WRITING AN SOC DRIVER WITHOUT DMA
In-Reply-To: <20080717105614.GC15333@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_47507_13451466.1216294012914"
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080712083939.15025.31192.stgit@trillian.secretlab.ca>
	<1216199130.749.4.camel@dinesh.dua>
	<8d6898730807160307g4455597ck921d55da8f51455d@mail.gmail.com>
	<1216203206.9723.0.camel@dinesh.dua>
	<1216274611.18207.6.camel@dinesh.dua>
	<20080717105614.GC15333@sirena.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_47507_13451466.1216294012914
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Dinesh,

If that is your requirement then go and see the actual code
sound/arm/aaci.c. They are not using DMA. It is programmed IO.


Thanks
Nobin Mathew

On 7/17/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
>
> On Thu, Jul 17, 2008 at 11:33:31AM +0530, dinesh wrote:
>
> > What i want is that i have a buffer in driver code which is also handled
> > by some other application i want that this buffer data is to be used for
> > capture and playback  stream fills data to another buffer which i can
> > passover to my other application.
>
> Depending on what exactly you're doing here you may find that this is
> best implemented in user space with an ALSA plugin rather than doing it
> as part of a driver.  If you do want to do this in kernel space then the
> parts of an ASoC driver which transfer audio data are just the same as
> those for any other ALSA driver so things like sound/arm/aaci.c may
> provide useful examples.
>

------=_Part_47507_13451466.1216294012914
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Dinesh,</div>
<div>&nbsp;</div>
<div>If that is your requirement then go and see the actual code sound/arm/aaci.c. They are not using DMA. It is programmed IO.</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Thanks</div>
<div>Nobin Mathew<br>&nbsp;</div>
<div><span class="gmail_quote">On 7/17/08, <b class="gmail_sendername">Mark Brown</b> &lt;<a href="mailto:broonie@opensource.wolfsonmicro.com">broonie@opensource.wolfsonmicro.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">On Thu, Jul 17, 2008 at 11:33:31AM +0530, dinesh wrote:<br><br>&gt; What i want is that i have a buffer in driver code which is also handled<br>
&gt; by some other application i want that this buffer data is to be used for<br>&gt; capture and playback&nbsp;&nbsp;stream fills data to another buffer which i can<br>&gt; passover to my other application.<br><br>Depending on what exactly you&#39;re doing here you may find that this is<br>
best implemented in user space with an ALSA plugin rather than doing it<br>as part of a driver.&nbsp;&nbsp;If you do want to do this in kernel space then the<br>parts of an ASoC driver which transfer audio data are just the same as<br>
those for any other ALSA driver so things like sound/arm/aaci.c may<br>provide useful examples.<br></blockquote></div><br>

------=_Part_47507_13451466.1216294012914--
