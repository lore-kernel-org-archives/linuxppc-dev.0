Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 4987EDDDA2
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jun 2009 13:26:19 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so3638307yxb.39
	for <linuxppc-dev@ozlabs.org>; Mon, 01 Jun 2009 20:26:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1243911828.5308.2.camel@pasglop>
References: <1243911828.5308.2.camel@pasglop>
Date: Mon, 1 Jun 2009 21:26:16 -0600
Message-ID: <fa686aa40906012026r71b3b75ar13790f7a569d9c08@mail.gmail.com>
Subject: Re: "next" branch update
From: Grant Likely <grant.likely@secretlab.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: multipart/alternative; boundary=001e680f0ce006d533046b551b17
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--001e680f0ce006d533046b551b17
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

How about the iomap_early() patch?  What would you like me to do with that
one?

g.

On Jun 1, 2009 9:04 PM, "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
wrote:

I've updated powerpc "next branch" with the following patches:

(Kumar: The swiotlb patch is still segregated in "test" until we resolve
how it's going to be merged vs. Ian Campbell series).

Anton Blanchard (1):
     powerpc: Convert RTAS event scan from kernel thread to workqueue

Michael Ellerman (3):
     powerpc/ftrace: Use ppc_function_entry() instead of GET_ADDR
     powerpc/ftrace: Remove unused macros
     powerpc/ftrace: Use PPC_INST_NOP directly

Michael Neuling (1):
     powerpc: Make the NR_CPUS max 8192

Michel D=E4nzer (1):
     therm_adt746x: Always clear hardware bit which inverts fan speed range=
.

Nathan Fontenot (1):
     powerpc: Display processor virtualization resource allocs in lparcfg

Stephen Rothwell (1):
     powerpc/pci: Fix annotation of pcibios_claim_one_bus

roel kluin (1):
     tape: beyond ARRAY_SIZE of viocd_diskinfo



_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev

--001e680f0ce006d533046b551b17
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>How about the iomap_early() patch?=A0 What would you like me to do with =
that one?</p>
<p>g.</p>
<p><blockquote type=3D"cite">On Jun 1, 2009 9:04 PM, &quot;Benjamin Herrens=
chmidt&quot; &lt;<a href=3D"mailto:benh@kernel.crashing.org">benh@kernel.cr=
ashing.org</a>&gt; wrote:<br><br>I&#39;ve updated powerpc &quot;next branch=
&quot; with the following patches:<br>

<br>
(Kumar: The swiotlb patch is still segregated in &quot;test&quot; until we =
resolve<br>
how it&#39;s going to be merged vs. Ian Campbell series).<br>
<br>
Anton Blanchard (1):<br>
 =A0 =A0 =A0powerpc: Convert RTAS event scan from kernel thread to workqueu=
e<br>
<br>
Michael Ellerman (3):<br>
 =A0 =A0 =A0powerpc/ftrace: Use ppc_function_entry() instead of GET_ADDR<br=
>
 =A0 =A0 =A0powerpc/ftrace: Remove unused macros<br>
 =A0 =A0 =A0powerpc/ftrace: Use PPC_INST_NOP directly<br>
<br>
Michael Neuling (1):<br>
 =A0 =A0 =A0powerpc: Make the NR_CPUS max 8192<br>
<br>
Michel D=E4nzer (1):<br>
 =A0 =A0 =A0therm_adt746x: Always clear hardware bit which inverts fan spee=
d range.<br>
<br>
Nathan Fontenot (1):<br>
 =A0 =A0 =A0powerpc: Display processor virtualization resource allocs in lp=
arcfg<br>
<br>
Stephen Rothwell (1):<br>
 =A0 =A0 =A0powerpc/pci: Fix annotation of pcibios_claim_one_bus<br>
<br>
roel kluin (1):<br>
 =A0 =A0 =A0tape: beyond ARRAY_SIZE of viocd_diskinfo<br>
<br>
<br>
<br>
_______________________________________________<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org</a><br>
<a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev" target=3D"_bla=
nk">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a></blockquote></p>

--001e680f0ce006d533046b551b17--
