Return-Path: <jcrigby@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.187])
	by ozlabs.org (Postfix) with ESMTP id 2A008DDD0C
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Jan 2008 14:33:38 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so1298737rvf.9
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 19:33:35 -0800 (PST)
Message-ID: <4b73d43f0801191933u75205b43iae141db0dd9e121e@mail.gmail.com>
Date: Sat, 19 Jan 2008 20:33:35 -0700
From: "John Rigby" <jrigby@freescale.com>
Sender: jcrigby@gmail.com
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [Add mpc5121 support PATCH v3 7/8] Factor out 52xx dependencies
	from 52xx psc driver
In-Reply-To: <fa686aa40801182259k22663ca9s74b109f0f15d11fd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_7654_9765117.1200800015077"
References: <1200614738-25654-1-git-send-email-jrigby@freescale.com>
	<1200614738-25654-2-git-send-email-jrigby@freescale.com>
	<1200614738-25654-3-git-send-email-jrigby@freescale.com>
	<1200614738-25654-4-git-send-email-jrigby@freescale.com>
	<1200614738-25654-5-git-send-email-jrigby@freescale.com>
	<1200614738-25654-6-git-send-email-jrigby@freescale.com>
	<1200614738-25654-7-git-send-email-jrigby@freescale.com>
	<1200614738-25654-8-git-send-email-jrigby@freescale.com>
	<fa686aa40801182258r5a3b6465kf0e7918e0e56e0c4@mail.gmail.com>
	<fa686aa40801182259k22663ca9s74b109f0f15d11fd@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: jcrigby@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_7654_9765117.1200800015077
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Do you get a "Can't open initial console" message or just no output?

On Jan 18, 2008 11:59 PM, Grant Likely <grant.likely@secretlab.ca> wrote:

> On 1/18/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> > On 1/17/08, John Rigby <jrigby@freescale.com> wrote:
> > > PSCs change from 5200 to 5121
> > > this patch localizes the differences in
> > > preparation for adding 5121 support
> > >
> > > Signed-off-by: John Rigby <jrigby@freescale.com>
> >
> > This patch breaks the serial console on my Efika.
>
> Er, more specifically, I get console output, but I get no output from
> the init process (like when I add "init=/bin/sh" to the kernel
> parameters).
>
> Cheers,
> g.
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>

------=_Part_7654_9765117.1200800015077
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Do you get a &quot;Can&#39;t open initial console&quot; message or just no output?<br><br><div class="gmail_quote">On Jan 18, 2008 11:59 PM, Grant Likely &lt;<a href="mailto:grant.likely@secretlab.ca">grant.likely@secretlab.ca
</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class="Ih2E3d">On 1/18/08, Grant Likely &lt;<a href="mailto:grant.likely@secretlab.ca">
grant.likely@secretlab.ca</a>&gt; wrote:<br>&gt; On 1/17/08, John Rigby &lt;<a href="mailto:jrigby@freescale.com">jrigby@freescale.com</a>&gt; wrote:<br>&gt; &gt; PSCs change from 5200 to 5121<br>&gt; &gt; this patch localizes the differences in
<br>&gt; &gt; preparation for adding 5121 support<br>&gt; &gt;<br>&gt; &gt; Signed-off-by: John Rigby &lt;<a href="mailto:jrigby@freescale.com">jrigby@freescale.com</a>&gt;<br>&gt;<br>&gt; This patch breaks the serial console on my Efika.
<br><br></div>Er, more specifically, I get console output, but I get no output from<br>the init process (like when I add &quot;init=/bin/sh&quot; to the kernel<br>parameters).<br><br>Cheers,<br><div><div></div><div class="Wj3C7c">
g.<br><br>--<br>Grant Likely, B.Sc., P.Eng.<br>Secret Lab Technologies Ltd.<br>_______________________________________________<br>Linuxppc-dev mailing list<br><a href="mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org
</a><br><a href="https://ozlabs.org/mailman/listinfo/linuxppc-dev" target="_blank">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br></div></div></blockquote></div><br>

------=_Part_7654_9765117.1200800015077--
