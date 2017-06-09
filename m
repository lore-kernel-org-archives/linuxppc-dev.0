Return-Path: <srs0=k5jy=5o=suse.de=msuchanek@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wkgvv1V7dzDqLJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 22:04:59 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wkgvv0vqTz8sWT
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 22:04:59 +1000 (AEST)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wkgvt2Scpz9s7v
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Jun 2017 22:04:57 +1000 (AEST)
Date: Fri, 9 Jun 2017 14:04:54 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, linuxppc-dev
 <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH v5 2/2] powerpc/fadump: update documentation about
 'fadump_append=' parameter
Message-ID: <20170609140454.2eb01371@kitsune.suse.cz>
In-Reply-To: <102276aa-cddb-dc60-269c-b29dedc89eab@linux.vnet.ibm.com>
References: <149383572199.1694.10940679065871920087.stgit@hbathini.in.ibm.com>
 <149383576571.1694.13692135068122879322.stgit@hbathini.in.ibm.com>
 <20170510180132.1fa0c1ec@kitsune.suse.cz>
 <e1485f4d-f346-fea6-ee2a-9c7a6b2f6587@linux.vnet.ibm.com>
 <20170511151637.19d4a23f@kitsune.suse.cz>
 <b1c1c890-fac0-dede-4b80-0fc12f1e95e7@linux.vnet.ibm.com>
 <20170512174209.67ccfd45@kitsune.suse.cz>
 <b6a968fe-378e-1273-a996-43c716f276bd@linux.vnet.ibm.com>
 <20170515112901.67d32e76@kitsune.suse.cz>
 <102276aa-cddb-dc60-269c-b29dedc89eab@linux.vnet.ibm.com>
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

On Thu, 8 Jun 2017 23:30:37 +0530
Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:

