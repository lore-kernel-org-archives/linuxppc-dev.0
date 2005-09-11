Return-Path: <glikely@gmail.com>
Received: from qproxy.gmail.com (qproxy.gmail.com [72.14.204.204])
	by ozlabs.org (Postfix) with ESMTP id 9C4F968110
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 11 Sep 2005 16:57:06 +1000 (EST)
Received: by qproxy.gmail.com with SMTP id k13so75729qbf
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Sep 2005 23:57:05 -0700 (PDT)
Message-ID: <528646bc05091023575d640a6e@mail.gmail.com>
Date: Sun, 11 Sep 2005 00:57:05 -0600
From: Grant Likely <glikely@gmail.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
In-Reply-To: <528646bc0509100033167dae7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <528646bc0509100033167dae7f@mail.gmail.com>
Subject: Re: [PATCH 0/2] RFC: Port Virtex-II Pro code to use the platform bus
Reply-To: glikely@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

BTW, I'll be out of town and computer-free until Sept. 19, so I won't
answer any comments until then.

Cheers,
g.

On 9/10/05, Grant Likely <glikely@gmail.com> wrote:
> Here is my work to date to bring the V2Pro port over to the platform
> bus.  I don't expect these to be accepted as-is, but I'm looking for
> comments before I get it polished.
>=20
> Should apply cleanly against 2.6.13 (but may require the TLB patch first)
> http://patchwork.ozlabs.org/linuxppc/patch?id=3D2058
>=20
> Patch 1: changes from the ML300 perspective.  I temporarly don't have
> access to an ML300 so this is untested (but it compiles).  Could
> somebody please test this for me?
>=20
> Patch 2: example patch for another V2PRO based board.  This isn't
> really acceptable for mainline because it's not based on a reference
> or published FPGA design, but it shows the work required to bring up
> another board.  It also shines some light on what code should be
> common between all V2Pro ports (which I'm working on).  This one runs
> on a 2VP4-FG456 eval board (pls ignore all the references to 2VP30).
>
