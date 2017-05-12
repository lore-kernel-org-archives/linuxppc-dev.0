Return-Path: <srs0=dgwm=4s=suse.de=msuchanek@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wPZ3k6tnszDqbX
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 May 2017 01:42:26 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wPZ3k4yqvz8tT6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 May 2017 01:42:26 +1000 (AEST)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wPZ3j6t6Yz9s78
 for <linuxppc-dev@ozlabs.org>; Sat, 13 May 2017 01:42:25 +1000 (AEST)
Date: Fri, 12 May 2017 17:42:09 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, linuxppc-dev
 <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH v5 2/2] powerpc/fadump: update documentation about
 'fadump_append=' parameter
Message-ID: <20170512174209.67ccfd45@kitsune.suse.cz>
In-Reply-To: <b1c1c890-fac0-dede-4b80-0fc12f1e95e7@linux.vnet.ibm.com>
References: <149383572199.1694.10940679065871920087.stgit@hbathini.in.ibm.com>
 <149383576571.1694.13692135068122879322.stgit@hbathini.in.ibm.com>
 <20170510180132.1fa0c1ec@kitsune.suse.cz>
 <e1485f4d-f346-fea6-ee2a-9c7a6b2f6587@linux.vnet.ibm.com>
 <20170511151637.19d4a23f@kitsune.suse.cz>
 <b1c1c890-fac0-dede-4b80-0fc12f1e95e7@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 12 May 2017 15:15:33 +0530
Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:

> On Thursday 11 May 2017 06:46 PM, Michal Such=C3=A1nek wrote:
> > On Thu, 11 May 2017 02:00:11 +0530
> > Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:
> > =20
> >> Hello Michal,
> >>
> >> On Wednesday 10 May 2017 09:31 PM, Michal Such=C3=A1nek wrote: =20
> >>> Hello,
> >>>
> >>> On Wed, 03 May 2017 23:52:52 +0530
> >>> Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:
> >>>    =20
> >>>> With the introduction of 'fadump_append=3D' parameter to pass
> >>>> additional parameters to fadump (capture) kernel, update
> >>>> documentation about it.
> >>>>
> >>>> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> >>>> ---
> >>>>
> >>>> Changes from v4:
> >>>> * Based on top of patchset that includes
> >>>>     https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.=
git/commit/?h=3Dakpm&id=3D05f383cdfba8793240e73f9a9fbff4e25d66003f
> >>>>
> >>>>
> >>>>    Documentation/powerpc/firmware-assisted-dump.txt |   10
> >>>> +++++++++- 1 file changed, 9 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/Documentation/powerpc/firmware-assisted-dump.txt
> >>>> b/Documentation/powerpc/firmware-assisted-dump.txt index
> >>>> 8394bc8..6327193 100644 ---
> >>>> a/Documentation/powerpc/firmware-assisted-dump.txt +++
> >>>> b/Documentation/powerpc/firmware-assisted-dump.txt @@ -162,7
> >>>> +162,15 @@ How to enable firmware-assisted dump (fadump):
> >>>>    1. Set config option CONFIG_FA_DUMP=3Dy and build kernel.
> >>>>    2. Boot into linux kernel with 'fadump=3Don' kernel cmdline
> >>>> option. -3. Optionally, user can also set 'crashkernel=3D' kernel
> >>>> cmdline +3. A user can pass additional command line parameters
> >>>> as a comma
> >>>> +   separated list through 'fadump_append=3D' parameter, to be
> >>>> enforced
> >>>> +   when fadump is active. For example, if parameters like
> >>>> nr_cpus=3D1,
> >>>> +   numa=3Doff & udev.children-max=3D2 are to be enforced when fadump
> >>>> is
> >>>> +   active,
> >>>> 'fadump_append=3Dnr_cpus=3D1,numa=3Doff,udev.children-max=3D2'
> >>>> +   can be passed in command line, which will be replaced with
> >>>> +   "nr_cpus=3D1 numa=3Doff udev.children-max=3D2" when fadump is
> >>>> active.
> >>>> +   This helps in reducing memory consumption during dump
> >>>> capture. +4. Optionally, user can also set 'crashkernel=3D' kernel
> >>>> cmdline to specify size of the memory to reserve for boot memory
> >>>> dump preservation.
> >>>>   =20
> >>>>    =20
> >>> Writing your own deficient parser for comma separated arguments
> >>> when perfectly fine parser for space separated quoted arguments
> >>> exists in the kernel and the bootloader does not seem like a good
> >>> idea to me. =20
> >>
> >> Couple of things that prompted me for v5 are:
> >>     1. Using parse_early_options() limits the kind of parameters
> >>        that can be passed to fadump capture kernel. Passing
> >> parameters like systemd.unit=3D & udev.childern.max=3D has no effect
> >> with v4. Updating
> >>        boot_command_line parameter, when fadump is active, seems a
> >> better alternative.
> >>
> >>     2. Passing space-separated quoted arguments is not working
> >>        as intended with lilo. Updating bootloader with the below
> >>        entry in /etc/lilo.conf file results in a missing append
> >>        entry in /etc/yaboot.conf file.
> >>
> >>          append =3D "quiet sysrq=3D1 insmod=3Dsym53c8xx insmod=3Dipr
> >> crashkernel=3D512M-:256M fadump_append=3D\"nr_cpus=3D1 numa=3Doff
> >> udev.children-max=3D2\"" =20
> > Meaning that a script that emulates LILO semantics on top of yaboot
> > which is completely capable of passing qouted space separated
> > arguments fails. IMHO it is more reasonable to fix the script or
> > whatever adaptation layer or use yaboot directly than working
> > around bug in said script by introducing a new argument parser in
> > the kernel.
> >
> > =20
>=20
> Hmmm.. while trying to implement space-separated parameter list with
> quotes as syntax for fadump_append parameter, noticed that it can
> make implemenation
> more vulnerable. Here are some problems I am facing while
> implementing this..

How so?

presumably you can reuse parse_args even if you do not register with
early_param and call it yourself. Then your parsing of fadump_append is
as vulnerable as parsing any other kernel argument since it is using
same parser.

Thanks

Michal
