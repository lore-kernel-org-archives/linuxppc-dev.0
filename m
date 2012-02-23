Return-Path: <glikely@secretlab.ca>
Received: from mail-tul01m020-f179.google.com (mail-tul01m020-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8EA00B6EEA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2012 13:00:07 +1100 (EST)
Received: by obbup6 with SMTP id up6so867744obb.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2012 18:00:05 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1329962108.20389.19.camel@pasglop>
References: <1329954613.20389.15.camel@pasglop>
 <20120223013947.GC3212@ponder.secretlab.ca>
 <1329962108.20389.19.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 22 Feb 2012 18:59:45 -0700
Message-ID: <CACxGe6uKuZA3NUZdh7b+W43e22vreWp-dzjsxXvsRoTBadUbhw@mail.gmail.com>
Subject: Re: powerpc/mpic: Fix allocation of reverse-map for multi-ISU mpics
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 22, 2012 at 6:55 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2012-02-22 at 18:39 -0700, Grant Likely wrote:
>>
>> Looks fine to me. =A0This will conflict with the irqdomain tree in linux=
-next,
>> but it will be a trivial fixup. =A0Still, if you prefer I can pick this
>> up into my tree.
>
> Well, I'm also going to carry a slightly modified variant of Kyle's
> mpic series so we'll have to deal with conflicts regardless, I'll
> keep that one.
>
> What I might do tho is pull your tree in powerpc-next at some point,
> when you tell me it's frozen solid, this will potentially make my life
> easier.

It's frozen solid now.  Any changes from this point on will be new
patches on top.

g.
