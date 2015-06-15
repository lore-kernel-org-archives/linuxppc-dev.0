Return-Path: <baolin.wang@linaro.org>
Received: from mail-yk0-f177.google.com (mail-yk0-f177.google.com
 [209.85.160.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CBDBE1A03ED
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 12:27:56 +1000 (AEST)
Received: by ykaz81 with SMTP id z81so46174479yka.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jun 2015 19:27:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1506121512180.3786@nanos>
References: <cover.1434079262.git.baolin.wang@linaro.org>
 <alpine.DEB.2.11.1506121512180.3786@nanos>
Date: Mon, 15 Jun 2015 10:27:53 +0800
Message-ID: <CAMz4ku+yt=DWctKj+S4mTCKna-CyfXkhJhWLkJecBBXed39A7Q@mail.gmail.com>
Subject: Re: [PATCH v5 00/24] Convert the posix_clock_operations and k_clock
 structure to ready for 2038
From: Baolin Wang <baolin.wang@linaro.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, John Stultz <john.stultz@linaro.org>,
 Heena Sirwani <heenasirwani@gmail.com>, Xunlei Pang <pang.xunlei@linaro.org>,
 peterz@infradead.org,
 rafael.j.wysocki@intel.com, Greg KH <gregkh@linuxfoundation.org>,
 Richard Cochran <richardcochran@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org,
 mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
 linux390@de.ibm.com, rth@twiddle.net, riel@redhat.com, cl@linux.com,
 tj@kernel.org, =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
 Andrew Hunter <ahh@google.com>, Paul Turner <pjt@google.com>,
 linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 Serge Hallyn <serge.hallyn@canonical.com>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, Paul Moore <pmoore@redhat.com>,
 Takashi Iwai <tiwai@suse.de>, Jeffrey Vander Stoep <jeffv@google.com>,
 Jeffrey Layton <jlayton@primarydata.com>,
 Kees Cook <keescook@chromium.org>, Stephen Smalley <sds@tycho.nsa.gov>,
 mark.d.rustad@intel.com,
 linux-security-module <linux-security-module@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12 June 2015 at 21:16, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 12 Jun 2015, Baolin Wang wrote:
>
> Sigh. Again threading of the series failed. Some patches are, the
> whole series is not. Can you please get your tools straight?
>
> You neither managed to cc me on the security patch.
>
>> - Modify the subject line and the changelog:
>
>>   timekeeping: Change the implementation of timekeeping_clocktai()
>
> Sigh. How is that better than the previous one? It's more accurate,
> but equally useless.
>
> And of course you did not address my request to change the macro mess
> in
>
>>   posix-timers: Introduce {get,put}_timespec and {get,put}_itimerspec
>
> according to the discussion with Arnd.
>
> Thanks,
>
>         tglx

Hi Thomas,

Thanks for your comments, and i'll fix these problems you point out.

-- 
Baolin.wang
Best Regards
