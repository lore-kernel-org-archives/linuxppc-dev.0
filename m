To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Cc: kozioziemski1@llnl.gov, linuxppc-dev@lists.linuxppc.org
Subject: Re: severe -O -funroll-loops bug / BLAS
References: <5.0.0.19.2.20000913191147.02585db0@mail.munich.netsurf.de>
Reply-To: kozioziemski1@llnl.gov
From: Bernard Kozioziemski <kozioziemski1@llnl.gov>
Date: 13 Sep 2000 10:23:38 -0700
In-Reply-To: Franz Sirl's message of "Wed, 13 Sep 2000 19:14:18 +0200"
Message-ID: <m33dj4tdd1.fsf@koz1.llnl.gov>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


That fixed it. Thanks for the info.

Franz Sirl <Franz.Sirl-kernel@lauterbach.com> writes:
> Try upgrading to gcc-2.95.3-2d from
>
> ftp://devel.linuxppc.org/users/fsirl/R5/RPMS/ppc/
>
> I backported some loop fixes recently, so maybe it helps.
>
> Franz.

--
kozioziemski1@llnl.gov
(925)424-6317

Sent at -- Wed Sep 13 10:23:38 2000

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
