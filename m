Return-Path: <ataufer@us.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 375F72C0100
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Dec 2012 01:31:22 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ataufer@us.ibm.com>;
 Fri, 7 Dec 2012 09:31:19 -0500
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id AD80038C8045
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2012 09:31:17 -0500 (EST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qB7EVGNJ248256
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Dec 2012 09:31:17 -0500
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qB7EVBvX002609
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Dec 2012 07:31:11 -0700
In-Reply-To: <644E8572-68F8-4C31-AA9D-96EBC95BC37F@pobox.com>
References: <958841B4-9626-48A2-A28A-13EA3F1D52AE@pobox.com>
 <22977.1354859787@neuling.org>
 <644E8572-68F8-4C31-AA9D-96EBC95BC37F@pobox.com>
Subject: Re: [RFC] Add IBM Blue Gene/Q Platform
To: Jimi Xenidis <jimix@pobox.com>
Message-ID: <OFD0D3396A.6EC5ADFF-ON86257ACD.004F1662-86257ACD.004FC5B0@us.ibm.com>
From: Andrew Tauferner <ataufer@us.ibm.com>
Date: Fri, 7 Dec 2012 08:31:09 -0600
MIME-Version: 1.0
Content-type: multipart/alternative;
 Boundary="0__=09BBF05EDFDC90F28f9e8a93df938690918c09BBF05EDFDC90F2"
Cc: Michael Neuling <mikey@neuling.org>, Jimi Xenidis <xenidis@gmail.com>,
 Kumar Gala <kumar.gala@gmail.com>, Jay S Bryant <jsbryant@us.ibm.com>,
 Josh Boyer <jwboyer@linux.vnet.ibm.com>, Todd Inglett <tinglett@us.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0__=09BBF05EDFDC90F28f9e8a93df938690918c09BBF05EDFDC90F2
Content-type: text/plain; charset=US-ASCII

Jimi,

> > Do you actually want this upstream?  I assume no.
>
> I needed to get these long-term patches out there for the BGQ
> community for test.

To which BGQ community are you referring?  What is the motivation
for this work?

> I would very much like to get a version of these upstream.
> I expect only the QPX, kexec, and (maybe) the DCR changes to cause
> any controversy, but I've been wrong before.

Hehe.  Ben had a variety of issues with the BG/Q firmware when he
gave me some feedback a few years ago.

> I'll be making those patches soon and hope to get a lot of feedback
> from these patches.

What was the starting point for this work?  On what is it based?

> -jx
>
>
> >
> > Mikey
> >
> >>
> >> Here is a are the summary logs:
> >>
> >> $ git log --reverse linux-stable/linux-3.4.y..
> >> commit 5a8edb2bdd914597693eed299119ff4c2e6d31f2
> >> Author: Jimi Xenidis <jimix@pobox.com>
> >> Date:   Fri Nov 9 09:26:00 2012 -0600
> >>
> >>    powerpc: Fix cputable #ifdef where CONFIG_PPC_A2 is used for
> CONFIG_PPC_BOOK3E_64
> >>
> >>    Signed-off-by: Jimi Xenidis <jimix@pobox.com>
> >>
> >> commit ea51920d7035c8d23801d6de46261e7d0a537dfd
> >> Author: Jimi Xenidis <jimix@pobox.com>
> >> Date:   Fri Nov 9 08:58:27 2012 -0600
> >>
> >>    powerpc/book3e: Remove config for PPC_A2_DD2 since there is no
> reference to it
> >>
> >>    This must have been leftover from early DD1 days which is not
> >>    present in any current kernel code.
> >>
> >>    Signed-off-by: Jimi Xenidis <jimix@pobox.com>
> >>
> >> commit 08151401a5db4ff0d441a1b7bf8ad92bd92b14c5
> >> Author: Jimi Xenidis <jimix@pobox.com>
> >> Date:   Mon Nov 5 09:38:01 2012 -0600
> >>
> >>    powerpc/dcr: Some native DCR fixes
> >>
> >>    The following fixes have been made:
> >>     - dcr_read/write_native() must use the indexed version of the
> >>       m[ft]dcrx since the non-indexed version only allows a 10-bit
> >>       numerical space, but the C interface allows a full 32-bits.
> >>     - C bindings for m[ft]dcrx, and the "table" versions, should use
> >>       "unsigned long" so that they are 64/32 bit neutral.
> >>     - The "table" versions (__m[ft]cdr) should obtain the table
address
> >>       with LOAD_REG_ADDR(), this will also make it 64/32bit neutral.
> >>
> >>    Signed-off-by: Jimi Xenidis <jimix@pobox.com>
> >>
> >> commit c8320a5daaceed03992d763302020834ea8e17dd
> >> Author: Jimi Xenidis <jimix@pobox.com>
> >> Date:   Mon Nov 5 09:12:00 2012 -0600
> >>
> >>    powerpc/dcr: Add 64-bit DCR access methods.
> >>
> >>    This patch adds the ability to make 64-bit Device Control Register
> >>    (DCR) accesses.
> >>
> >>    Signed-off-by: Jimi Xenidis <jimix@pobox.com>
> >>
> >> commit a763b3f8453b3bd83d7dded8c6644939863af430
> >> Author: Jimi Xenidis <jimix@pobox.com>
> >> Date:   Thu Nov 29 12:49:24 2012 -0500
> >>
> >>    powerpc/boot: Add a "spin_threads" hook to platform_ops
> >>
> >>    It is useful for the boot program to arrange for all secondary cpus
> >>    and threads to enter the kernel in a "kexec" fashion.  This hook
makes
> >>    it possible.
> >>
> >>    Signed-off-by: Jimi Xenidis <jimix@pobox.com>
> >>
> >> commit 391e43393380b514d4d02a42d059619542c7597b
> >> Author: Jimi Xenidis <jimix@pobox.com>
> >> Date:   Thu Nov 29 13:01:23 2012 -0500
> >>
> >>    powerpc/kexec: Add kexec "hold" support for Book3e processors
> >>
> >>    This patch add two items:
> >>    1) Book3e requires that GPR4 survive the "hold" process, so we make
> >>       sure that happens.
> >>    2) Book3e has no real mode, and the hold code exploits this.  Since
> >>       these processors ares always translated, we arrange for the
kexeced
> >>       threads to enter the hold code using the normal kernel
> linear mapping.
> >>
> >>    Signed-off-by: Jimi Xenidis <jimix@pobox.com>
> >>
> >> commit f6e3c1f706cb6922349d639a74ff6c50acc8b9f8
> >> Author: Jimi Xenidis <jimix@pobox.com>
> >> Date:   Wed Dec 5 13:41:25 2012 -0500
> >>
> >>    powerpc: Remove unecessary VSX symbols
> >>
> >>    The symbol THREAD_VSR0 is defined to be the same as THREAD_FPR0.
Its
> >>    presence causes build issues with more complex configurations.
> >>
> >>    Signed-off-by: Jimi Xenidis <jimix@pobox.com>
> >>
> >> commit 4e817bb42ec8e3d3689877528dd97c4286a870eb
> >> Author: Jimi Xenidis <jimix@pobox.com>
> >> Date:   Tue Nov 20 10:10:52 2012 -0600
> >>
> >>    Blue Gene/Q wicked optimizing compiler does not know the rfdi
> instruction yet
> >>
> >>    Signed-off-by: Jimi Xenidis <jimix@pobox.com>
> >>
> >> commit 2071aa58b2f3b33d97c94e3a127f7c5d4ffaeb34
> >> Author: Jimi Xenidis <jimix@pobox.com>
> >> Date:   Tue Nov 20 10:14:22 2012 -0600
> >>
> >>    Blue Gene/Q wicked optimizing compiler does not know the
> mfdcrx instruction yet
> >>
> >>    Signed-off-by: Jimi Xenidis <jimix@pobox.com>
> >>
> >> commit 6e58088fabedbb2d724637b539ba180c03ed8b68
> >> Author: Jimi Xenidis <jimix@pobox.com>
> >> Date:   Wed Oct 31 16:33:21 2012 -0500
> >>
> >>    powerpc/book3e: IBM Blue Gene/Q Boot
> >>
> >>    This patch specifically deals with the initial program load
> >>    environment so that a boot image (dtbImage.bgq) can be loaded by
the
> >>    BGQ management tools.  The boot code is a little odd because it has
to
> >>    deal with the following issues:
> >>     - Linux boot image wrappers are 32-bit programs
> >>     - BGQ Tools only load 64bit ELF programs
> >>     - BGQ Firmware information is typically loaded at an address > 4G
> >>     - BGQ FW information contains 64-bit ABI function pointers (which
are
> >>       actually function descriptors) to access firmware methods
> >>     - BGQ FW methods must be called in 64-bit mode
> >>
> >>    Includes code contributed from:
> >>      Andrew Tauferner <ataufer@us.ibm.com>
> >>      Todd Inglett <tinglett@us.ibm.com>
> >>      Eric Van Hensbergen <ericvh@gmail.com>
> >>
> >>    Signed-off-by: Jimi Xenidis <jimix@pobox.com>
> >>
> >> commit 3bc841935eb4955ce2b2db69bff16f7928464597
> >> Author: Jimi Xenidis <jimix@pobox.com>
> >> Date:   Wed Oct 31 22:36:54 2012 -0500
> >>
> >>    powerpc/book3e: IBM Blue Gene/Q Platform and SMP
> >>
> >>    This patch introduces BGQ as a platform and adds SMP functionality
> >>
> >>    Includes code contributed from:
> >>      Andrew Tauferner <ataufer@us.ibm.com>
> >>      Todd Inglett <tinglett@us.ibm.com>
> >>      Eric Van Hensbergen <ericvh@gmail.com>
> >>
> >>    Signed-off-by: Jimi Xenidis <jimix@pobox.com>
> >>
> >> commit 279c0615917b959a652e81f4ad0d886e2d426d85
> >> Author: Jimi Xenidis <jimix@pobox.com>
> >> Date:   Wed Dec 5 13:43:22 2012 -0500
> >>
> >>    powerpc/book3e: IBM Blue Gene/Q Quad Processing eXtention (QPX)
> >>
> >>    This enables kernel support for the QPX extention and is intended
for
> >>    processors that support it, usually an IBM Blue Gene processor.
> >>    Turning it on does not effect other processors but it does add code
> >>    and will quadruple the per thread save and restore area for the FPU
> >>    (hense the name).  If you have enabled VSX it will only double the
> >>    space.
> >>
> >>    Signed-off-by: Jimi Xenidis <jimix@pobox.com>
> >>
> >> commit 6ff45170ab0463fb34d7011e08c7e47c396f0fd7
> >> Author: Jimi Xenidis <jimix@pobox.com>
> >> Date:   Fri Nov 23 14:52:14 2012 -0600
> >>
> >>    powerpc/book3e: IBM Blue Gene/Q HVC Based Firmware Console
> >>
> >>    New HVC device that uses the Blue Gene Firmware methods to erad and
> >>    write to console.
> >>
> >>        Includes code contributed from:
> >>          Andrew Tauferner <ataufer@us.ibm.com>
> >>          Todd Inglett <tinglett@us.ibm.com>
> >>          Eric Van Hensbergen <ericvh@gmail.com>
> >>
> >>    Signed-off-by: Jimi Xenidis <jimix@pobox.com>
> >>
> >> commit e4ddc0c2ad8b3f0260d15d73e153095e95da84ac
> >> Author: Jimi Xenidis <jimix@pobox.com>
> >> Date:   Thu Nov 29 15:52:04 2012 -0500
> >>
> >>    powerpc/book3e: IBM Blue Gene/Q PCIe and MSI
> >>
> >>    The following patch adds support for the BG/Q PCIe bridge and
> MSI interrupts.
> >>
> >>    Includes code contributed from:
> >>      Jay S. Bryant <jsbryant@us.ibm.com>
> >>      Eric Van Hensbergen <ericvh@gmail.com>
> >>
> >>    Signed-off-by: Jimi Xenidis <jimix@pobox.com>
> >>
> >> commit 9fc0b6f729f7bd7e31338283640a718fa4b1693b
> >> Author: Jimi Xenidis <jimix@pobox.com>
> >> Date:   Wed Dec 5 07:01:49 2012 -0500
> >>
> >>    powerpc/book3e: IBM Blue Gene/Q Character Drivers
> >>
> >>    The following patch adds support for user and administration
> >>    applications to access the BG/Q control system.
> >>
> >>    Includes code contributed from:
> >>      Jay S. Bryant <jsbryant@us.ibm.com>
> >>      Eric Van Hensbergen <ericvh@gmail.com>
> >>
> >>    Signed-off-by: Jimi Xenidis <jimix@pobox.com>
> >>
> >> commit 9df2c4dfde0ac75f8b2bfcf565f78c2b7382b031
> >> Author: Jimi Xenidis <jimix@pobox.com>
> >> Date:   Thu Dec 6 18:07:16 2012 -0500
> >>
> >>    Linux 3.4.22-BGQ-rc1
> >>
> >>
> >>
> >>
> >> _______________________________________________
> >> Linuxppc-dev mailing list
> >> Linuxppc-dev@lists.ozlabs.org
> >> https://lists.ozlabs.org/listinfo/linuxppc-dev
> >>
>
--0__=09BBF05EDFDC90F28f9e8a93df938690918c09BBF05EDFDC90F2
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt><font size="2">Jimi,</font></tt><br>
<tt><font size="2"><br>
&gt; &gt; Do you actually want this upstream? &nbsp;I assume no.<br>
&gt; <br>
&gt; I needed to get these long-term patches out there for the BGQ <br>
&gt; community for test.</font></tt><br>
<br>
<tt><font size="2">To which BGQ community are you referring? &nbsp;What is the motivation </font></tt><br>
<tt><font size="2">for this work?</font></tt><br>
<tt><font size="2"><br>
&gt; I would very much like to get a version of these upstream.<br>
&gt; I expect only the QPX, kexec, and (maybe) the DCR changes to cause <br>
&gt; any controversy, but I've been wrong before.</font></tt><br>
<br>
<tt><font size="2">Hehe. &nbsp;Ben had a variety of issues with the BG/Q firmware when he </font></tt><br>
<tt><font size="2">gave me some feedback a few years ago.</font></tt><br>
<tt><font size="2"><br>
&gt; I'll be making those patches soon and hope to get a lot of feedback <br>
&gt; from these patches.</font></tt><br>
<br>
<tt><font size="2">What was the starting point for this work? &nbsp;On what is it based?</font></tt><br>
<tt><font size="2"><br>
&gt; -jx<br>
&gt; <br>
&gt; <br>
&gt; &gt; <br>
&gt; &gt; Mikey<br>
&gt; &gt; <br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; Here is a are the summary logs:<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; $ git log --reverse linux-stable/linux-3.4.y..<br>
&gt; &gt;&gt; commit 5a8edb2bdd914597693eed299119ff4c2e6d31f2<br>
&gt; &gt;&gt; Author: Jimi Xenidis &lt;jimix@pobox.com&gt;<br>
&gt; &gt;&gt; Date: &nbsp; Fri Nov 9 09:26:00 2012 -0600<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;powerpc: Fix cputable #ifdef where CONFIG_PPC_A2 is used for <br>
&gt; CONFIG_PPC_BOOK3E_64<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;Signed-off-by: Jimi Xenidis &lt;jimix@pobox.com&gt;<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; commit ea51920d7035c8d23801d6de46261e7d0a537dfd<br>
&gt; &gt;&gt; Author: Jimi Xenidis &lt;jimix@pobox.com&gt;<br>
&gt; &gt;&gt; Date: &nbsp; Fri Nov 9 08:58:27 2012 -0600<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;powerpc/book3e: Remove config for PPC_A2_DD2 since there is no<br>
&gt; reference to it<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;This must have been leftover from early DD1 days which is not<br>
&gt; &gt;&gt; &nbsp; &nbsp;present in any current kernel code.<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;Signed-off-by: Jimi Xenidis &lt;jimix@pobox.com&gt;<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; commit 08151401a5db4ff0d441a1b7bf8ad92bd92b14c5<br>
&gt; &gt;&gt; Author: Jimi Xenidis &lt;jimix@pobox.com&gt;<br>
&gt; &gt;&gt; Date: &nbsp; Mon Nov 5 09:38:01 2012 -0600<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;powerpc/dcr: Some native DCR fixes<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;The following fixes have been made:<br>
&gt; &gt;&gt; &nbsp; &nbsp; - dcr_read/write_native() must use the indexed version of the<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; m[ft]dcrx since the non-indexed version only allows a 10-bit<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; numerical space, but the C interface allows a full 32-bits.<br>
&gt; &gt;&gt; &nbsp; &nbsp; - C bindings for m[ft]dcrx, and the &quot;table&quot; versions, should use<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &quot;unsigned long&quot; so that they are 64/32 bit neutral.<br>
&gt; &gt;&gt; &nbsp; &nbsp; - The &quot;table&quot; versions (__m[ft]cdr) should obtain the table address<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; with LOAD_REG_ADDR(), this will also make it 64/32bit neutral.<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;Signed-off-by: Jimi Xenidis &lt;jimix@pobox.com&gt;<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; commit c8320a5daaceed03992d763302020834ea8e17dd<br>
&gt; &gt;&gt; Author: Jimi Xenidis &lt;jimix@pobox.com&gt;<br>
&gt; &gt;&gt; Date: &nbsp; Mon Nov 5 09:12:00 2012 -0600<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;powerpc/dcr: Add 64-bit DCR access methods.<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;This patch adds the ability to make 64-bit Device Control Register<br>
&gt; &gt;&gt; &nbsp; &nbsp;(DCR) accesses.<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;Signed-off-by: Jimi Xenidis &lt;jimix@pobox.com&gt;<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; commit a763b3f8453b3bd83d7dded8c6644939863af430<br>
&gt; &gt;&gt; Author: Jimi Xenidis &lt;jimix@pobox.com&gt;<br>
&gt; &gt;&gt; Date: &nbsp; Thu Nov 29 12:49:24 2012 -0500<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;powerpc/boot: Add a &quot;spin_threads&quot; hook to platform_ops<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;It is useful for the boot program to arrange for all secondary cpus<br>
&gt; &gt;&gt; &nbsp; &nbsp;and threads to enter the kernel in a &quot;kexec&quot; fashion. &nbsp;This hook makes<br>
&gt; &gt;&gt; &nbsp; &nbsp;it possible.<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;Signed-off-by: Jimi Xenidis &lt;jimix@pobox.com&gt;<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; commit 391e43393380b514d4d02a42d059619542c7597b<br>
&gt; &gt;&gt; Author: Jimi Xenidis &lt;jimix@pobox.com&gt;<br>
&gt; &gt;&gt; Date: &nbsp; Thu Nov 29 13:01:23 2012 -0500<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;powerpc/kexec: Add kexec &quot;hold&quot; support for Book3e processors<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;This patch add two items:<br>
&gt; &gt;&gt; &nbsp; &nbsp;1) Book3e requires that GPR4 survive the &quot;hold&quot; process, so we make<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; sure that happens.<br>
&gt; &gt;&gt; &nbsp; &nbsp;2) Book3e has no real mode, and the hold code exploits this. &nbsp;Since<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; these processors ares always translated, we arrange for the kexeced<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; threads to enter the hold code using the normal kernel <br>
&gt; linear mapping.<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;Signed-off-by: Jimi Xenidis &lt;jimix@pobox.com&gt;<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; commit f6e3c1f706cb6922349d639a74ff6c50acc8b9f8<br>
&gt; &gt;&gt; Author: Jimi Xenidis &lt;jimix@pobox.com&gt;<br>
&gt; &gt;&gt; Date: &nbsp; Wed Dec 5 13:41:25 2012 -0500<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;powerpc: Remove unecessary VSX symbols<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;The symbol THREAD_VSR0 is defined to be the same as THREAD_FPR0. &nbsp;Its<br>
&gt; &gt;&gt; &nbsp; &nbsp;presence causes build issues with more complex configurations.<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;Signed-off-by: Jimi Xenidis &lt;jimix@pobox.com&gt;<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; commit 4e817bb42ec8e3d3689877528dd97c4286a870eb<br>
&gt; &gt;&gt; Author: Jimi Xenidis &lt;jimix@pobox.com&gt;<br>
&gt; &gt;&gt; Date: &nbsp; Tue Nov 20 10:10:52 2012 -0600<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;Blue Gene/Q wicked optimizing compiler does not know the rfdi <br>
&gt; instruction yet<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;Signed-off-by: Jimi Xenidis &lt;jimix@pobox.com&gt;<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; commit 2071aa58b2f3b33d97c94e3a127f7c5d4ffaeb34<br>
&gt; &gt;&gt; Author: Jimi Xenidis &lt;jimix@pobox.com&gt;<br>
&gt; &gt;&gt; Date: &nbsp; Tue Nov 20 10:14:22 2012 -0600<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;Blue Gene/Q wicked optimizing compiler does not know the <br>
&gt; mfdcrx instruction yet<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;Signed-off-by: Jimi Xenidis &lt;jimix@pobox.com&gt;<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; commit 6e58088fabedbb2d724637b539ba180c03ed8b68<br>
&gt; &gt;&gt; Author: Jimi Xenidis &lt;jimix@pobox.com&gt;<br>
&gt; &gt;&gt; Date: &nbsp; Wed Oct 31 16:33:21 2012 -0500<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;powerpc/book3e: IBM Blue Gene/Q Boot<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;This patch specifically deals with the initial program load<br>
&gt; &gt;&gt; &nbsp; &nbsp;environment so that a boot image (dtbImage.bgq) can be loaded by the<br>
&gt; &gt;&gt; &nbsp; &nbsp;BGQ management tools. &nbsp;The boot code is a little odd because it has to<br>
&gt; &gt;&gt; &nbsp; &nbsp;deal with the following issues:<br>
&gt; &gt;&gt; &nbsp; &nbsp; - Linux boot image wrappers are 32-bit programs<br>
&gt; &gt;&gt; &nbsp; &nbsp; - BGQ Tools only load 64bit ELF programs<br>
&gt; &gt;&gt; &nbsp; &nbsp; - BGQ Firmware information is typically loaded at an address &gt; 4G<br>
&gt; &gt;&gt; &nbsp; &nbsp; - BGQ FW information contains 64-bit ABI function pointers (which are<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; actually function descriptors) to access firmware methods<br>
&gt; &gt;&gt; &nbsp; &nbsp; - BGQ FW methods must be called in 64-bit mode<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;Includes code contributed from:<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp;Andrew Tauferner &lt;ataufer@us.ibm.com&gt;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp;Todd Inglett &lt;tinglett@us.ibm.com&gt;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp;Eric Van Hensbergen &lt;ericvh@gmail.com&gt;<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;Signed-off-by: Jimi Xenidis &lt;jimix@pobox.com&gt;<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; commit 3bc841935eb4955ce2b2db69bff16f7928464597<br>
&gt; &gt;&gt; Author: Jimi Xenidis &lt;jimix@pobox.com&gt;<br>
&gt; &gt;&gt; Date: &nbsp; Wed Oct 31 22:36:54 2012 -0500<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;powerpc/book3e: IBM Blue Gene/Q Platform and SMP<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;This patch introduces BGQ as a platform and adds SMP functionality<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;Includes code contributed from:<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp;Andrew Tauferner &lt;ataufer@us.ibm.com&gt;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp;Todd Inglett &lt;tinglett@us.ibm.com&gt;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp;Eric Van Hensbergen &lt;ericvh@gmail.com&gt;<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;Signed-off-by: Jimi Xenidis &lt;jimix@pobox.com&gt;<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; commit 279c0615917b959a652e81f4ad0d886e2d426d85<br>
&gt; &gt;&gt; Author: Jimi Xenidis &lt;jimix@pobox.com&gt;<br>
&gt; &gt;&gt; Date: &nbsp; Wed Dec 5 13:43:22 2012 -0500<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;powerpc/book3e: IBM Blue Gene/Q Quad Processing eXtention (QPX)<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;This enables kernel support for the QPX extention and is intended for<br>
&gt; &gt;&gt; &nbsp; &nbsp;processors that support it, usually an IBM Blue Gene processor.<br>
&gt; &gt;&gt; &nbsp; &nbsp;Turning it on does not effect other processors but it does add code<br>
&gt; &gt;&gt; &nbsp; &nbsp;and will quadruple the per thread save and restore area for the FPU<br>
&gt; &gt;&gt; &nbsp; &nbsp;(hense the name). &nbsp;If you have enabled VSX it will only double the<br>
&gt; &gt;&gt; &nbsp; &nbsp;space.<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;Signed-off-by: Jimi Xenidis &lt;jimix@pobox.com&gt;<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; commit 6ff45170ab0463fb34d7011e08c7e47c396f0fd7<br>
&gt; &gt;&gt; Author: Jimi Xenidis &lt;jimix@pobox.com&gt;<br>
&gt; &gt;&gt; Date: &nbsp; Fri Nov 23 14:52:14 2012 -0600<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;powerpc/book3e: IBM Blue Gene/Q HVC Based Firmware Console<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;New HVC device that uses the Blue Gene Firmware methods to erad and<br>
&gt; &gt;&gt; &nbsp; &nbsp;write to console.<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp;Includes code contributed from:<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Andrew Tauferner &lt;ataufer@us.ibm.com&gt;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Todd Inglett &lt;tinglett@us.ibm.com&gt;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Eric Van Hensbergen &lt;ericvh@gmail.com&gt;<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;Signed-off-by: Jimi Xenidis &lt;jimix@pobox.com&gt;<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; commit e4ddc0c2ad8b3f0260d15d73e153095e95da84ac<br>
&gt; &gt;&gt; Author: Jimi Xenidis &lt;jimix@pobox.com&gt;<br>
&gt; &gt;&gt; Date: &nbsp; Thu Nov 29 15:52:04 2012 -0500<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;powerpc/book3e: IBM Blue Gene/Q PCIe and MSI<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;The following patch adds support for the BG/Q PCIe bridge and <br>
&gt; MSI interrupts.<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;Includes code contributed from:<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp;Jay S. Bryant &lt;jsbryant@us.ibm.com&gt;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp;Eric Van Hensbergen &lt;ericvh@gmail.com&gt;<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;Signed-off-by: Jimi Xenidis &lt;jimix@pobox.com&gt;<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; commit 9fc0b6f729f7bd7e31338283640a718fa4b1693b<br>
&gt; &gt;&gt; Author: Jimi Xenidis &lt;jimix@pobox.com&gt;<br>
&gt; &gt;&gt; Date: &nbsp; Wed Dec 5 07:01:49 2012 -0500<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;powerpc/book3e: IBM Blue Gene/Q Character Drivers<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;The following patch adds support for user and administration<br>
&gt; &gt;&gt; &nbsp; &nbsp;applications to access the BG/Q control system.<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;Includes code contributed from:<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp;Jay S. Bryant &lt;jsbryant@us.ibm.com&gt;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp;Eric Van Hensbergen &lt;ericvh@gmail.com&gt;<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;Signed-off-by: Jimi Xenidis &lt;jimix@pobox.com&gt;<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; commit 9df2c4dfde0ac75f8b2bfcf565f78c2b7382b031<br>
&gt; &gt;&gt; Author: Jimi Xenidis &lt;jimix@pobox.com&gt;<br>
&gt; &gt;&gt; Date: &nbsp; Thu Dec 6 18:07:16 2012 -0500<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &nbsp; &nbsp;Linux 3.4.22-BGQ-rc1<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; _______________________________________________<br>
&gt; &gt;&gt; Linuxppc-dev mailing list<br>
&gt; &gt;&gt; Linuxppc-dev@lists.ozlabs.org<br>
&gt; &gt;&gt; <a href="https://lists.ozlabs.org/listinfo/linuxppc-dev">https://lists.ozlabs.org/listinfo/linuxppc-dev</a><br>
&gt; &gt;&gt; <br>
&gt; <br>
</font></tt></body></html>
--0__=09BBF05EDFDC90F28f9e8a93df938690918c09BBF05EDFDC90F2--
