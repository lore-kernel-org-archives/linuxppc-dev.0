Return-Path: <r.goyet@gmail.com>
Received: from mail-fx0-f221.google.com (mail-fx0-f221.google.com
	[209.85.220.221]) by ozlabs.org (Postfix) with ESMTP id 547D2B7CA6
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 22 Mar 2010 23:21:59 +1100 (EST)
Received: by fxm21 with SMTP id 21so1628185fxm.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 22 Mar 2010 05:21:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1254826312.6035.8.camel@pasglop>
References: <8028e5750910060216x134a8a9cm461fa5a6e87eb6bb@mail.gmail.com>
	<1254823882.6035.5.camel@pasglop>
	<8028e5750910060331m42ea795bi441eb7a9b39837f8@mail.gmail.com>
	<1254826312.6035.8.camel@pasglop>
Date: Mon, 22 Mar 2010 13:21:52 +0100
Message-ID: <8028e5751003220521h24292eddwa7d940f103221a5@mail.gmail.com>
Subject: Re: SMU-base PowerMac and server_mode
From: Romain Goyet <r.goyet@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

So, I'm coming back to you about setting "server_mode" on SMU-based
PPC machines. You know, so that the machine reboots after a power
failure. Would you have a little time now ? Thanks a lot !

 - Romain


On Tue, Oct 6, 2009 at 11:51 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2009-10-06 at 12:31 +0200, Romain Goyet wrote:
>> Hi Benjamin !
>>
>>
>> =C2=A0 Actually I saw a post where you mentioned this tool on Google. I
>> then searched it for like an hour or so, but really couldn't find it.
>> That's why I ended up posting on this mailing list. I'm really glad
>> you're on it by the way ! Anyway, like I said : I really looked for
>> this tool, but couldn't find it=E2=80=A6
>
> Hrm... ok. I'll have to figure it out again. No time right now, but
> get back to me next month after Kernel Summit and I'll see what i can
> do.
>
> Cheers,
> Ben.
>
>>
>> Thanks a lot !
>>
>>
>> =C2=A0- Romain
>>
>>
>> On Tue, Oct 6, 2009 at 12:11 PM, Benjamin Herrenschmidt
>> <benh@kernel.crashing.org> wrote:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 On Tue, 2009-10-06 at 11:16 +0200, Romain Go=
yet wrote:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 > Hi there,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 >
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 >
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 > =C2=A0 I have this Quad G5 here, running G=
entooPPC64. Runs fine.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Had a hard
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 > time getting it to boot without a screen a=
ttached, but I
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 eventually
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 > managed to (yaboot was the culprit). Howev=
er, this machine
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 is
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 > SMU-based, and I couldn't find a way to en=
able the
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 equivalent of the
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 > PMU's "server_mode" (i.e. automatically re=
boot after a power
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 failure).
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 > Is there any known way to do that ?
>>
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 I'm pretty sure I reverse engineered the nec=
essary command a
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 while back
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 and somebody wrote a userland tool to set it=
, but I can't find
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 it
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 anymore :-)
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Google may help. Let me know if you can't fi=
nd it.
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Cheers,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ben.
>>
>>
>>
>>
>
>
>