> Hi Michal,
>=20
> Sorry for taking this long to respond. I was working on a few other
> things.
>=20
> On Monday 15 May 2017 02:59 PM, Michal Such=C3=A1nek wrote:
> > Hello,
> >
> > On Mon, 15 May 2017 12:59:46 +0530
> > Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:
> > =20
> >> On Friday 12 May 2017 09:12 PM, Michal Such=C3=A1nek wrote: =20
> >>> On Fri, 12 May 2017 15:15:33 +0530
> >>> Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:
> >>>    =20
> >>>> On Thursday 11 May 2017 06:46 PM, Michal Such=C3=A1nek wrote: =20
> >>>>> On Thu, 11 May 2017 02:00:11 +0530
> >>>>> Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:
> >>>>>       =20
> >>>>>> Hello Michal,
> >>>>>>
> >>>>>> On Wednesday 10 May 2017 09:31 PM, Michal Such=C3=A1nek wrote: =20
> >>>>>>> Hello,
> >>>>>>>
> >>>>>>> On Wed, 03 May 2017 23:52:52 +0530
> >>>>>>> Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:
> >>>>>>>          =20
> >>>>>>>> With the introduction of 'fadump_append=3D' parameter to pass
> >>>>>>>> additional parameters to fadump (capture) kernel, update
> >>>>>>>> documentation about it.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> >>>>>>>> ---
> >>>>>>>>
> >>>>>>>> Changes from v4:
> >>>>>>>> * Based on top of patchset that includes
> >>>>>>>>       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux=
-next.git/commit/?h=3Dakpm&id=3D05f383cdfba8793240e73f9a9fbff4e25d66003f
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>      Documentation/powerpc/firmware-assisted-dump.txt |   10
> >>>>>>>> +++++++++- 1 file changed, 9 insertions(+), 1 deletion(-)
> >>>>>>>>
> >>>>>>>> diff --git a/Documentation/powerpc/firmware-assisted-dump.txt
> >>>>>>>> b/Documentation/powerpc/firmware-assisted-dump.txt index
> >>>>>>>> 8394bc8..6327193 100644 ---
> >>>>>>>> a/Documentation/powerpc/firmware-assisted-dump.txt +++
> >>>>>>>> b/Documentation/powerpc/firmware-assisted-dump.txt @@ -162,7
> >>>>>>>> +162,15 @@ How to enable firmware-assisted dump (fadump):
> >>>>>>>>      1. Set config option CONFIG_FA_DUMP=3Dy and build kernel.
> >>>>>>>>      2. Boot into linux kernel with 'fadump=3Don' kernel
> >>>>>>>> cmdline option. -3. Optionally, user can also set
> >>>>>>>> 'crashkernel=3D' kernel cmdline +3. A user can pass additional
> >>>>>>>> command line parameters as a comma
> >>>>>>>> +   separated list through 'fadump_append=3D' parameter, to be
> >>>>>>>> enforced
> >>>>>>>> +   when fadump is active. For example, if parameters like
> >>>>>>>> nr_cpus=3D1,
> >>>>>>>> +   numa=3Doff & udev.children-max=3D2 are to be enforced when
> >>>>>>>> fadump is
> >>>>>>>> +   active,
> >>>>>>>> 'fadump_append=3Dnr_cpus=3D1,numa=3Doff,udev.children-max=3D2'
> >>>>>>>> +   can be passed in command line, which will be replaced
> >>>>>>>> with
> >>>>>>>> +   "nr_cpus=3D1 numa=3Doff udev.children-max=3D2" when fadump is
> >>>>>>>> active.
> >>>>>>>> +   This helps in reducing memory consumption during dump
> >>>>>>>> capture. +4. Optionally, user can also set 'crashkernel=3D'
> >>>>>>>> kernel cmdline to specify size of the memory to reserve for
> >>>>>>>> boot memory dump preservation.
> >>>>>>>>     =20
> >>>>>>>>          =20
> >>>>>>> Writing your own deficient parser for comma separated
> >>>>>>> arguments when perfectly fine parser for space separated
> >>>>>>> quoted arguments exists in the kernel and the bootloader does
> >>>>>>> not seem like a good idea to me. =20
> >>>>>> Couple of things that prompted me for v5 are:
> >>>>>>       1. Using parse_early_options() limits the kind of
> >>>>>> parameters that can be passed to fadump capture kernel. Passing
> >>>>>> parameters like systemd.unit=3D & udev.childern.max=3D has no
> >>>>>> effect with v4. Updating
> >>>>>>          boot_command_line parameter, when fadump is active,
> >>>>>> seems a better alternative.
> >>>>>>
> >>>>>>       2. Passing space-separated quoted arguments is not
> >>>>>> working as intended with lilo. Updating bootloader with the
> >>>>>> below entry in /etc/lilo.conf file results in a missing append
> >>>>>>          entry in /etc/yaboot.conf file.
> >>>>>>
> >>>>>>            append =3D "quiet sysrq=3D1 insmod=3Dsym53c8xx insmod=
=3Dipr
> >>>>>> crashkernel=3D512M-:256M fadump_append=3D\"nr_cpus=3D1 numa=3Doff
> >>>>>> udev.children-max=3D2\"" =20
> >>>>> Meaning that a script that emulates LILO semantics on top of
> >>>>> yaboot which is completely capable of passing qouted space
> >>>>> separated arguments fails. IMHO it is more reasonable to fix the
> >>>>> script or whatever adaptation layer or use yaboot directly than
> >>>>> working around bug in said script by introducing a new argument
> >>>>> parser in the kernel.
> >>>>>
> >>>>>       =20
> >>>> Hmmm.. while trying to implement space-separated parameter list
> >>>> with quotes as syntax for fadump_append parameter, noticed that
> >>>> it can make implemenation
> >>>> more vulnerable. Here are some problems I am facing while
> >>>> implementing this.. =20
> >>> How so?
> >>>
> >>> presumably you can reuse parse_args even if you do not register
> >>> with early_param and call it yourself. Then your parsing of
> >>> fadump_append is =20
> >>
> >> I wasn't aware of that. Thanks for pointing it out, Michal.
> >> Will try to use parse_args and get back.
> >> =20
> > I was thinking a bit more about the uses of the commandline and how
> > fadump_append potentially breaks it.
> >
> > The first thing that should be addressed and is the special --
> > argument which denotes the start of init arguments that are not to
> > be parsed by the kernel. Incidentally the initial implementation
> > using early_param happened to handles that without issue.
> > parse_args surely handles that so adding a hook somewhere should
> > give you location of that argument (if any). And interesting thing
> > that can happen is passing an -- inside the fadump_append argument.
> > It should be handled (or not) in some way or other and the handling
> > documented. =20
>=20
>=20
> The intention with this patch is to replace
>=20
>    "root=3D/dev/sda2 ro fadump_append=3Dnr_cpus=3D1,numa=3Doff
> crashkernel=3D1024M"
>=20
> with
>=20
>    "root=3D/dev/sda2 ro nr_cpus=3D1 numa=3Doff crashkernel=3D1024M"
>=20
> when kernel is booting for dump capture.
> While parse_args() is making parsing relatively easy, the main idea is
> to replace parameters as above when fadump capture kernel is booting.

