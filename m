Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xstw43j2RzDqsP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 06:45:24 +1000 (AEST)
Date: Thu, 14 Sep 2017 06:45:20 +1000
In-Reply-To: <20170913181116.7c202661@kitsune.suse.cz>
References: <20170720015322.24307-1-npiggin@gmail.com>
 <3xNQyy1Ck3z9s7v@ozlabs.org> <20170913181116.7c202661@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----DEHMNEACHNVZ4ZG39C0JTOSRY347M2"
Subject: Re: POWER9 PMU stops after idle workaround
To: =?ISO-8859-1?Q?Michal_Such=E1nek?= <msuchanek@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>
CC: Michael Ellerman <patch-notifications@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Madhavan Srinivasan <masriniv@in.ibm.com>,
 Gautham R Shenoy <ego@linux.vnet.ibm.com>, Michael Neuling <mikey@neuling.org>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <michael@ellerman.id.au>
Message-ID: <28856C53-7CC6-4250-909E-27FD80029F19@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

------DEHMNEACHNVZ4ZG39C0JTOSRY347M2
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yeah I messed up the subject when comitting, from memory, so I had to rebas=
e and force push=2E

I think this is it:

https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/powerpc/linux=2Egit/co=
mmit/?id=3D09539f9b123652e969894d6299ae0df2fe12cb5d

cheers



On 14 September 2017 2:11:16 am AEST, "Michal Such=C3=A1nek" <msuchanek@su=
se=2Ede> wrote:
>On Thu,  3 Aug 2017 20:19:38 +1000 (AEST)
>Michael Ellerman <patch-notifications@ellerman=2Eid=2Eau> wrote:
>
>> On Thu, 2017-07-20 at 01:53:22 UTC, Nicholas Piggin wrote:
>> > POWER9 DD2 PMU can stop after a state-loss idle in some conditions=2E
>> >=20
>> > A solution is to set then clear MMCRA[60] after wake from
>state-loss
>> > idle=2E
>> >=20
>> > Signed-off-by: Nicholas Piggin <npiggin@gmail=2Ecom>
>> > Acked-by: Madhavan Srinivasan <maddy@linux=2Evnet=2Eibm=2Ecom>
>> > Reviewed-by: Vaidyanathan Srinivasan <svaidy@linux=2Evnet=2Eibm=2Ecom=
>
>> > Acked-by: Anton Blanchard <anton@samba=2Eorg> =20
>>=20
>> Applied to powerpc fixes, thanks=2E
>>=20
>> https://git=2Ekernel=2Eorg/powerpc/c/bdd21ddb919d28f9c62cdc6286cac9
>>=20
>> cheers
>
>Not there anymore=2E I see this only in the merge branch=2E
>
>Thanks
>
>Michal

--=20
Sent from my Android phone with K-9 Mail=2E Please excuse my brevity=2E
------DEHMNEACHNVZ4ZG39C0JTOSRY347M2
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body>Yeah I messed up the subject when comitting, from =
memory, so I had to rebase and force push=2E<br>
<br>
I think this is it:<br>
<br>
<a href=3D"https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/powerpc/lin=
ux=2Egit/commit/?id=3D09539f9b123652e969894d6299ae0df2fe12cb5d">https://git=
=2Ekernel=2Eorg/pub/scm/linux/kernel/git/powerpc/linux=2Egit/commit/?id=3D0=
9539f9b123652e969894d6299ae0df2fe12cb5d</a><br>
<br>
cheers<br>
<br>
<br><br><div class=3D"gmail_quote">On 14 September 2017 2:11:16 am AEST, &=
quot;Michal Such=C3=A1nek&quot; &lt;msuchanek@suse=2Ede&gt; wrote:<blockquo=
te class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0=2E8ex; border-left:=
 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<pre class=3D"k9mail">On Thu,  3 Aug 2017 20:19:38 +1000 (AEST)<br />Micha=
el Ellerman &lt;patch-notifications@ellerman=2Eid=2Eau&gt; wrote:<br /><br =
/><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 1ex 0=2E8ex; b=
order-left: 1px solid #729fcf; padding-left: 1ex;"> On Thu, 2017-07-20 at 0=
1:53:22 UTC, Nicholas Piggin wrote:<br /><blockquote class=3D"gmail_quote" =
style=3D"margin: 0pt 0pt 1ex 0=2E8ex; border-left: 1px solid #ad7fa8; paddi=
ng-left: 1ex;"> POWER9 DD2 PMU can stop after a state-loss idle in some con=
ditions=2E<br /> <br /> A solution is to set then clear MMCRA[60] after wak=
e from state-loss<br /> idle=2E<br /> <br /> Signed-off-by: Nicholas Piggin=
 &lt;npiggin@gmail=2Ecom&gt;<br /> Acked-by: Madhavan Srinivasan &lt;maddy@=
linux=2Evnet=2Eibm=2Ecom&gt;<br /> Reviewed-by: Vaidyanathan Srinivasan &lt=
;svaidy@linux=2Evnet=2Eibm=2Ecom&gt;<br /> Acked-by: Anton Blanchard &lt;an=
ton@samba=2Eorg&gt;  <br /></blockquote> <br /> Applied to powerpc fixes, t=
hanks=2E<br /> <br /> <a href=3D"https://git=2Ekernel=2Eorg/powerpc/c/bdd21=
ddb919d28f9c62cdc6286cac9">https://git=2Ekernel=2Eorg/powerpc/c/bdd21ddb919=
d28f9c62cdc6286cac9</a><br /> <br /> cheers<br /></blockquote><br />Not the=
re anymore=2E I see this only in the merge branch=2E<br /><br />Thanks<br /=
><br />Michal<br /><br /></pre></blockquote></div><br>
-- <br>
Sent from my Android phone with K-9 Mail=2E Please excuse my brevity=2E</b=
ody></html>
------DEHMNEACHNVZ4ZG39C0JTOSRY347M2--
