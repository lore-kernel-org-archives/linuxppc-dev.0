Return-Path: <wburos@gmail.com>
Received: from mail-qt0-x229.google.com (mail-qt0-x229.google.com
 [IPv6:2607:f8b0:400d:c0d::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjcsD4tY7zDqL2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 04:44:00 +1000 (AEST)
Received: by mail-qt0-x229.google.com with SMTP id u19so16493289qta.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Jun 2017 11:44:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170607160015.GA13031@drishya.in.ibm.com>
References: <tencent_14A522610506039258ACD095@qq.com>
 <20170607160015.GA13031@drishya.in.ibm.com>
From: Bill Buros <wburos@gmail.com>
Date: Wed, 7 Jun 2017 13:43:57 -0500
Message-ID: <CAC-nz1vCnL9PVeY-qne2WCdMtfQD37y4ikwLm1cOau9dnud9jA@mail.gmail.com>
Subject: Re: power server power consumption problem
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="001a1148b6a26d616c0551631e8c"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a1148b6a26d616c0551631e8c
Content-Type: text/plain; charset="UTF-8"

>From a peer..     Rafael Peria de Sene...

At Unicamp we developed a power monitor based on IPMI output to monitor our
Minsky usage.

Take a look at http://177.220.10.134/powergraph



On Wed, Jun 7, 2017 at 11:00 AM, Vaidyanathan Srinivasan <
svaidy@linux.vnet.ibm.com> wrote:

> * ?????????? <1363017608@qq.com> [2017-06-06 19:59:24]:
>
> > I use ipmitool measuring power server power consumption, getting the
> following results without total power consumption as the following picture,
> do I add all power values as total power consumption? I am eager to receive
> someone's replay??Thanks?
>
> The total system power is already aggregates as provided under ipmi
> dcmi command.
>
> You can read it like:
>
> Inband: (within system)
>
> root@ubuntu:~# ipmitool dcmi power reading
>
>     Instantaneous power reading:                   485 Watts
>     Minimum during sampling period:                485 Watts
>     Maximum during sampling period:                486 Watts
>     Average power reading over sample period:      485 Watts
>     IPMI timestamp:                           Wed Jun  7 15:53:08 2017
>     Sampling period:                          00000010 Seconds.
>     Power reading state is:                   activated
>
> Out-of-band: (Over BMC network)
>
> [sv@drishya] ~ % ipmitool -I lanplus -H bmc -U bmc-user -P bmc-pw  dcmi
> power reading
>
>     Instantaneous power reading:                   486 Watts
>     Minimum during sampling period:                483 Watts
>     Maximum during sampling period:                486 Watts
>     Average power reading over sample period:      484 Watts
>     IPMI timestamp:                           Wed Jun  7 15:54:11 2017
>     Sampling period:                          00000010 Seconds.
>     Power reading state is:                   activated
>
>
> You do get component power consumption from IPMI SDR, you can get
> those from inband or out-of-band. But you need not manually add it up.
> On-Chip-Controller (OCC) does the power aggregation already and
> exports it through DCMI power reading.
>
> --Vaidy
>
>

--001a1148b6a26d616c0551631e8c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">From a peer.. =C2=A0 =C2=A0 Rafael Peria de Sene... =C2=A0=
=C2=A0<div><br></div><div>







<p class=3D"gmail-p1">At Unicamp we developed a power monitor based on IPMI=
 output to monitor our Minsky usage.=C2=A0</p><p class=3D"gmail-p1">Take a =
look at <a href=3D"http://177.220.10.134/powergraph"><span class=3D"gmail-s=
1">http://177.220.10.134/powergraph</span></a></p></div><div class=3D"gmail=
_extra"><br></div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_=
extra"><br><div class=3D"gmail_quote">On Wed, Jun 7, 2017 at 11:00 AM, Vaid=
yanathan Srinivasan <span dir=3D"ltr">&lt;<a href=3D"mailto:svaidy@linux.vn=
et.ibm.com" target=3D"_blank">svaidy@linux.vnet.ibm.com</a>&gt;</span> wrot=
e:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">* ?????????? &lt;<a href=3D"mailto:136=
3017608@qq.com">1363017608@qq.com</a>&gt; [2017-06-06 19:59:24]:<br>
<br>
&gt; I use ipmitool measuring power server power consumption, getting the f=
ollowing results without total power consumption as the following picture, =
do I add all power values as total power consumption? I am eager to receive=
 someone&#39;s replay??Thanks?<br>
<br>
The total system power is already aggregates as provided under ipmi<br>
dcmi command.<br>
<br>
You can read it like:<br>
<br>
Inband: (within system)<br>
<br>
root@ubuntu:~# ipmitool dcmi power reading<br>
<br>
=C2=A0 =C2=A0 Instantaneous power reading:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0485 Watts<br>
=C2=A0 =C2=A0 Minimum during sampling period:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 485 Watts<br>
=C2=A0 =C2=A0 Maximum during sampling period:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 486 Watts<br>
=C2=A0 =C2=A0 Average power reading over sample period:=C2=A0 =C2=A0 =C2=A0=
 485 Watts<br>
=C2=A0 =C2=A0 IPMI timestamp:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Wed Jun=C2=A0 7 15:53:0=
8 2017<br>
=C2=A0 =C2=A0 Sampling period:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 00000010 Seconds.<br>
=C2=A0 =C2=A0 Power reading state is:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0activated<br>
<br>
Out-of-band: (Over BMC network)<br>
<br>
[sv@drishya] ~ % ipmitool -I lanplus -H bmc -U bmc-user -P bmc-pw=C2=A0 dcm=
i power reading<br>
<br>
=C2=A0 =C2=A0 Instantaneous power reading:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0486 Watts<br>
=C2=A0 =C2=A0 Minimum during sampling period:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 483 Watts<br>
=C2=A0 =C2=A0 Maximum during sampling period:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 486 Watts<br>
=C2=A0 =C2=A0 Average power reading over sample period:=C2=A0 =C2=A0 =C2=A0=
 484 Watts<br>
=C2=A0 =C2=A0 IPMI timestamp:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Wed Jun=C2=A0 7 15:54:1=
1 2017<br>
=C2=A0 =C2=A0 Sampling period:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 00000010 Seconds.<br>
=C2=A0 =C2=A0 Power reading state is:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0activated<br>
<br>
<br>
You do get component power consumption from IPMI SDR, you can get<br>
those from inband or out-of-band. But you need not manually add it up.<br>
On-Chip-Controller (OCC) does the power aggregation already and<br>
exports it through DCMI power reading.<br>
<br>
--Vaidy<br>
<br>
</blockquote></div><br></div></div>

--001a1148b6a26d616c0551631e8c--
