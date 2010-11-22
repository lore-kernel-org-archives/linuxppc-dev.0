Return-Path: <jwboyer@gmail.com>
Received: from mail-ww0-f52.google.com (mail-ww0-f52.google.com [74.125.82.52])
	by ozlabs.org (Postfix) with ESMTP id E56BFB7109
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Nov 2010 22:25:25 +1100 (EST)
Received: by wwb17 with SMTP id 17so3549130wwb.21
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Nov 2010 03:25:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1290380744.4961.7.camel@concordia>
References: <1290059208.32570.3.camel@pasglop> <30983.1290116555@neuling.org>
	<1290118082.29105.11.camel@concordia>
	<20101119163104.624d264d.sfr@canb.auug.org.au>
	<1290145458.2867.3.camel@concordia> <30421.1290146540@neuling.org>
	<1290380744.4961.7.camel@concordia>
Date: Mon, 22 Nov 2010 06:25:21 -0500
Message-ID: <AANLkTind=g117r=J2z8r6jiBxN+0+j4uESQvFW7_G-BF@mail.gmail.com>
Subject: Re: [git pull] Please pull powerpc.git merge branch
From: Josh Boyer <jwboyer@gmail.com>
To: michael@ellerman.id.au
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Michael Neuling <mikey@neuling.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Nov 21, 2010 at 6:05 PM, Michael Ellerman
<michael@ellerman.id.au> wrote:
> On Fri, 2010-11-19 at 17:02 +1100, Michael Neuling wrote:
>> > On Fri, 2010-11-19 at 16:31 +1100, Stephen Rothwell wrote:
>> > > On Fri, 19 Nov 2010 09:08:02 +1100 Michael Ellerman <michael@ellerma=
n.id.=3D
>> > au> wrote:
>> > > >
>> > > > I vote for:
>> > > >=3D20
>> > > > =C2=A0-> Exception: 401 (Instruction Access) at 00000000f7937794
>> > >=3D20
>> > > Or:
>> > >=3D20
>> > > =3DE2=3D98=3D9B Exception: 401 (Instruction Access) at 00000000f7937=
794
>> >
>> > Let's get serious, it's _really_ like a phone call:
>> >
>> > =3DE2=3D98=3D8E Exception: 401 (Instruction Access) at 00000000f793779=
4
>>
>> We need a dedicated NACK char!
>
> =E2=90=95!

Surely it would be: =E2=98=A3

josh
