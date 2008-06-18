Return-Path: <jcrigby@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.180])
	by ozlabs.org (Postfix) with ESMTP id 22F52DDE45
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 10:55:57 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so11450pyg.27
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 17:55:56 -0700 (PDT)
Message-ID: <4b73d43f0806171755u7ea8e965rbb62e74559f676c0@mail.gmail.com>
Date: Tue, 17 Jun 2008 18:55:55 -0600
From: "John Rigby" <jcrigby@gmail.com>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
Subject: Re: [PATCH] MPC5121 FEC support
In-Reply-To: <20080618103549.06110799.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_16781_3510628.1213750555721"
References: <1213724880-14965-1-git-send-email-jrigby@freescale.com>
	<20080618103549.06110799.sfr@canb.auug.org.au>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_16781_3510628.1213750555721
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, Jun 17, 2008 at 6:35 PM, Stephen Rothwell <sfr@canb.auug.org.au>
wrote:

> Hi John,
>
> You should factor out the fec_t -> struct fec change into an earlier
> patch of its own.

Ok, I'll separate that from the checkpatch fixes.

>
>
> On Tue, 17 Jun 2008 11:48:00 -0600 John Rigby <jrigby@freescale.com>
> wrote:
> >
> > +++ b/drivers/net/fs_enet/fec_mpc5121.h
>
> > +#include <asm/cpm.h>
>

>
> Nothing in this file uses anything in asm/cpm.h, so it shouldn't be
> included here.

Ok.

>
>
> --
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/ <http://www.canb.auug.org.au/%7Esfr/>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>

------=_Part_16781_3510628.1213750555721
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div class="gmail_quote">On Tue, Jun 17, 2008 at 6:35 PM, Stephen Rothwell &lt;<a href="mailto:sfr@canb.auug.org.au">sfr@canb.auug.org.au</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi John,<br>
<br>
You should factor out the fec_t -&gt; struct fec change into an earlier<br>
patch of its own.</blockquote><div>Ok, I&#39;ll separate that from the checkpatch fixes. <br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
<br>
On Tue, 17 Jun 2008 11:48:00 -0600 John Rigby &lt;<a href="mailto:jrigby@freescale.com">jrigby@freescale.com</a>&gt; wrote:<br>
&gt;<br>
&gt; +++ b/drivers/net/fs_enet/fec_mpc5121.h<br>
<br>
&gt; +#include &lt;asm/cpm.h&gt;&nbsp;<br></blockquote><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<br>
Nothing in this file uses anything in asm/cpm.h, so it shouldn&#39;t be<br>
included here.</blockquote><div>Ok. <br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<font color="#888888"><br>
--<br>
Cheers,<br>
Stephen Rothwell &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<a href="mailto:sfr@canb.auug.org.au">sfr@canb.auug.org.au</a><br>
<a href="http://www.canb.auug.org.au/%7Esfr/" target="_blank">http://www.canb.auug.org.au/~sfr/</a><br>
</font><br>_______________________________________________<br>
Linuxppc-dev mailing list<br>
<a href="mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org</a><br>
<a href="https://ozlabs.org/mailman/listinfo/linuxppc-dev" target="_blank">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br></blockquote></div><br>

------=_Part_16781_3510628.1213750555721--
