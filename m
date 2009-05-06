Return-Path: <markus@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [216.239.33.17])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 62E57DDF7B
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 04:42:44 +1000 (EST)
Received: from spaceape7.eur.corp.google.com (spaceape7.eur.corp.google.com
	[172.28.16.141]) by smtp-out.google.com with ESMTP id n46IgcVN029198
	for <linuxppc-dev@ozlabs.org>; Wed, 6 May 2009 19:42:39 +0100
Received: from gxk10 (gxk10.prod.google.com [10.202.11.10])
	by spaceape7.eur.corp.google.com with ESMTP id n46IgKnk017844
	for <linuxppc-dev@ozlabs.org>; Wed, 6 May 2009 11:42:36 -0700
Received: by gxk10 with SMTP id 10so470181gxk.13
	for <linuxppc-dev@ozlabs.org>; Wed, 06 May 2009 11:42:36 -0700 (PDT)
MIME-Version: 1.0
Sender: markus@google.com
In-Reply-To: <alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
References: <20090228030226.C0D34FC3DA@magilla.sf.frob.com>
	<20090228030413.5B915FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902271932520.3111@localhost.localdomain>
	<alpine.LFD.2.00.0902271948570.3111@localhost.localdomain>
	<20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
Date: Wed, 6 May 2009 11:42:29 -0700
Message-ID: <904b25810905061142s4e8d6e28p98c2ee315bd6b57d@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
From: Markus Gutschke <markus@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: multipart/alternative; boundary=001e680f10f0eba75f046942c16b
Cc: linux-mips@linux-mips.org, x86@kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, stable@kernel.org,
	Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--001e680f10f0eba75f046942c16b
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Sat, Feb 28, 2009 at 10:23, Linus Torvalds <torvalds@linux-foundation.org
> wrote:

> And I guess the seccomp interaction means that this is potentially a
> 2.6.29 thing. Not that I know whether anybody actually _uses_ seccomp. It
> does seem to be enabled in at least Fedora kernels, but it might not be
> used anywhere.
>

In the Linux version of Google Chrome, we are currently working on code that
will use seccomp for parts of our sandboxing solution.


Markus

--001e680f10f0eba75f046942c16b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 28, 2009 at 10:23, Linus Torvalds <span dir=3D"ltr">&lt;<a href=
=3D"mailto:torvalds@linux-foundation.org">torvalds@linux-foundation.org</a>=
&gt;</span> wrote:<br><div class=3D"gmail_quote"><blockquote class=3D"gmail=
_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt=
 0pt 0.8ex; padding-left: 1ex;">

And I guess the seccomp interaction means that this is potentially a<br>
2.6.29 thing. Not that I know whether anybody actually _uses_ seccomp. It<b=
r>
does seem to be enabled in at least Fedora kernels, but it might not be<br>
used anywhere.<br></blockquote></div><br>In the Linux version of Google Chr=
ome, we are currently working on code that will use seccomp for parts of ou=
r sandboxing solution.<br><br><br>Markus<br>

--001e680f10f0eba75f046942c16b--
