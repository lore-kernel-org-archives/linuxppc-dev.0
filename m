Return-Path: <linus971@gmail.com>
Received: from mail-oi0-x22f.google.com (mail-oi0-x22f.google.com
 [IPv6:2607:f8b0:4003:c06::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x40St0nNmzDr5l
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Jul 2017 02:30:05 +1000 (AEST)
Received: by mail-oi0-x22f.google.com with SMTP id l130so31931632oib.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Jul 2017 09:30:05 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CA+55aFyREtWvwCLc0iHMUOLo-VLDpxju7WwEmjOSyByHre3avQ@mail.gmail.com>
References: <20170705071423.GY10672@ZenIV.linux.org.uk>
 <87eftsv2hj.fsf@concordia.ellerman.id.au>
 <CA+55aFyREtWvwCLc0iHMUOLo-VLDpxju7WwEmjOSyByHre3avQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 7 Jul 2017 09:30:03 -0700
Message-ID: <CA+55aFzVY=3Jnd4FiJt-sN=Nm16bhmqYE0YuzxDL1B9uwHw40w@mail.gmail.com>
Subject: Re: [git pull] vfs.git part 1
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 7, 2017 at 8:59 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>> Patch coming.
>
> I'm not seeing a patch, so I did my own. But it's _entirely_ untested.
> Does the attached fix things for you?

Oh, I see you sent a patch to the list but didn't cc me like in this thread.

Hmm. Al - I'd like to add the "const" parts at least. How the ordering
gets fixed (I changed it in the users of the macro, Michael changed
the macro itself) I don't much care about.

Can you get me a pull request soon since this presumably also breaks
every other compat case, and it just happened that power was the one
that noticed it first.. Or I can just commit my version, but I guess
Michael's is at least tested..

               Linus
