Return-Path: <manoj.shar@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.204])
	by ozlabs.org (Postfix) with ESMTP id C0DB967BC9
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 10:59:29 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id i1so213567nzh
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 17:59:28 -0700 (PDT)
Message-ID: <d6dada100609201759r5dd047d7y2b60684d9c4feaa8@mail.gmail.com>
Date: Wed, 20 Sep 2006 17:59:28 -0700
From: "Manoj Sharma" <manoj.shar@gmail.com>
To: "Linas Vepstas" <linas@austin.ibm.com>
Subject: Re: Hang with isync
In-Reply-To: <20060920230406.GU29167@austin.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_174217_654106.1158800368481"
References: <d6dada100609181828j1804f4f5ic0d1dd8a225980c@mail.gmail.com>
	<d6dada100609191816q75d1455cobeb1e0bd21dab8a8@mail.gmail.com>
	<1158788111.6002.310.camel@localhost.localdomain>
	<d6dada100609201531oefd71ch8557067bbf77484e@mail.gmail.com>
	<1158791893.6002.327.camel@localhost.localdomain>
	<20060920230406.GU29167@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_174217_654106.1158800368481
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

No MSR is 00029030 and user mode bit is not set here.

I had missed it in the prev mail:

=05NIP: C0005DA4 XER: 20000000 LR: C0004FE4 SP: C01F3000=05 REGS: c01eff30 =
TRAP:
1020    Not tainted
MSR: 00029030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK =3D c01f1080[0] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
=05PLB0: bear=3D 0x08000000 acr=3D   0xbb000000 besr=3D  0x00000000


On 9/20/06, Linas Vepstas <linas@austin.ibm.com> wrote:
>
> On Thu, Sep 21, 2006 at 08:38:13AM +1000, Benjamin Herrenschmidt wrote:
> > On Wed, 2006-09-20 at 15:31 -0700, Manoj Sharma wrote:
> > > This is the stack trace.
> > >
> > > Registers:
> > > GPR00: 00069030
>
> This is the MSR and it has the user-mode bit set, which is surely wrong.
> This is not how one gets to user space.
>
> 00048000
>
> The MSR had this or'ed into it, which is setting the user-mode bit.
> Surely that's wrong.
>
> --linas
>

------=_Part_174217_654106.1158800368481
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>No MSR is 00029030 and user mode bit is not set here.<br><br>I had miss=
ed it in the prev mail:<br><br>=05NIP: C0005DA4 XER: 20000000 LR: C0004FE4 =
SP: C01F3000=05 REGS: c01eff30 TRAP: 1020&nbsp;&nbsp;&nbsp; Not tainted<br>=
MSR: 00029030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
<br>TASK =3D c01f1080[0] 'swapper' Last syscall: 120<br>last math 00000000 =
last altivec 00000000<br>=05PLB0: bear=3D 0x08000000 acr=3D&nbsp;&nbsp; 0xb=
b000000 besr=3D&nbsp; 0x00000000<br><br><br><div><span class=3D"gmail_quote=
">On 9/20/06, <b class=3D"gmail_sendername">
Linas Vepstas</b> &lt;<a href=3D"mailto:linas@austin.ibm.com">linas@austin.=
ibm.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"bor=
der-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-=
left: 1ex;">
On Thu, Sep 21, 2006 at 08:38:13AM +1000, Benjamin Herrenschmidt wrote:<br>=
&gt; On Wed, 2006-09-20 at 15:31 -0700, Manoj Sharma wrote:<br>&gt; &gt; Th=
is is the stack trace.<br>&gt; &gt;<br>&gt; &gt; Registers:<br>&gt; &gt; GP=
R00: 00069030
<br><br>This is the MSR and it has the user-mode bit set, which is surely w=
rong.<br>This is not how one gets to user space.<br><br>00048000<br><br>The=
 MSR had this or'ed into it, which is setting the user-mode bit.<br>Surely =
that's wrong.
<br><br>--linas<br></blockquote></div><br>

------=_Part_174217_654106.1158800368481--
