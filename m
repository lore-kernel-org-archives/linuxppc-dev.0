Return-Path: <michael.heltne@gmail.com>
Received: from mail-yk0-x22e.google.com (mail-yk0-x22e.google.com
 [IPv6:2607:f8b0:4002:c07::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 014751A0202
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 04:55:02 +1100 (AEDT)
Received: by mail-yk0-x22e.google.com with SMTP id u9so59909047ykd.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Feb 2016 09:55:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJhHMCD1_o3XnHJXunxyYP8j_UpfxTG-M_utR2Cfvq5XozsBNQ@mail.gmail.com>
References: <CANtoAtNkjrJfac0nR7ay7LKToMf53KtpVZNv0+xabHn1QSwRkA@mail.gmail.com>
 <CAJhHMCA6wy=i=yD4S-D0-vRTAOadTbwEtarsawK0BLw23G2Shg@mail.gmail.com>
 <878u336210.fsf@linux.vnet.ibm.com>
 <CAJhHMCD1_o3XnHJXunxyYP8j_UpfxTG-M_utR2Cfvq5XozsBNQ@mail.gmail.com>
Date: Tue, 2 Feb 2016 17:55:00 +0000
Message-ID: <CANtoAtPo75zuPpnMSfKFAgRdcOUc7k-v1k6zEebmSYcEQ2okkg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Failure_on_latest_GIT_=2D_implicit_declaration_of_?=
 =?UTF-8?Q?function_=E2=80=98pte=5Fswp=5Fclear=5Fsoft=5Fdirty=E2=80=99?=
From: Mike <michael.heltne@gmail.com>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
Content-Type: multipart/alternative; boundary=94eb2c0a912249288d052acd3364
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--94eb2c0a912249288d052acd3364
Content-Type: text/plain; charset=UTF-8

Agreed, raised an eyebrow initially when select ppc64 and 32 :D

I'll give a word on the trackpad issue later, cant remember seeing any
changes that ought effect it really. guess the compile is done in a good
hour or so, took the tiime to slim it down to someting reasonable

Thanks man
On 2 Feb 2016 18:14, "Pranith Kumar" <bobby.prani@gmail.com> wrote:

> On Tue, Feb 2, 2016 at 1:48 AM, Aneesh Kumar K.V
> <aneesh.kumar@linux.vnet.ibm.com> wrote:
> >
> > This patch didn't work for you ?
> >
> >
> http://mid.gmane.org/1454086969-21074-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com
> >
>
> This actually is a better patch. I didn't realize that we have the _64
> version.
>
> Thanks!
> --
> Pranith
>

--94eb2c0a912249288d052acd3364
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Agreed, raised an eyebrow initially when select ppc64 and 32=
 :D </p>
<p dir=3D"ltr">I&#39;ll give a word on the trackpad issue later, cant remem=
ber seeing any changes that ought effect it really. guess the compile is do=
ne in a good hour or so, took the tiime to slim it down to someting reasona=
ble </p>
<p dir=3D"ltr">Thanks man <br>
</p>
<div class=3D"gmail_quote">On 2 Feb 2016 18:14, &quot;Pranith Kumar&quot; &=
lt;<a href=3D"mailto:bobby.prani@gmail.com">bobby.prani@gmail.com</a>&gt; w=
rote:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Tue, Feb 2,=
 2016 at 1:48 AM, Aneesh Kumar K.V<br>
&lt;<a href=3D"mailto:aneesh.kumar@linux.vnet.ibm.com">aneesh.kumar@linux.v=
net.ibm.com</a>&gt; wrote:<br>
&gt;<br>
&gt; This patch didn&#39;t work for you ?<br>
&gt;<br>
&gt; <a href=3D"http://mid.gmane.org/1454086969-21074-1-git-send-email-anee=
sh.kumar@linux.vnet.ibm.com" rel=3D"noreferrer" target=3D"_blank">http://mi=
d.gmane.org/1454086969-21074-1-git-send-email-aneesh.kumar@linux.vnet.ibm.c=
om</a><br>
&gt;<br>
<br>
This actually is a better patch. I didn&#39;t realize that we have the _64 =
version.<br>
<br>
Thanks!<br>
--<br>
Pranith<br>
</blockquote></div>

--94eb2c0a912249288d052acd3364--
