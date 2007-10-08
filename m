Return-Path: <ralferoo@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.225])
	by ozlabs.org (Postfix) with ESMTP id DF16FDDFA1
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 08:38:47 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 71so749057wri
	for <linuxppc-dev@ozlabs.org>; Mon, 08 Oct 2007 15:38:46 -0700 (PDT)
Message-ID: <18a15270710081538j85cc680w3815baa80f050ad4@mail.gmail.com>
Date: Mon, 8 Oct 2007 23:38:45 +0100
From: "Ranulf Doswell" <ralf@ranulf.net>
Sender: ralferoo@gmail.com
To: "Geoff Levand" <geoffrey.levand@am.sony.com>
Subject: Re: [patch 2/6] PS3: Remove unused os-area params
In-Reply-To: <470A6E9C.50904@am.sony.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2197_9590929.1191883125938"
References: <20071006213542.311447584@am.sony.com>
	<20071006213542.595771597@am.sony.com>
	<18a15270710080700m514b49f6p7dc9cf6c8f80d6a6@mail.gmail.com>
	<470A6E9C.50904@am.sony.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_2197_9590929.1191883125938
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 08/10/2007, Geoff Levand <geoffrey.levand@am.sony.com> wrote:
>
> Ranulf Doswell wrote:
> >
> > As these values are correctly populated by the hypervisor from the
> > preferences on the standard PS3 OS, it is incredibly useful to have this
> > information available.
>
> No, it is not used, and I never used it.


Maybe I've mistaken how these are used. Having just looked at the source
again, I see that the saved_params field isn't exported.

Am I correct in assuming that this information will still be available in
/dev/ps3flash starting at offset 0x200? That's actually where I'm expecting
to find the information anyway. I believed your patch was changing that
behaviour, although I probably didn't study it enough.

Cheers,
    Ralf.

------=_Part_2197_9590929.1191883125938
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 08/10/2007, <b class="gmail_sendername">Geoff Levand</b> &lt;<a href="mailto:geoffrey.levand@am.sony.com">geoffrey.levand@am.sony.com</a>&gt; wrote:<div><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Ranulf Doswell wrote:<br>&gt;<br>&gt; As these values are correctly populated by the hypervisor from the<br>&gt; preferences on the standard PS3 OS, it is incredibly useful to have this<br>&gt; information available.<br><br>
No, it is not used, and I never used it.</blockquote><div><br>Maybe I&#39;ve mistaken how these are used. Having just looked at the source again, I see that the saved_params field isn&#39;t exported.<br><br>Am I correct in assuming that this information will still be available in /dev/ps3flash starting at offset 0x200? That&#39;s actually where I&#39;m expecting to find the information anyway. I believed your patch was changing that behaviour, although I probably didn&#39;t study it enough.
<br><br></div></div>Cheers,<br>&nbsp;&nbsp;&nbsp; Ralf.<br>

------=_Part_2197_9590929.1191883125938--
