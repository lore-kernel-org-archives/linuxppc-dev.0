Return-Path: <dagriego@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.201])
	by ozlabs.org (Postfix) with ESMTP id 7096D679E0
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Mar 2006 01:32:57 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id 13so436532nzp
	for <linuxppc-dev@ozlabs.org>; Thu, 02 Mar 2006 06:32:56 -0800 (PST)
Message-ID: <3d42041d0603020632o2d75bd7ao99c7b006042a88d9@mail.gmail.com>
Date: Thu, 2 Mar 2006 07:32:56 -0700
From: dagriego <dagriego@gmail.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [Fastboot] Re: Kexec for booke PPC processors
In-Reply-To: <Pine.LNX.4.44.0603011746320.10931-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_6334_21432851.1141309976277"
References: <200603021012.57955.michael@ellerman.id.au>
	<Pine.LNX.4.44.0603011746320.10931-100000@gate.crashing.org>
Cc: Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@ozlabs.org,
	fastboot@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_6334_21432851.1141309976277
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I'm working on the E500 core, particularly the mpc8540/8560ADS boards
- David

On 3/1/06, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> > On Thu, 2 Mar 2006 09:43, dagriego wrote:
> > > I'm finishing my first pass on getting kexec to work on PPC booke
> > > processor, and needed some insight into how to pass information from
> the
> > > first kernel to the kexec'ed kernel.  This information is the board
> > > information that the first kernel is given in r3 from the board
> firmware.
> > > Is there a standard convention for passing this information?
> >
> > Yep, it's called the flat device tree.
>
> Which PPC booke are you trying to get this to work on?
>
> - kumar
>
>

------=_Part_6334_21432851.1141309976277
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I'm working on the E500 core, particularly the mpc8540/8560ADS boards<br>

- David<br><br><div><span class=3D"gmail_quote">On 3/1/06, <b class=3D"gmai=
l_sendername">Kumar Gala</b> &lt;<a href=3D"mailto:galak@kernel.crashing.or=
g">galak@kernel.crashing.org</a>&gt; wrote:</span><blockquote class=3D"gmai=
l_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0p=
t 0pt 0.8ex; padding-left: 1ex;">
&gt; On Thu, 2 Mar 2006 09:43, dagriego wrote:<br>&gt; &gt; I'm finishing m=
y first pass on getting kexec to work on PPC booke<br>&gt; &gt; processor, =
and needed some insight into how to pass information from the<br>&gt; &gt; =
first kernel to the kexec'ed kernel.&nbsp;&nbsp;This information is the boa=
rd
<br>&gt; &gt; information that the first kernel is given in r3 from the boa=
rd firmware.<br>&gt; &gt; Is there a standard convention for passing this i=
nformation?<br>&gt;<br>&gt; Yep, it's called the flat device tree.<br><br>
Which PPC booke are you trying to get this to work on?<br><br>- kumar<br><b=
r></blockquote></div><br>

------=_Part_6334_21432851.1141309976277--
