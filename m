Return-Path: <wad@chromium.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
 [209.85.215.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 688F3B6F8F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2011 12:45:51 +1100 (EST)
Received: by eaai13 with SMTP id i13so1416482eaa.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Nov 2011 17:45:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1322439281.23348.34.camel@pasglop>
References: <1308875813-20122-1-git-send-email-wad@chromium.org>
 <1308875813-20122-11-git-send-email-wad@chromium.org>
 <1314682083.2488.73.camel@pasglop>
 <1322439281.23348.34.camel@pasglop>
Date: Sun, 27 Nov 2011 19:45:45 -0600
Message-ID: <CABqD9haiwc4zretJS2haYmGA0pY9vd1CSOAdhE_HsA7g7RaxSQ@mail.gmail.com>
Subject: Re: [PATCH v9 11/13] powerpc: select HAVE_SECCOMP_FILTER and provide
 seccomp_execve
From: Will Drewry <wad@chromium.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: fweisbec@gmail.com, scarybeasts@gmail.com, djm@mindrot.org,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, jmorris@namei.org,
 torvalds@linux-foundation.org, kees.cook@canonical.com,
 Paul Mackerras <paulus@samba.org>, mingo@elte.hu, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, segoon@openwall.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Nov 27, 2011 at 6:14 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2011-08-30 at 15:28 +1000, Benjamin Herrenschmidt wrote:
>> On Thu, 2011-06-23 at 19:36 -0500, Will Drewry wrote:
>> > Facilitate the use of CONFIG_SECCOMP_FILTER by wrapping compatibility
>> > system call numbering for execve and selecting HAVE_SECCOMP_FILTER.
>> >
>> > v9: rebase on to bccaeafd7c117acee36e90d37c7e05c19be9e7bf
>> >
>> > Signed-off-by: Will Drewry <wad@chromium.org>
>>
>> Seen these around for a while ... :-)
>>
>> I don't see a harm in the patches per-se tho I haven't reviewed the
>> actual seccomp filter stuff and it's good (or bad) behaviour on ppc.
>
> Did that stuff every got anywhere ? I don't see HAVE_SECCOMP_FILTER
> upsteam ... should I just drop the powerpc patch from patchwork ?

Thanks for following up! At present, it stalled out, so I think it'd
make sense to just drop it.  I will repost the series soon-ish and see
if any progress can be made.  [I've explored a number of alternative
approaches and still think something along the seccomp_filter lines is
still rational.]

cheers!
will
