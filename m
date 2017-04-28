Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDdm13sQDzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 12:57:53 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kees Cook <keescook@chromium.org>, Ankit Kumar <ankit@linux.vnet.ibm.com>
Cc: Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>,
 Tony Luck <tony.luck@intel.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>,
 "benh\@kernel.crashing.org" <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Daniel Axtens <dja@axtens.net>, Geliang Tang <geliangtang@163.com>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "mahesh\@linux.vnet.ibm.com" <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH] Enabled pstore write for powerpc
In-Reply-To: <CAGXu5jLG66piVw-L08X6wL00f4mXi0BT=EtcbO0ochCMBCASXQ@mail.gmail.com>
References: <1493292794-13166-1-git-send-email-ankit@linux.vnet.ibm.com>
 <CAGXu5jLG66piVw-L08X6wL00f4mXi0BT=EtcbO0ochCMBCASXQ@mail.gmail.com>
Date: Fri, 28 Apr 2017 12:57:50 +1000
Message-ID: <8737ctqlw1.fsf@concordia.ellerman.id.au>
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

> On Thu, Apr 27, 2017 at 4:33 AM, Ankit Kumar <ankit@linux.vnet.ibm.com> wrote:
>> After commit c950fd6f201a kernel registers pstore write based on flag set.
>> Pstore write for powerpc is broken as flags(PSTORE_FLAGS_DMESG) is not set for
>> powerpc architecture. On panic, kernel doesn't write message to
>> /fs/pstore/dmesg*(Entry doesn't gets created at all).
>>
>> This patch enables pstore write for powerpc architecture by setting
>> PSTORE_FLAGS_DMESG flag.
>>
>> Fixes:c950fd6f201a pstore: Split pstore fragile flags
>> Signed-off-by: Ankit Kumar <ankit@linux.vnet.ibm.com>
>
> Argh, thanks! I thought I'd caught all of these. I'll include this for -stable.

I see you've picked it up, thanks.

cheers
