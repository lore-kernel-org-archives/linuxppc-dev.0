Return-Path: <dmitry.torokhov@gmail.com>
Received: from mail-ua0-x234.google.com (mail-ua0-x234.google.com
 [IPv6:2607:f8b0:400c:c08::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKwmb13L4zDrHp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 06:30:55 +1000 (AEST)
Received: by mail-ua0-x234.google.com with SMTP id n59so104181758uan.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 13:30:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160825194133.GC3296@wotan.suse.de>
References: <1466117661-22075-1-git-send-email-mcgrof@kernel.org>
 <1466117661-22075-3-git-send-email-mcgrof@kernel.org>
 <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de>
 <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Thu, 25 Aug 2016 13:30:51 -0700
Message-ID: <CAKdAkRS+UT2LhC9OBdmzjjbcEX24tHusYuzwiBMEEFysNW6wBQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] firmware: annotate thou shalt not request fw on
 init or probe
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Felix Fietkau <nbd@nbd.name>,
 David Woodhouse <dwmw2@infradead.org>,
 =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <jroedel@suse.de>,
 Joerg Roedel <joro@8bytes.org>, Roman Pen <r.peniaev@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Ming Lei <ming.lei@canonical.com>,
 Andrew Morton <akpm@linux-foundation.org>, Michal Marek <mmarek@suse.com>,
 Greg KH <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Vikram Mulukutla <markivx@codeaurora.org>,
 Stephen Boyd <stephen.boyd@linaro.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>,
 Johannes Berg <johannes@sipsolutions.net>,
 Christian Lamparter <chunkeey@googlemail.com>,
 Hauke Mehrtens <hauke@hauke-m.de>, Josh Boyer <jwboyer@fedoraproject.org>,
 Jiri Slaby <jslaby@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 Andy Lutomirski <luto@amacapital.net>, Wu Fengguang <fengguang.wu@intel.com>,
 Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>,
 "Abhay_Salunke@dell.com" <Abhay_Salunke@dell.com>,
 Julia Lawall <Julia.Lawall@lip6.fr>, Gilles.Muller@lip6.fr,
 nicolas.palix@imag.fr, Tom Gundersen <teg@jklm.no>,
 David Howells <dhowells@redhat.com>,
 Alessandro Rubini <rubini@gnudd.com>, Kevin Cernekee <cernekee@gmail.com>,
 Kees Cook <keescook@chromium.org>,
 Jonathan Corbet <corbet@lwn.net>, Thierry Martinez <martinez@nsup.org>,
 cocci@systeme.lip6.fr, linux-serial <linux-serial@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 25, 2016 at 12:41 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> On Thu, Aug 25, 2016 at 01:05:44PM +0200, Daniel Vetter wrote:
>> On Wed, Aug 24, 2016 at 10:39 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:

>> > Can they use initramfs for this ?
>>
>> Apparently that's also uncool with the embedded folks.
>
> What's uncool with embedded folks? To use initramfs for firmware ?
> If so can you explain why ?

Because it is not needed? If you are embedded you have an option of
only compiling drivers and services that you need directly into the
kernel, then initramfs is just an extra piece that complicates your
boot process.

Thanks.

-- 
Dmitry
