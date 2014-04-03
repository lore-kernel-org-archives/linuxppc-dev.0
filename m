Return-Path: <sanjeevsharmaengg@gmail.com>
Received: from mail-ob0-x235.google.com (mail-ob0-x235.google.com
 [IPv6:2607:f8b0:4003:c01::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EF84914012E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Apr 2014 14:25:22 +1100 (EST)
Received: by mail-ob0-f181.google.com with SMTP id wp4so1334061obc.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Apr 2014 20:25:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3723.1395937889@turing-police.cc.vt.edu>
References: <CAERE9PrGaOJS3YTBv61=JCEGyPxGnqr_8j=eKrnn7Y9vi8dMug@mail.gmail.com>
 <52BBF1CB.3070006@gmail.com>
 <CAERE9Prr_C31D96zuYbV0KQ7b_j8Te0A2DO8C+6YtetF0e6M_w@mail.gmail.com>
 <CALyraeMiKQsoHV8AQ5SOz926z_YBD3LbFFNefMpRibYOt=Vo=Q@mail.gmail.com>
 <CAERE9PrX61oNtQoT1tpL_+rXfirFeMa4woD2P2TSUJ_Xj-h4rg@mail.gmail.com>
 <5333FEBD.3050704@gmail.com>
 <3723.1395937889@turing-police.cc.vt.edu>
Date: Thu, 3 Apr 2014 08:55:19 +0530
Message-ID: <CAGUYZuR+rymKURoHURemEggZ8uktagyhGGuqtaWvN=11DQsoxw@mail.gmail.com>
Subject: Re: MPC8641 based custom board Kernel stuck at 1000Mhz core clock
From: sanjeev sharma <sanjeevsharmaengg@gmail.com>
To: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Content-Type: multipart/alternative; boundary=047d7b33cd7c596f7d04f61af3ec
Cc: scottwood@freescale.com, Ashish <curieux.khetan@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, kernelnewbies <kernelnewbies@kernelnewbies.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--047d7b33cd7c596f7d04f61af3ec
Content-Type: text/plain; charset=ISO-8859-1

Are you able to capture kernel logs ?

Regards
Sanjeev Sharma


On Thu, Mar 27, 2014 at 10:01 PM, <Valdis.Kletnieks@vt.edu> wrote:

> On Thu, 27 Mar 2014 16:04:37 +0530, Ashish said:
> > Hi,
> >
> >   I am using MPC8641-HPCN based custom board and able to boot linux at
> > MPX clock 400Mhz and core clock 800mhz. When I am increasing core
> > frequency ie MPX clock at 400Mhz and core at 1Ghz, kernel stuck.
>
> Step 0:  Prove to us that your core actually runs reliable and stably at
> 1Ghz.
>
> Step 1: Figure out *where* it gets stuck.  If you have earlyprintk working
> on
> your board, adding 'initcall_debug ignore_loglevel' to the kernel cmdline
> often
> helps track down where a kernel hangs during boot.
>
>
> _______________________________________________
> Kernelnewbies mailing list
> Kernelnewbies@kernelnewbies.org
> http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
>
>

--047d7b33cd7c596f7d04f61af3ec
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Are you able to capture kernel logs ?<br><br></div>Re=
gards<br>Sanjeev Sharma<br></div><div class=3D"gmail_extra"><br><br><div cl=
ass=3D"gmail_quote">On Thu, Mar 27, 2014 at 10:01 PM,  <span dir=3D"ltr">&l=
t;<a href=3D"mailto:Valdis.Kletnieks@vt.edu" target=3D"_blank">Valdis.Kletn=
ieks@vt.edu</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"">On Thu, 27 Mar 2014 16:04:37=
 +0530, Ashish said:<br>
&gt; Hi,<br>
&gt;<br>
&gt; =A0 I am using MPC8641-HPCN based custom board and able to boot linux =
at<br>
&gt; MPX clock 400Mhz and core clock 800mhz. When I am increasing core<br>
&gt; frequency ie MPX clock at 400Mhz and core at 1Ghz, kernel stuck.<br>
<br>
</div>Step 0: =A0Prove to us that your core actually runs reliable and stab=
ly at 1Ghz.<br>
<br>
Step 1: Figure out *where* it gets stuck. =A0If you have earlyprintk workin=
g on<br>
your board, adding &#39;initcall_debug ignore_loglevel&#39; to the kernel c=
mdline often<br>
helps track down where a kernel hangs during boot.<br>
<br>
<br>_______________________________________________<br>
Kernelnewbies mailing list<br>
<a href=3D"mailto:Kernelnewbies@kernelnewbies.org">Kernelnewbies@kernelnewb=
ies.org</a><br>
<a href=3D"http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies" t=
arget=3D"_blank">http://lists.kernelnewbies.org/mailman/listinfo/kernelnewb=
ies</a><br>
<br></blockquote></div><br></div>

--047d7b33cd7c596f7d04f61af3ec--
