Return-Path: <markus.t.metzger@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by ozlabs.org (Postfix) with ESMTP id 9577CB7B68
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 21:21:32 +1000 (EST)
From: "Metzger, Markus T" <markus.t.metzger@intel.com>
To: Mahajan Vivek-B08308 <Vivek.Mahajan@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Date: Wed, 23 Sep 2009 12:10:43 +0100
Subject: RE: 2.6.31: powerpc build errors with include/linux/perf_counter.h
Message-ID: <928CFBE8E7CB0040959E56B4EA41A77EC69BB443@irsmsx504.ger.corp.intel.com>
References: <F2F605B667B24B489C904986E0D60A08FF6167@zin33exm23.fsl.freescale.net>
In-Reply-To: <F2F605B667B24B489C904986E0D60A08FF6167@zin33exm23.fsl.freescale.net>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Vivek,

The build errors have been fixed with commit cd74c86bdf705f824d494a2bbda393=
d1d562b40a.

thanks and regards,
markus.

From: Mahajan Vivek-B08308 [mailto:Vivek.Mahajan@freescale.com]=20
Sent: Wednesday, September 23, 2009 1:05 PM
To: linuxppc-dev@ozlabs.org
Cc: Metzger, Markus T
Subject: 2.6.31: powerpc build errors with include/linux/perf_counter.h

Hello Markus,
=A0
Apparently this http://git.kernel.org/?p=3Dlinux/kernel/git/benh/powerpc.gi=
t;a=3Dcommitdiff;h=3D5622f295b53fb60dbf9bed3e2c89d182490a8b7f=A0breaks the =
powerpc build as under when built from http://git.kernel.org/?p=3Dlinux/ker=
nel/git/benh/powerpc.git;a=3Dsummary=A0with latest commit=A0ebc79c4f8da0f92=
efa968e0328f32334a2ce80cf
=A0
cc1: warnings being treated as errors
In file included from arch/powerpc/kernel/irq.c:56:
include/linux/perf_counter.h: In function 'perf_output_begin':
include/linux/perf_counter.h:854: warning: no return statement in function =
returning non-void
include/linux/perf_counter.h: At top level:
include/linux/perf_counter.h:863: warning: 'struct perf_sample_data' declar=
ed inside parameter list
include/linux/perf_counter.h:863: warning: its scope is only this definitio=
n or declaration, which is probably not what
include/linux/perf_counter.h:868: warning: 'struct perf_sample_data' declar=
ed inside parameter list
make[1]: *** [arch/powerpc/kernel/irq.o] Error 1
make: *** [arch/powerpc/kernel] Error 2
Thanks,
Vivek
---------------------------------------------------------------------
Intel GmbH
Dornacher Strasse 1
85622 Feldkirchen/Muenchen Germany
Sitz der Gesellschaft: Feldkirchen bei Muenchen
Geschaeftsfuehrer: Douglas Lusk, Peter Gleissner, Hannes Schwaderer
Registergericht: Muenchen HRB 47456 Ust.-IdNr.
VAT Registration No.: DE129385895
Citibank Frankfurt (BLZ 502 109 00) 600119052

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
