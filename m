Return-Path: <bsingharora@gmail.com>
Received: from mail-qk0-x243.google.com (mail-qk0-x243.google.com
 [IPv6:2607:f8b0:400d:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wnZpL3Cd4zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 15:25:14 +1000 (AEST)
Received: by mail-qk0-x243.google.com with SMTP id r62so6493031qkf.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 22:25:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ca6ef126-4bc7-5b93-11d1-1342c46fa9b6@linux.vnet.ibm.com>
References: <3bb44d92-b2ff-e197-4bdf-ec6d588d6dab@linux.vnet.ibm.com>
 <1c1d70e3-4e45-b035-0e75-1b0f531c111b@linux.vnet.ibm.com>
 <20170523214922.bns675oqzqj4pkhc@arbab-laptop.localdomain>
 <ee96df3d-ad0f-c4dc-e7d5-290018ec8afd@linux.vnet.ibm.com>
 <87poeya4dt.fsf@concordia.ellerman.id.au>
 <8e2417d8-d108-2949-40f2-997d53a3f367@linux.vnet.ibm.com>
 <87a861a25y.fsf@concordia.ellerman.id.au>
 <20170525151011.m4ae4ipxbqsj3mn7@arbab-laptop.localdomain>
 <87zie08ekt.fsf@concordia.ellerman.id.au>
 <20170526143147.z4lmtrs7vowucbkf@arbab-laptop.localdomain>
 <87lgpg6xe2.fsf@concordia.ellerman.id.au>
 <54877b2b-8446-20f6-e316-25af809ae11f@linux.vnet.ibm.com>
 <87tw402go0.fsf@concordia.ellerman.id.au>
 <54ebacf1-1249-cc6a-80a5-b293e581f401@linux.vnet.ibm.com>
 <8760g9qwfd.fsf@concordia.ellerman.id.au>
 <ba7d7010-44ed-cc20-661c-2078f0f522b7@linux.vnet.ibm.com>
 <87tw3sdmpj.fsf@concordia.ellerman.id.au>
 <d0027ac9-48cb-2d31-ce26-a29c0fc0a32c@linux.vnet.ibm.com>
 <87o9tsgo9b.fsf@concordia.ellerman.id.au>
 <ca6ef126-4bc7-5b93-11d1-1342c46fa9b6@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 14 Jun 2017 15:25:10 +1000
Message-ID: <CAKTCnz==4vA4PevndTLF7p2PPKCM8ZkqpuCXPp9kFcjn+CqUKA@mail.gmail.com>
Subject: Re: RESEND Re: [Patch 2/2]: powerpc/hotplug/mm: Fix hot-add memory
 node assoc
To: Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Reza Arbab <arbab@linux.vnet.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Shailendra Singh <shailendras@nvidia.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michael Bringmann from Kernel Team <mbringm@us.ibm.com>
Content-Type: multipart/alternative; boundary="94eb2c06686ab1e5d30551e4c6fa"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--94eb2c06686ab1e5d30551e4c6fa
Content-Type: text/plain; charset="UTF-8"

On Wed, Jun 14, 2017 at 8:21 AM, Michael Bringmann <mwb@linux.vnet.ibm.com>
wrote:

> On a related note, we are discussing the addition of 2 new device-tree
> properties
> with Pete Heyrman and his fellows that should simplify the determination
> of the
> set of required nodes.
>
> * One property would provide the total/max number of nodes needed by the
> kernel
>   on the current hardware.
>

Yes, that would be nice to have


> * A second property would provide the total/max number of nodes that the
> kernel
>   could use on any system to which it could be migrated.
>
>
Not sure about this one, are you suggesting more memory can be added
depending on the migration target?



> These properties aren't available, yet, and it takes time to define new
> properties
> in the PAPR and have them implemented in pHyp and the kernel.  As an
> intermediary
> step, the systems which are doing a lot of dynamic hot-add/hot-remove
> configuration
> could provide equivalent information to the PowerPC kernel with a command
> line
> parameter.  The 'numa.c' code would then read this value and fill in the
> necessary
> entries in the 'node_possible_map'.
>
> Would you foresee any problems with using such a feature?
>


Balbir Singh

--94eb2c06686ab1e5d30551e4c6fa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Wed, Jun 14, 2017 at 8:21 AM, Michael Bringmann <span dir=3D"ltr">&l=
t;<a href=3D"mailto:mwb@linux.vnet.ibm.com" target=3D"_blank">mwb@linux.vne=
t.ibm.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On a rel=
ated note, we are discussing the addition of 2 new device-tree properties<b=
r>
with Pete Heyrman and his fellows that should simplify the determination of=
 the<br>
set of required nodes.<br>
<br>
* One property would provide the total/max number of nodes needed by the ke=
rnel<br>
=C2=A0 on the current hardware.<br></blockquote><div><br></div><div>Yes, th=
at would be nice to have</div><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
* A second property would provide the total/max number of nodes that the ke=
rnel<br>
=C2=A0 could use on any system to which it could be migrated.<br>
<br></blockquote><div><br></div><div>Not sure about this one, are you sugge=
sting more memory can be added</div><div>depending on the migration target?=
</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
These properties aren&#39;t available, yet, and it takes time to define new=
 properties<br>
in the PAPR and have them implemented in pHyp and the kernel.=C2=A0 As an i=
ntermediary<br>
step, the systems which are doing a lot of dynamic hot-add/hot-remove confi=
guration<br>
could provide equivalent information to the PowerPC kernel with a command l=
ine<br>
parameter.=C2=A0 The &#39;numa.c&#39; code would then read this value and f=
ill in the necessary<br>
entries in the &#39;node_possible_map&#39;.<br>
<br>
Would you foresee any problems with using such a feature?<br></blockquote><=
div><br></div><div><br></div><div>Balbir Singh=C2=A0</div></div></div></div=
>

--94eb2c06686ab1e5d30551e4c6fa--
