Return-Path: <monstr@monstr.eu>
Received: from mail-fx0-f174.google.com (mail-fx0-f174.google.com
	[209.85.220.174]) by ozlabs.org (Postfix) with ESMTP id 8CB15DDEED
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 08:13:24 +1100 (EST)
Received: by fxm22 with SMTP id 22so1819938fxm.9
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2009 14:13:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200903231951.23902.arnd@arndb.de>
References: <1237408284-8674-1-git-send-email-monstr@monstr.eu>
	<4b5aee01d11fc790c7842838ea63a82ee3273003.1237407249.git.monstr@monstr.eu>
	<af309ba8e95f503b7990461384d9f8453f45dbbd.1237407249.git.monstr@monstr.eu>
	<200903231951.23902.arnd@arndb.de>
Date: Mon, 23 Mar 2009 21:44:46 +0100
Message-ID: <c1a198be0903231344g3ada4e9dta6310d1a92da8cf3@mail.gmail.com>
Subject: Re: [PATCH 04/57] microblaze_v7: Open firmware files
From: Michal Simek <monstr@monstr.eu>
To: Arnd Bergmann <arnd@arndb.de>
Content-Type: multipart/alternative; boundary=001636c5a4b84739da0465cf5634
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--001636c5a4b84739da0465cf5634
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Arnd,

nice to hear you.

On Wednesday 18 March 2009, monstr@monstr.eu wrote:
> > From: Michal Simek <monstr@monstr.eu>
> >
> >
> > Signed-off-by: Michal Simek <monstr@monstr.eu>
> > ---
> >  arch/microblaze/include/asm/of_device.h   |   45 ++
> >  arch/microblaze/include/asm/of_platform.h |   64 ++
> >  arch/microblaze/include/asm/prom.h        |  313 ++++++++
> >  arch/microblaze/kernel/of_device.c        |  115 +++
> >  arch/microblaze/kernel/of_platform.c      |  201 +++++
> >  arch/microblaze/kernel/prom.c             | 1147
> +++++++++++++++++++++++++++++
> >  arch/microblaze/kernel/prom_parse.c       | 1025
> ++++++++++++++++++++++++++
> >  7 files changed, 2910 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/microblaze/include/asm/of_device.h
> >  create mode 100644 arch/microblaze/include/asm/of_platform.h
> >  create mode 100644 arch/microblaze/include/asm/prom.h
> >  create mode 100644 arch/microblaze/kernel/of_device.c
> >  create mode 100644 arch/microblaze/kernel/of_platform.c
> >  create mode 100644 arch/microblaze/kernel/prom.c
> >  create mode 100644 arch/microblaze/kernel/prom_parse.c
>
> Since these files are derived from the powerpc versions, what is the
> plan on them? IIRC, you had them in a common directory in an earlier
> version. Are you planning to merge them at some point in the future
> or do you intend to maintain a fork?


yes, these files are defived from PPC version. Yes, I added them to generic
location and in this version
are in arch folder. It is easier for me to have them in arch folder till
Microblaze will be in  linus tree.
And then create patch which will synchronize them.

I prefer to have this code in generic location as much as possible but first
stage should be add microblaze code to tree and
then add it to generic location and remove it from all archs which use it.

Thanks,
Michal





>
>
>        Arnd <><
>

--001636c5a4b84739da0465cf5634
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Arnd,<br><br>nice to hear you.<br><br><div class=3D"gmail_quote"><blockq=
uote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 20=
4); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">On Wednesday 18 March 20=
09, monstr@monstr.eu wrote:<br>

&gt; From: Michal Simek &lt;monstr@monstr.eu&gt;<br>
&gt;<br>
&gt;<br>
&gt; Signed-off-by: Michal Simek &lt;monstr@monstr.eu&gt;<br>
&gt; ---<br>
&gt; =A0arch/microblaze/include/asm/of_device.h =A0 | =A0 45 ++<br>
&gt; =A0arch/microblaze/include/asm/of_platform.h | =A0 64 ++<br>
&gt; =A0arch/microblaze/include/asm/prom.h =A0 =A0 =A0 =A0| =A0313 ++++++++=
<br>
&gt; =A0arch/microblaze/kernel/of_device.c =A0 =A0 =A0 =A0| =A0115 +++<br>
&gt; =A0arch/microblaze/kernel/of_platform.c =A0 =A0 =A0| =A0201 +++++<br>
&gt; =A0arch/microblaze/kernel/prom.c =A0 =A0 =A0 =A0 =A0 =A0 | 1147 ++++++=
+++++++++++++++++++++++<br>
&gt; =A0arch/microblaze/kernel/prom_parse.c =A0 =A0 =A0 | 1025 ++++++++++++=
++++++++++++++<br>
&gt; =A07 files changed, 2910 insertions(+), 0 deletions(-)<br>
&gt; =A0create mode 100644 arch/microblaze/include/asm/of_device.h<br>
&gt; =A0create mode 100644 arch/microblaze/include/asm/of_platform.h<br>
&gt; =A0create mode 100644 arch/microblaze/include/asm/prom.h<br>
&gt; =A0create mode 100644 arch/microblaze/kernel/of_device.c<br>
&gt; =A0create mode 100644 arch/microblaze/kernel/of_platform.c<br>
&gt; =A0create mode 100644 arch/microblaze/kernel/prom.c<br>
&gt; =A0create mode 100644 arch/microblaze/kernel/prom_parse.c<br>
<br>
Since these files are derived from the powerpc versions, what is the<br>
plan on them? IIRC, you had them in a common directory in an earlier<br>
version. Are you planning to merge them at some point in the future<br>
or do you intend to maintain a fork?</blockquote><div><br>yes, these files =
are defived from PPC version. Yes, I added them to generic location and in =
this version<br>are in arch folder. It is easier for me to have them in arc=
h folder till Microblaze will be in=A0 linus tree.<br>
And then create patch which will synchronize them.<br><br>I prefer to have =
this code in generic location as much as possible but first stage should be=
 add microblaze code to tree and<br>then add it to generic location and rem=
ove it from all archs which use it.<br>
<br>Thanks,<br>Michal<br><br><br><br>=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0p=
t 0.8ex; padding-left: 1ex;"><br>
<font color=3D"#888888"><br>
 =A0 =A0 =A0 =A0Arnd &lt;&gt;&lt;<br>
</font></blockquote></div><br>

--001636c5a4b84739da0465cf5634--
