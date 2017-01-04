Return-Path: <linus971@gmail.com>
Received: from mail-it0-x241.google.com (mail-it0-x241.google.com
 [IPv6:2607:f8b0:4001:c0b::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttzNv6zmvzDqKN
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 05:09:51 +1100 (AEDT)
Received: by mail-it0-x241.google.com with SMTP id c20so54427943itb.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Jan 2017 10:09:51 -0800 (PST)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <dc15451c-3c5e-1f61-f108-cea3c08332a9@fb.com>
References: <20170104161808.5ad7b4fd@kryten>
 <6085340.JSrffQ0Szo@localhost.localdomain>
 <20170104152837.wdh7cdncs7gyged7@thunk.org>
 <dc15451c-3c5e-1f61-f108-cea3c08332a9@fb.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 4 Jan 2017 10:09:48 -0800
Message-ID: <CA+55aFzg5qR6DJvzrp+sreakzhPvT=txS-mo4OTrrwT0HVrKvw@mail.gmail.com>
Subject: Re: ext4 filesystem corruption with 4.10-rc2 on ppc64le
To: Jens Axboe <axboe@fb.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
 Chandan Rajendra <chandan@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>, Jan Kara <jack@suse.cz>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 4, 2017 at 8:23 AM, Jens Axboe <axboe@fb.com> wrote:
> On 01/04/2017 08:28 AM, Theodore Ts'o wrote:
>>
>> Jens, could you expedite a pull request to Linus?  This is affecting
>> ext4 on 1k block file systems on x86/x86_64, so this is not a ppc-only
>> regression.
>
> Yes, it'll go out this morning.

It's merged and out there in my tree now.

                 Linus
