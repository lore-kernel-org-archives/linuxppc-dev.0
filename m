Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B668A1007D2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2011 13:33:40 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----_=_NextPart_001_01CCB488.9BF6D640"
Subject: RE: [PATCH] rapidio/tsi721: Fix mailbox resource reporting
Date: Tue, 6 Dec 2011 18:33:31 -0800
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E55219FC70@CORPEXCH1.na.ads.idt.com>
References: <1323198088-11669-1-git-send-email-alexandre.bounine@idt.com>
 <20111206143638.12598c7b.akpm@linux-foundation.org>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

------_=_NextPart_001_01CCB488.9BF6D640
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Tsi721 patches are applicable to 3.2-rc1 and newer only. Sorry for not =
describing it properly.
This and following patch are fixes for issues found since 3.2-rc1.
I will update changelogs for these patches with more details and =
resubmit them tomorrow.

________________________________

From: linuxppc-dev-bounces+alexandre.bounine=3Didt.com@lists.ozlabs.org =
on behalf of Andrew Morton
Sent: Tue 12/6/2011 5:36 PM
To: Bounine, Alexandre
Cc: linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rapidio/tsi721: Fix mailbox resource reporting



On Tue,  6 Dec 2011 14:01:27 -0500
Alexandre Bounine <alexandre.bounine@idt.com> wrote:

> Report support of four RapidIO mailboxes (MBOX0 - MBOX3) instead of =
MBOX0
> only.

I don't know how important these changes are and I don't know what
their end user visible effects are.  Hence I am unable to decide which
kernel version(s) we should merge the patches into.

That's why these things should always be explained in changelogs,
please.

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev



------_=_NextPart_001_01CCB488.9BF6D640
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD><TITLE>Re: [PATCH] rapidio/tsi721: Fix mailbox =
resource reporting</TITLE>=0A=
<META content=3D"text/html; charset=3Dunicode" http-equiv=3DContent-Type>=0A=
<META name=3DGENERATOR content=3D"MSHTML 9.00.8112.16437"></HEAD>=0A=
<BODY>=0A=
<DIV dir=3Dltr id=3DidOWAReplyText81148>=0A=
<DIV dir=3Dltr><FONT color=3D#000000 size=3D2 =
face=3DArial>Tsi721&nbsp;patches are applicable to 3.2-rc1 and newer =
only. Sorry for not describing it properly.</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2 face=3DArial>This and following patch are =
fixes for issues found since 3.2-rc1.</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT color=3D#000000 size=3D2 face=3DArial>I will =
update&nbsp;changelogs for&nbsp;these patches with more details and =
resubmit them tomorrow.</FONT></DIV>=0A=
<DIV dir=3Dltr><BR>=0A=
<HR tabIndex=3D-1>=0A=
<FONT size=3D2 face=3DTahoma><B>From:</B> =
linuxppc-dev-bounces+alexandre.bounine=3Didt.com@lists.ozlabs.org on =
behalf of Andrew Morton<BR><B>Sent:</B> Tue 12/6/2011 5:36 =
PM<BR><B>To:</B> Bounine, Alexandre<BR><B>Cc:</B> =
linuxppc-dev@lists.ozlabs.org; =
linux-kernel@vger.kernel.org<BR><B>Subject:</B> Re: [PATCH] =
rapidio/tsi721: Fix mailbox resource reporting<BR></FONT><BR></DIV></DIV>=0A=
<DIV>=0A=
<P><FONT size=3D2>On Tue,&nbsp; 6 Dec 2011 14:01:27 -0500<BR>Alexandre =
Bounine &lt;alexandre.bounine@idt.com&gt; wrote:<BR><BR>&gt; Report =
support of four RapidIO mailboxes (MBOX0 - MBOX3) instead of =
MBOX0<BR>&gt; only.<BR><BR>I don't know how important these changes are =
and I don't know what<BR>their end user visible effects are.&nbsp; Hence =
I am unable to decide which<BR>kernel version(s) we should merge the =
patches into.<BR><BR>That's why these things should always be explained =
in =
changelogs,<BR>please.<BR><BR>___________________________________________=
____<BR>Linuxppc-dev mailing list<BR>Linuxppc-dev@lists.ozlabs.org<BR><A =
href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev">https://lists.ozl=
abs.org/listinfo/linuxppc-dev</A><BR></FONT></P></DIV></BODY></HTML>
------_=_NextPart_001_01CCB488.9BF6D640--
