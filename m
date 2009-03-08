Return-Path: <ben.menchaca@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 5BD17DDF3D
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Mar 2009 14:15:15 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so490142ywb.39
	for <linuxppc-dev@ozlabs.org>; Sat, 07 Mar 2009 19:15:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1236462686.7260.161.camel@pasglop>
References: <64ac01180903052032i75792fa6x864f91c511b3f228@mail.gmail.com>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF73@zch01exm21.fsl.freescale.net>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF75@zch01exm21.fsl.freescale.net>
	<64ac01180903052138k4226022cq840d497dccecd939@mail.gmail.com>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF81@zch01exm21.fsl.freescale.net>
	<64ac01180903052210r2aee7246g50fd0656c491a40b@mail.gmail.com>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF98@zch01exm21.fsl.freescale.net>
	<64ac01180903060812n1f355207lb3fa6de3ed17ae41@mail.gmail.com>
	<1236462686.7260.161.camel@pasglop>
Date: Sat, 7 Mar 2009 21:15:13 -0600
Message-ID: <64ac01180903071915lf27669fq813a5e3842c0c2a1@mail.gmail.com>
Subject: Re: 83xx: Marking or Allocating Pages as Cache-Inhibited
From: Ben Menchaca <ben.menchaca@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: multipart/alternative; boundary=00221532c5b41fd9ba046492edd7
Cc: linuxppc-dev@ozlabs.org, Liu Dave-R63238 <DaveLiu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--00221532c5b41fd9ba046492edd7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Sat, Mar 7, 2009 at 3:51 PM, Benjamin Herrenschmidt <
benh@kernel.crashing.org> wrote:

> On Fri, 2009-03-06 at 10:12 -0600, Ben Menchaca wrote:
> > Testing now...it looks like it (almost) works, though!  Why does
> > setting no-snoop cause snooping to work?  More on the effect on
> > setting that bit in a few minutes...need more testing.
>
> Maybe they got the documentation for that bit backward ? :-)


For posterity...it does appear that this is the case.  I don't have a bus
analyzer to watch the transaction, but a JTAG trigger caught the update
happening if and only if bit 3 was set in the (R|W)DMA descriptor.  My FAE
at FS said he is watching this thread, so hopefully some doc errata can be
generated so others can avoid my confusion :-).

- Ben

--00221532c5b41fd9ba046492edd7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Sat, Mar 7, 2009 at 3:51 PM, Benjamin Herrens=
chmidt <span dir=3D"ltr">&lt;<a href=3D"mailto:benh@kernel.crashing.org">be=
nh@kernel.crashing.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt =
0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">On Fri, 2009-03-06 at 10:12 -0600, Ben Menchaca wrote:<br=
>
&gt; Testing now...it looks like it (almost) works, though! =A0Why does<br>
&gt; setting no-snoop cause snooping to work? =A0More on the effect on<br>
&gt; setting that bit in a few minutes...need more testing.<br>
<br>
</div>Maybe they got the documentation for that bit backward ? :-)</blockqu=
ote><div><br>For posterity...it does appear that this is the case.=A0 I don=
&#39;t have a bus analyzer to watch the transaction, but a JTAG trigger cau=
ght the update happening if and only if bit 3 was set in the (R|W)DMA descr=
iptor.=A0 My FAE at FS said he is watching this thread, so hopefully some d=
oc errata can be generated so others can avoid my confusion :-).<br>
<br>- Ben<br></div></div><br>

--00221532c5b41fd9ba046492edd7--
