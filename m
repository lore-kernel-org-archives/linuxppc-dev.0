Return-Path: <linus971@gmail.com>
Received: from mail-it0-x233.google.com (mail-it0-x233.google.com
 [IPv6:2607:f8b0:4001:c0b::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40M3cx28gpzF1pY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2018 11:45:05 +1000 (AEST)
Received: by mail-it0-x233.google.com with SMTP id 19-v6so5083874itw.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2018 18:45:04 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180412013435.GA21219@altlinux.org>
References: <20180409152253.GD10489@altlinux.org>
 <20180412013435.GA21219@altlinux.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Apr 2018 18:45:02 -0700
Message-ID: <CA+55aFyzwzSH-fh9M1JLduq6dZXZZ9ZsyHUgJGSDeFZVy5_vtg@mail.gmail.com>
Subject: Re: sparc/ppc/arm compat siginfo ABI regressions: sending SIGFPE via
 kill() returns wrong values in si_pid and si_uid
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-sparc@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 11, 2018 at 6:34 PM, Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> There is a clear pattern of sneaking in ABI changes using innocently
> looking commit messages.

Yes, this siginfo stuff has been a mess.

Eric - this needs to stop. Or we need to revert all that garbage entirely.

Send a fix. And stop changing the siginfo layout or field values.

                 Linus