> The code is relatively complicated to replace parameters using=20
> space-separated
> quoted string even though parse_args() may parse them easily.=20
> Comma-separated
> list was easier to implement and seemed less error prone for
> replacing parameters.


You can still do that relatively easily. parse_args() gives you the
content of fadump_capture argument. You should probably add a variant
that gives you also the position of the fadump_capture argument in case
user specified it multiple times - picking the wrong one would cause
errors.

Then you can just replace the fadump_append=3D"appended arguments" with
the dequoted "appended arguments" parse_args() gives you. Dequating
should shorten the arguments as would removing the fadump_append=3D
prefix so it should be quite possible in-place. It is in fact even
easier than the comma separated list since you do not need to do any
parsing yourself - only strlen, memset and memcpy.

That said, if you replace the fadump_append argument the running kernel
will have extra arguments without knowing where they came from making
detection of this happening all the more difficult.

>=20
> Want to replace fadump_append=3D, to avoid command line overflow issues
> and also to not have to deal with special cases like --. Actually,=20
> fadump_append=3D
> seems to be confusing in that sense. How about=20
> fadump_args=3Dcomma-separated-list-
> of-params-for-capture-kernel ? Please share your thoughts.

The comma separated list still can contain a -- argument so you still
have to do something about that. Or not and just document that people
should not use it.

As for the parameter name fadump_args or fadump_extra_args is more
generic than fadump_append giving you more room for changing the
implementation details without making the argument name non-sensical.

>=20
>=20
> > The second thing that breaks is reusing content of /proc/cmdline in
> > kexec calls for passing arguments to the loaded kernel. It works
> > flawlessly passing the same arguments the currently running kernel
> > was started with unless fadump_append argument handler appends
> > content of the fadump_append argument to actual commandline that
> > appears there. So this would be an argument against modifying the
> > commandline. You could argue using fadump and kexec together is an
> > exotic use case but I would expect that the very machines that
> > require fadump_append to reduce dump memory requirement benefit
> > from using kexec for reboots because the BIOS probing the hardware
> > takes quite a while as well. If rewriting the commandline is
> > desired then this side effect of recursively adding the content of
> > fadump_append on kexecs which reuse /proc/cmdline should be
> > documented.
> >
> > =20
>=20
> fadump capture kernel (the kernel where we expand
> "fadump_append=3Dx,y,z" to "x y z") only advised to be used for saving
> dump (just like kdump kernel).
> We are expected to boot into production kernel immediately after
> saving dump.

Which you can do for example using kexec.

> Only in special cases where a user configures to stay in fadump
> capture kernel
> will he encounter the above problem. And someone choosing such
> scenario is most
> likely aware of what to make of /proc/cmdline?

Why? They leave that to the initscripts and since you just changed the
semantics of the kernel parameters significantly those can produce
entertaining results.

Thanks

Michal
