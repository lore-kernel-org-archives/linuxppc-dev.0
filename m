Return-Path: <sanjeevfiles@yahoo.com>
Received: from web63002.mail.re1.yahoo.com (web63002.mail.re1.yahoo.com
	[69.147.96.213]) by ozlabs.org (Postfix) with SMTP id C6284B7D60
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  2 May 2010 20:27:15 +1000 (EST)
Message-ID: <832265.7605.qm@web63002.mail.re1.yahoo.com>
Date: Sun, 2 May 2010 03:27:12 -0700 (PDT)
From: Maindoor <sanjeevfiles@yahoo.com>
Subject: Re: [PATCH] Fix DEBUG_PAGEALLOC on 603/e300
To: Xianghua Xiao <xiaoxianghua@gmail.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1272493790.24542.109.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1324963604-1272796032=:7605"
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0-1324963604-1272796032=:7605
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Any updates on this ? I need something similar.

Thanks,
Maindoor.

--- On Thu, 4/29/10, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrot=
e:

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Fix DEBUG_PAGEALLOC on 603/e300
To: "Xianghua Xiao" <xiaoxianghua@gmail.com>
Cc: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>
Date: Thursday, April 29, 2010, 3:59 AM

On Wed, 2010-04-28 at 14:15 -0500, Xianghua Xiao wrote:
> This change works me on a 834x(e300) platform, tested with lmbench and
> a production-ready application with 2.6.33.3.

But have you tested that DEBUG_PAGEALLOC actually works ? :-)

A way to do that is to

=A0=A0=A0 - get_free_pages a page
=A0=A0=A0 - read from it
=A0=A0=A0 - free it
=A0=A0=A0 - write to it

It should oops on the write, and I suspect that without my patch it
doesn't.

Cheers,
Ben.


_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev
=0A=0A=0A      
--0-1324963604-1272796032=:7605
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">Any updates on this ? I need something simila=
r.<br><br>Thanks,<br>Maindoor.<br><br>--- On <b>Thu, 4/29/10, Benjamin Herr=
enschmidt <i>&lt;benh@kernel.crashing.org&gt;</i></b> wrote:<br><blockquote=
 style=3D"border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; paddin=
g-left: 5px;"><br>From: Benjamin Herrenschmidt &lt;benh@kernel.crashing.org=
&gt;<br>Subject: Re: [PATCH] Fix DEBUG_PAGEALLOC on 603/e300<br>To: "Xiangh=
ua Xiao" &lt;xiaoxianghua@gmail.com&gt;<br>Cc: "linuxppc-dev" &lt;linuxppc-=
dev@lists.ozlabs.org&gt;<br>Date: Thursday, April 29, 2010, 3:59 AM<br><br>=
<div class=3D"plainMail">On Wed, 2010-04-28 at 14:15 -0500, Xianghua Xiao w=
rote:<br>&gt; This change works me on a 834x(e300) platform, tested with lm=
bench and<br>&gt; a production-ready application with 2.6.33.3.<br><br>But =
have you tested that DEBUG_PAGEALLOC actually works ? :-)<br><br>A way to d=
o that
 is to<br><br>&nbsp;&nbsp;&nbsp; - get_free_pages a page<br>&nbsp;&nbsp;&nb=
sp; - read from it<br>&nbsp;&nbsp;&nbsp; - free it<br>&nbsp;&nbsp;&nbsp; - =
write to it<br><br>It should oops on the write, and I suspect that without =
my patch it<br>doesn't.<br><br>Cheers,<br>Ben.<br><br><br>_________________=
______________________________<br>Linuxppc-dev mailing list<br><a ymailto=
=3D"mailto:Linuxppc-dev@lists.ozlabs.org" href=3D"/mc/compose?to=3DLinuxppc=
-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.org</a><br><a href=3D"http=
s://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_blank">https://lists=
.ozlabs.org/listinfo/linuxppc-dev</a><br></div></blockquote></td></tr></tab=
le><br>=0A=0A      
--0-1324963604-1272796032=:7605--
