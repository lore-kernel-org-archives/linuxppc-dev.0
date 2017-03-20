Return-Path: <keescook@google.com>
Received: from mail-it0-x233.google.com (mail-it0-x233.google.com
 [IPv6:2607:f8b0:4001:c0b::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vn2KD4yQZzDqZv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 04:01:20 +1100 (AEDT)
Received: by mail-it0-x233.google.com with SMTP id w124so95194727itb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 10:01:20 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <87var44a0b.fsf@concordia.ellerman.id.au>
References: <20170320065522.14839-1-andrew.donnellan@au1.ibm.com>
 <87var44a0b.fsf@concordia.ellerman.id.au>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 20 Mar 2017 10:01:15 -0700
Message-ID: <CAGXu5jK=GGQeGQrv-9Z__caRxu7u333boJFXRNjcqBXOspYeQw@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: update architecture list in documentation
To: Michael Ellerman <mpe@ellerman.id.au>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: Emese Revfy <re.emese@gmail.com>,
 "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 20, 2017 at 1:39 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:
>
>> Commit 65c059bcaa73 ("powerpc: Enable support for GCC plugins") enabled GCC
>> plugins on powerpc, but neglected to update the architecture list in the
>> docs. Rectify this.
>>
>> Fixes: 65c059bcaa73 ("powerpc: Enable support for GCC plugins")
>> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>> ---
>>  Documentation/gcc-plugins.txt | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> It would be nice to merge this for v4.11, so the docs are up to do date
> with the code for the release.
>
> I'm not sure who owns it though, should it go via Jon as docs
> maintainer (added to CC), or via Kees tree or mine?

If you have other changes queued for v4.11, please take it via your
tree. Otherwise, perhaps the docs tree or mine? (I don't currently
have any fixes queued; I'm just trying to minimize pull requests going
to Linus...)

-Kees

-- 
Kees Cook
Pixel Security
