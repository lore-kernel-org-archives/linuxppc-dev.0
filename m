Return-Path: <linus971@gmail.com>
Received: from mail-oi0-x22b.google.com (mail-oi0-x22b.google.com
 [IPv6:2607:f8b0:4003:c06::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sR3Gq110XzDrHp
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Sep 2016 14:41:22 +1000 (AEST)
Received: by mail-oi0-x22b.google.com with SMTP id m11so61908703oif.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Sep 2016 21:41:22 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAKdAkRSQmz3FoP8Z2ONm7-_A9RHF2Ox6snaCpsyS6HA7=+RerQ@mail.gmail.com>
References: <1466117661-22075-1-git-send-email-mcgrof@kernel.org>
 <1466117661-22075-3-git-send-email-mcgrof@kernel.org>
 <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de>
 <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de> <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de>
 <CA+55aFy4_QLYiQxtKpq0FJD7eSBRZ8nXS=Ruuz1TYodHdE_dCA@mail.gmail.com>
 <CAKdAkRSQmz3FoP8Z2ONm7-_A9RHF2Ox6snaCpsyS6HA7=+RerQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Sep 2016 21:41:18 -0700
Message-ID: <CA+55aFz4q5peXAeY9h8o3he7R=wXrBSYkOjMM9TehOw=pPoS+Q@mail.gmail.com>
Subject: Re: [RFC] fs: add userspace critical mounts event support
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 cocci@systeme.lip6.fr, Jacek Anaszewski <j.anaszewski@samsung.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Christian Lamparter <chunkeey@googlemail.com>,
 Julia Lawall <Julia.Lawall@lip6.fr>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>, Andy Lutomirski <luto@amacapital.net>,
 Richard Purdie <rpurdie@rpsys.net>, Wu Fengguang <fengguang.wu@intel.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Michal Marek <mmarek@suse.com>, Hauke Mehrtens <hauke@hauke-m.de>,
 Mark Brown <broonie@kernel.org>,
 Jiri Slaby <jslaby@suse.com>, Ming Lei <ming.lei@canonical.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Kevin Cernekee <cernekee@gmail.com>,
 Jeff Mahoney <jeffm@suse.com>, Greg KH <gregkh@linuxfoundation.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 Felix Fietkau <nbd@nbd.name>, David Howells <dhowells@redhat.com>,
 Vikram Mulukutla <markivx@codeaurora.org>, Alessandro Rubini <rubini@gnudd.com>,
 Tom Gundersen <teg@jklm.no>,
 Kees Cook <keescook@chromium.org>, Takashi Iwai <tiwai@suse.de>,
 Gilles.Muller@lip6.fr,
 linux-serial <linux-serial@vger.kernel.org>, Roman Pen <r.peniaev@gmail.com>,
 Kay Sievers <kay@vrfy.org>, Stephen Boyd <stephen.boyd@linaro.org>,
 nicolas.palix@imag.fr, "Abhay_Salunke@dell.com" <Abhay_Salunke@dell.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Thierry Martinez <martinez@nsup.org>,
 Josh Boyer <jwboyer@fedoraproject.org>
Content-Type: multipart/alternative; boundary=001a11403930ec27cf053b930ef1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a11403930ec27cf053b930ef1
Content-Type: text/plain; charset=UTF-8

On Sep 2, 2016 9:20 PM, "Dmitry Torokhov" <dmitry.torokhov@gmail.com> wrote:
>
> Like what? Some devices do need to have firmware loaded so we know
> their capabilities, so we really can't push the firmware loading into
> "open".

So you
(a) document that
(b) make the driver only build as a module
(c) make sure the module and the firmware go together

End of problem.

Why make up random interfaces for crazy stuff?

     Linus

--001a11403930ec27cf053b930ef1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On Sep 2, 2016 9:20 PM, &quot;Dmitry Torokhov&quot; &lt;<a h=
ref=3D"mailto:dmitry.torokhov@gmail.com">dmitry.torokhov@gmail.com</a>&gt; =
wrote:<br>
&gt;<br>
&gt; Like what? Some devices do need to have firmware loaded so we know<br>
&gt; their capabilities, so we really can&#39;t push the firmware loading i=
nto<br>
&gt; &quot;open&quot;. </p>
<p dir=3D"ltr">So you<br>
 (a) document that<br>
 (b) make the driver only build as a module<br>
 (c) make sure the module and the firmware go together</p>
<p dir=3D"ltr">End of problem.</p>
<p dir=3D"ltr">Why make up random interfaces for crazy stuff?</p>
<p dir=3D"ltr">=C2=A0=C2=A0=C2=A0=C2=A0 Linus</p>

--001a11403930ec27cf053b930ef1--
