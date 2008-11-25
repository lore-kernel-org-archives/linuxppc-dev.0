Return-Path: <neko@genesi-usa.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id 4EA17DDE0F
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 08:14:43 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id d11so93303and.39
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 13:14:42 -0800 (PST)
Message-ID: <b5e2fc790811251314g78547a25hb52158244c1e539@mail.gmail.com>
Date: Tue, 25 Nov 2008 15:14:41 -0600
From: "Matt Sealey" <matt@genesi-usa.com>
To: "Wolfgang Denk" <wd@denx.de>
Subject: Re: [PATCH/RFC] Add Alternative Log Buffer Support for printk Messages
In-Reply-To: <20081125210502.92402834B020@gemini.denx.de>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_17422_1227311.1227647681876"
References: <20081125135519.038abf23@zod.rchland.ibm.com>
	<C5518C2F.13137%gerickson@nuovations.com>
	<b5e2fc790811251131g63ea9444x57ec0829ca0b069e@mail.gmail.com>
	<20081125210502.92402834B020@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	Grant Erickson <gerickson@nuovations.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_17422_1227311.1227647681876
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, Nov 25, 2008 at 3:05 PM, Wolfgang Denk <wd@denx.de> wrote:

> Dear Matt,
>
> In message <b5e2fc790811251131g63ea9444x57ec0829ca0b069e@mail.gmail.com>
> you wrote:
> >
> > There is also no reason you can't hard-code the locations into the device
> > tree, to support older U-Boots that don't know about
> > /chosen/linux,log-metadata and /chosen/linux,log-buffer*.
>
> Actually there is such reason - U-Boot traditionally allocates the log
> buffer close to the upper end of system memory, so the start address
> depends on the memory size on the board, which may vary.
>


I think I covered that in "I can think of a bunch of reasons why it's a good
idea.. " - but the current implementation is hardcoded in the kernel so
there is no problem with *certain* boards having it done this way, and that
information being moved from the kernel into a static entry in a device
tree.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

------=_Part_17422_1227311.1227647681876
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div class="gmail_quote">On Tue, Nov 25, 2008 at 3:05 PM, Wolfgang Denk <span dir="ltr">&lt;<a href="mailto:wd@denx.de">wd@denx.de</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Dear Matt,<br>
<div class="Ih2E3d"><br>
In message &lt;<a href="mailto:b5e2fc790811251131g63ea9444x57ec0829ca0b069e@mail.gmail.com">b5e2fc790811251131g63ea9444x57ec0829ca0b069e@mail.gmail.com</a>&gt; you wrote:<br>
&gt;<br>
&gt; There is also no reason you can&#39;t hard-code the locations into the device<br>
&gt; tree, to support older U-Boots that don&#39;t know about<br>
&gt; /chosen/linux,log-metadata and /chosen/linux,log-buffer*.<br>
<br>
</div>Actually there is such reason - U-Boot traditionally allocates the log<br>
buffer close to the upper end of system memory, so the start address<br>
depends on the memory size on the board, which may vary.<br>
</blockquote><div><br><br>I think I covered that in &quot;I can think of a bunch of reasons why it&#39;s a good idea.. &quot; - but the current implementation is hardcoded in the kernel so there is no problem with *certain* boards having it done this way, and that information being moved from the kernel into a static entry in a device tree.<br>
&nbsp;</div></div>-- <br>Matt Sealey &lt;<a href="mailto:matt@genesi-usa.com">matt@genesi-usa.com</a>&gt;<br>Genesi, Manager, Developer Relations<br>

------=_Part_17422_1227311.1227647681876--
