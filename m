Message-Id: <5.0.0.19.2.20000913191147.02585db0@mail.munich.netsurf.de>
Date: Wed, 13 Sep 2000 19:14:18 +0200
To: kozioziemski1@llnl.gov
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: severe -O -funroll-loops bug / BLAS 
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <m3ya0wgs5p.fsf@koz1.llnl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 18:42 13.09.00, Bernard Kozioziemski wrote:
>rpm -qf /usr/bin/gcc returns gcc-2.95.2-1i

Try upgrading to gcc-2.95.3-2d from

ftp://devel.linuxppc.org/users/fsirl/R5/RPMS/ppc/

I backported some loop fixes recently, so maybe it helps.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
