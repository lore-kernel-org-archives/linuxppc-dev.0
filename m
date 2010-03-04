Return-Path: <slightlyunconventional@gmail.com>
MIME-Version: 1.0
Sender: slightlyunconventional@gmail.com
In-Reply-To: <20100301191351.20987.49730.sendpatchset@norville.austin.ibm.com>
References: <20100301191255.20987.84668.sendpatchset@norville.austin.ibm.com>
	<20100301191351.20987.49730.sendpatchset@norville.austin.ibm.com>
Date: Thu, 4 Mar 2010 09:06:40 -0800
Message-ID: <fb412d761003040906i57842fc3t48693d5e5e777176@mail.gmail.com>
Subject: Re: [RFC: PATCH 08/13] powerpc/476: define specific cpu table entry
	for DD1 and DD1.1 cores
From: Hollis Blanchard <hollis@penguinppc.org>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Content-Type: multipart/alternative; boundary=00504502cbfb5adf720480fc9f6b
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>, Torez Smith <torez@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--00504502cbfb5adf720480fc9f6b
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Mar 1, 2010 at 11:13 AM, Dave Kleikamp <shaggy@linux.vnet.ibm.com>wrote:

> powerpc/476: define specific cpu table entry for DD1 and DD1.1 cores
>
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
> There are still some unstable bits on the DD1 and DD1.1 cores.  Don't use
> the FPU or the tlbivax operation.  Define CPU_FTR_476_DD1 and
> CPU_FTR_476_DD1_1 for additional workarounds in later patches.
>
> The DD1 core requires workarounds triggered by both CPU_FTR_476_DD1
> and CPU_FTR_476_DD1_1.  the DD1.1 core only needs CPU_FTR_476_DD1_1
> defined.
>
> Isn't the policy generally not to commit workarounds for early/errataful
hardware which will not be seen in the real world? Otherwise, every new
half-broken core could burn a bunch of feature bits...

-Hollis

--00504502cbfb5adf720480fc9f6b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 1, 2010 at 11:13 AM, Dave Kleikamp <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:shaggy@linux.vnet.ibm.com">shaggy@linux.vnet.ibm.com</a>&gt;</s=
pan> wrote:<br><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote"=
 style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.=
8ex; padding-left: 1ex;">
powerpc/476: define specific cpu table entry for DD1 and DD1.1 cores<br>
<br>
From: Benjamin Herrenschmidt &lt;<a href=3D"mailto:benh@kernel.crashing.org=
">benh@kernel.crashing.org</a>&gt;<br>
<br>
There are still some unstable bits on the DD1 and DD1.1 cores. =A0Don&#39;t=
 use<br>
the FPU or the tlbivax operation. =A0Define CPU_FTR_476_DD1 and<br>
CPU_FTR_476_DD1_1 for additional workarounds in later patches.<br>
<br>
The DD1 core requires workarounds triggered by both CPU_FTR_476_DD1<br>
and CPU_FTR_476_DD1_1. =A0the DD1.1 core only needs CPU_FTR_476_DD1_1<br>
defined.<br><br></blockquote><div>Isn&#39;t the policy generally not to com=
mit workarounds for early/errataful hardware which will not be seen in the =
real world? Otherwise,
every new half-broken core could burn a bunch of feature bits...<br>
<br>
-Hollis<br>=A0</div></div>

--00504502cbfb5adf720480fc9f6b--
