Return-Path: <michael.heltne@gmail.com>
Received: from mail-yw0-x22a.google.com (mail-yw0-x22a.google.com
 [IPv6:2607:f8b0:4002:c05::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 455CD1A0065
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 11:05:58 +1100 (AEDT)
Received: by mail-yw0-x22a.google.com with SMTP id z185so1102501ywf.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Feb 2016 16:05:58 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 3 Feb 2016 00:05:55 +0000
Message-ID: <CANtoAtOYX4YvNKupcou_yXQ+rV6BY0z2m7Ovf4Mk6-Aa5xMQhQ@mail.gmail.com>
Subject: Re: Failure on latest GIT - appletouch fails to register
From: Mike <michael.heltne@gmail.com>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
Content-Type: multipart/alternative; boundary=001a114dacbcc7e54c052ad26175
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a114dacbcc7e54c052ad26175
Content-Type: text/plain; charset=UTF-8

Normally as far as i can tell it should register it as input and that's not
happening, verified the config entry CONFIG_MOUSE_APPLETOUCH is selected
and compiled in both tests i've done for rc-1 and rc-2.

syslog.1:Feb  1 21:58:40 PowerBook-G4 kernel: [   14.744538] usbcore:
registered new interface driver appletouch
syslog.1:Feb  1 22:28:05 PowerBook-G4 kernel: [   14.904449] input:
appletouch as /devices/pci0001:10/0001:10:1a.0/usb2/2-2/2-2:1.1/input/input6
syslog.1:Feb  1 22:28:05 PowerBook-G4 kernel: [   14.905904] usbcore:
registered new interface driver appletouch
syslog.1:Feb  2 03:39:38 PowerBook-G4 kernel: [   15.423289] usbcore:
registered new interface driver appletouch

Any clues? Worked in 4.3.3 at least . Anyone point me to where i could
begin to look? Any structures changed which could account for this?


On 2 February 2016 at 17:55, Mike <michael.heltne@gmail.com> wrote:

> Agreed, raised an eyebrow initially when select ppc64 and 32 :D
>
> I'll give a word on the trackpad issue later, cant remember seeing any
> changes that ought effect it really. guess the compile is done in a good
> hour or so, took the tiime to slim it down to someting reasonable
>
> Thanks man
> On 2 Feb 2016 18:14, "Pranith Kumar" <bobby.prani@gmail.com> wrote:
>
>> On Tue, Feb 2, 2016 at 1:48 AM, Aneesh Kumar K.V
>> <aneesh.kumar@linux.vnet.ibm.com> wrote:
>> >
>> > This patch didn't work for you ?
>> >
>> >
>> http://mid.gmane.org/1454086969-21074-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com
>> >
>>
>> This actually is a better patch. I didn't realize that we have the _64
>> version.
>>
>> Thanks!
>> --
>> Pranith
>>
>

--001a114dacbcc7e54c052ad26175
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Normally as far as i can tell it should register it as inp=
ut and that&#39;s not happening, verified the config entry CONFIG_MOUSE_APP=
LETOUCH is selected and compiled in both tests i&#39;ve done for rc-1 and r=
c-2. =C2=A0=C2=A0<div><br></div><div><div>syslog.1:Feb =C2=A01 21:58:40 Pow=
erBook-G4 kernel: [ =C2=A0 14.744538] usbcore: registered new interface dri=
ver appletouch</div><div>syslog.1:Feb =C2=A01 22:28:05 PowerBook-G4 kernel:=
 [ =C2=A0 14.904449] input: appletouch as /devices/pci0001:10/0001:10:1a.0/=
usb2/2-2/2-2:1.1/input/input6</div><div>syslog.1:Feb =C2=A01 22:28:05 Power=
Book-G4 kernel: [ =C2=A0 14.905904] usbcore: registered new interface drive=
r appletouch</div><div>syslog.1:Feb =C2=A02 03:39:38 PowerBook-G4 kernel: [=
 =C2=A0 15.423289] usbcore: registered new interface driver appletouch</div=
><div><br></div><div class=3D"gmail_extra">Any clues? Worked in 4.3.3 at le=
ast . Anyone point me to where i could begin to look? Any structures change=
d which could account for this?=C2=A0</div><div class=3D"gmail_extra"><br><=
/div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On 2 Februar=
y 2016 at 17:55, Mike <span dir=3D"ltr">&lt;<a href=3D"mailto:michael.heltn=
e@gmail.com" target=3D"_blank">michael.heltne@gmail.com</a>&gt;</span> wrot=
e:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:s=
olid;padding-left:1ex"><p dir=3D"ltr">Agreed, raised an eyebrow initially w=
hen select ppc64 and 32 :D </p>
<p dir=3D"ltr">I&#39;ll give a word on the trackpad issue later, cant remem=
ber seeing any changes that ought effect it really. guess the compile is do=
ne in a good hour or so, took the tiime to slim it down to someting reasona=
ble </p>
<p dir=3D"ltr">Thanks man <br>
</p><div class=3D""><div class=3D"h5">
<div class=3D"gmail_quote">On 2 Feb 2016 18:14, &quot;Pranith Kumar&quot; &=
lt;<a href=3D"mailto:bobby.prani@gmail.com" target=3D"_blank">bobby.prani@g=
mail.com</a>&gt; wrote:<br type=3D"attribution"><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-=
color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">On Tue, Fe=
b 2, 2016 at 1:48 AM, Aneesh Kumar K.V<br>
&lt;<a href=3D"mailto:aneesh.kumar@linux.vnet.ibm.com" target=3D"_blank">an=
eesh.kumar@linux.vnet.ibm.com</a>&gt; wrote:<br>
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
</div></div></blockquote></div><br></div></div></div>

--001a114dacbcc7e54c052ad26175--
