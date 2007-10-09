Return-Path: <ralferoo@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.230])
	by ozlabs.org (Postfix) with ESMTP id 2B642DDEFF
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 22:23:42 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 71so831724wri
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Oct 2007 05:23:41 -0700 (PDT)
Message-ID: <18a15270710090523l7bf3d823r33ec9af4bcabc44d@mail.gmail.com>
Date: Tue, 9 Oct 2007 13:23:41 +0100
From: "Ranulf Doswell" <ralf@ranulf.net>
Sender: ralferoo@gmail.com
To: "Geert Uytterhoeven" <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 6/6] PS3: Add os-area database routines
In-Reply-To: <Pine.LNX.4.62.0710091135240.6961@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5020_16254858.1191932621174"
References: <20071006213542.311447584@am.sony.com>
	<20071006213542.954029915@am.sony.com>
	<18a15270710080648x3b5f1135meea3d7b048a1a543@mail.gmail.com>
	<470A6E4E.5090009@am.sony.com>
	<18a15270710081559m3236126r85f797718300756f@mail.gmail.com>
	<Pine.LNX.4.62.0710091135240.6961@pademelon.sonytel.be>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_5020_16254858.1191932621174
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 09/10/2007, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
>
> On Mon, 8 Oct 2007, Ranulf Doswell wrote:
> > However, in this case the only data required is a single identifier used
> to
> > identify one PS3 from another, and in fact this single 64-bit token can
> be
> > shared amongst many other applications that require the same function -
> > certainly I intend to expose it in a common way in my games library's
> API
> > for all users of the library.
>
> MAC address?
>

Indeed, that's perfect! That solution also just occurred to me whilst
walking back from lunch and when I come back to check my e-mail you've
already suggested it! Funny how I've been ignoring the most obvious answer
for weeks!

Cheers,
    Ralf.

------=_Part_5020_16254858.1191932621174
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 09/10/2007, <b class="gmail_sendername">Geert Uytterhoeven</b> &lt;<a href="mailto:Geert.Uytterhoeven@sonycom.com">Geert.Uytterhoeven@sonycom.com</a>&gt; wrote:<div><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Mon, 8 Oct 2007, Ranulf Doswell wrote:<br>&gt; However, in this case the only data required is a single identifier used to<br>&gt; identify one PS3 from another, and in fact this single 64-bit token can be<br>&gt; shared amongst many other applications that require the same function -
<br>&gt; certainly I intend to expose it in a common way in my games library&#39;s API<br>&gt; for all users of the library.<br><br>MAC address?<br></blockquote></div><br>Indeed, that&#39;s perfect! That solution also just occurred to me whilst walking back from lunch and when I come back to check my e-mail you&#39;ve already suggested it! Funny how I&#39;ve been ignoring the most obvious answer for weeks!
<br><br>Cheers,<br>&nbsp;&nbsp;&nbsp; Ralf.<br>

------=_Part_5020_16254858.1191932621174--
