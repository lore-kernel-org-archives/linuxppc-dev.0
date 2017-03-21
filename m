Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnNxY5lyhzDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 18:00:33 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: Emese Revfy <re.emese@gmail.com>, "kernel-hardening\@lists.openwall.com"
 <kernel-hardening@lists.openwall.com>,
 "linux-doc\@vger.kernel.org" <linux-doc@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [kernel-hardening] Re: [PATCH] gcc-plugins: update architecture
 list in documentation
In-Reply-To: <CAGXu5jK=GGQeGQrv-9Z__caRxu7u333boJFXRNjcqBXOspYeQw@mail.gmail.com>
References: <20170320065522.14839-1-andrew.donnellan@au1.ibm.com>
 <87var44a0b.fsf@concordia.ellerman.id.au>
 <CAGXu5jK=GGQeGQrv-9Z__caRxu7u333boJFXRNjcqBXOspYeQw@mail.gmail.com>
Date: Tue, 21 Mar 2017 18:00:26 +1100
Message-ID: <87mvcfp111.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kees Cook <keescook@chromium.org> writes:

> On Mon, Mar 20, 2017 at 1:39 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:
>>
>>> Commit 65c059bcaa73 ("powerpc: Enable support for GCC plugins") enabled GCC
>>> plugins on powerpc, but neglected to update the architecture list in the
>>> docs. Rectify this.
>>>
>>> Fixes: 65c059bcaa73 ("powerpc: Enable support for GCC plugins")
>>> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>>> ---
>>>  Documentation/gcc-plugins.txt | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> It would be nice to merge this for v4.11, so the docs are up to do date
>> with the code for the release.
>>
>> I'm not sure who owns it though, should it go via Jon as docs
>> maintainer (added to CC), or via Kees tree or mine?
>
> If you have other changes queued for v4.11, please take it via your
> tree. Otherwise, perhaps the docs tree or mine? (I don't currently
> have any fixes queued; I'm just trying to minimize pull requests going
> to Linus...)

I have some fixes queued already, so unless Jon yells I'll take it in
the next day or so.

cheers
