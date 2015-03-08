Return-Path: <olof@lixom.net>
Received: from mail-oi0-f46.google.com (mail-oi0-f46.google.com
 [209.85.218.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3531F1A0007
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Mar 2015 07:19:09 +1100 (AEDT)
Received: by oiav63 with SMTP id v63so25940835oia.13
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Mar 2015 13:19:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1425716841.4636.219.camel@kernel.crashing.org>
References: <mailman.412.1425683254.7605.linuxppc-dev@lists.ozlabs.org>
 <49C58FDD-0206-4357-8CD2-46F3F7E4E739@alexperez.com>
 <1425716841.4636.219.camel@kernel.crashing.org>
Date: Sun, 8 Mar 2015 13:19:06 -0700
Message-ID: <CAOesGMji=wd8M+BcLvnYhO+7102rOF08bjSRkO_QtsY6_E+nuw@mail.gmail.com>
Subject: Re: [REGRESSION in 3.18][PPC] PA Semi fails to boot after: of/base:
 Fix PowerPC address parsing hack
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Alex Perez <aperez@alexperez.com>, Christian Zigotzky <chzigotzky@xenosoft.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 7, 2015 at 12:27 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2015-03-06 at 16:16 -0800, Alex Perez wrote:
>
>> I will of course ultimately defer to Olof, but PASemi hasn=E2=80=99t exi=
sted
>> for years, and there is no entity which could possibly update the DT
>> for these reference PASemi development boards, unless Olof has source,
>> which I=E2=80=99m pretty sure he does not :)
>
> As I mentioned earlier, that's not what I had in mind :-) I was simply
> wondering whether an existing newer FW with a fix already existed but
> in any case, I'll submit the quirk next week, it doesn't hurt and is
> pretty simple and localized.

I doubt it -- it has definitely been a while but I have no memory of
having made any fixes to DT contents around there.

As far as access to FW sources, etc: I can't really do much on that
front either.


-Olof
