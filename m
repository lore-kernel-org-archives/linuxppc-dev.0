Return-Path: <michael.neuling@gmail.com>
Received: from mail-lb0-x22d.google.com (mail-lb0-x22d.google.com
 [IPv6:2a00:1450:4010:c04::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 052BB1A06D7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 May 2014 19:44:14 +1000 (EST)
Received: by mail-lb0-f173.google.com with SMTP id 10so874093lbg.32
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 May 2014 02:44:08 -0700 (PDT)
MIME-Version: 1.0
Sender: michael.neuling@gmail.com
In-Reply-To: <53884BC6.8030904@suse.de>
References: <1401106626-13130-1-git-send-email-paulus@samba.org>
 <1401106626-13130-4-git-send-email-paulus@samba.org>
 <5385E620.5090703@suse.de>
 <1401342462.4116.4.camel@ale.ozlabs.ibm.com>
 <1401344549.4116.8.camel@ale.ozlabs.ibm.com>
 <BD1CF085-FEBC-4208-AD3F-C55DB002097F@suse.de>
 <1401349547.4116.19.camel@ale.ozlabs.ibm.com>
 <1401440207.29324.10.camel@concordia>
 <1401441046.13479.2.camel@ale.ozlabs.ibm.com>
 <53884BC6.8030904@suse.de>
Date: Fri, 30 May 2014 19:44:08 +1000
Message-ID: <CAEjGV6ym8pX6eOzcPb+CY7U-wDUSp5wKBOBuW3m1ZmKzSdhyfg@mail.gmail.com>
Subject: Re: powerpc/pseries: Use new defines when calling h_set_mode
From: Michael Neuling <mikey@neuling.org>
To: Alexander Graf <agraf@suse.de>
Content-Type: multipart/alternative; boundary=089e01537baa19116304fa9ae300
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--089e01537baa19116304fa9ae300
Content-Type: text/plain; charset=UTF-8

>>>
>>> Which header are these coming from, and why aren't we including it? And
is it
>>> going to still build with CONFIG_KVM=n?
>>
>>  From include/asm/hvcall.h in the h_set_mode patch set I sent before.
>>
>> And yes it compiles with CONFIG_KVM=n fine.
>
>
> Please split that patch into one that adds the definitions and one that
changes the KVM code to use those definitions. Both Ben and me can then
apply the definition patch and our respective tree patch.
>

Why don't you just take the original h_set_mode patch and I'll repost this
cleanup later to ben when yours is upstream.  This cleanup patch is not
critical to anything and it avoid more churn.

Mikey

--089e01537baa19116304fa9ae300
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Which header are these coming from, and why aren&#39;t we incl=
uding it? And is it<br>
&gt;&gt;&gt; going to still build with CONFIG_KVM=3Dn?<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0From include/asm/hvcall.h in the h_set_mode patch set I sent=
 before.<br>
&gt;&gt;<br>
&gt;&gt; And yes it compiles with CONFIG_KVM=3Dn fine.<br>
&gt;<br>
&gt;<br>
&gt; Please split that patch into one that adds the definitions and one tha=
t changes the KVM code to use those definitions. Both Ben and me can then a=
pply the definition patch and our respective tree patch.<br>
&gt;</p>
<p dir=3D"ltr">Why don&#39;t you just take the original h_set_mode patch an=
d I&#39;ll repost this cleanup later to ben when yours is upstream.=C2=A0 T=
his cleanup patch is not critical to anything and it avoid more churn.</p>
<p dir=3D"ltr">Mikey</p>

--089e01537baa19116304fa9ae300--
