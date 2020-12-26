Return-Path: <SRS0=+96s=F6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884CDC433DB
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Dec 2020 18:04:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2EE82082D
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Dec 2020 18:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2EE82082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D3BXY3hRwzDqGP
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Dec 2020 05:04:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=bugzilla.kernel.org (client-ip=198.145.29.99;
 helo=mail.kernel.org; envelope-from=bugzilla-daemon@bugzilla.kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=bugzilla.kernel.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D3BVp5K49zDq9S
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Dec 2020 05:02:58 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPS id 940F72082D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Dec 2020 18:02:54 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Subject: [Bug 210911] New: error: implicit declaration of function
 'cleanup_cpu_mmu_context' [-Werror=implicit-function-declaration]
Date: Sat, 26 Dec 2020 18:02:54 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo platform_ppc-32@kernel-bugs.osdl.org
X-Bugzilla-Product: Platform Specific/Hardware
X-Bugzilla-Component: PPC-32
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jason@bluehome.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: platform_ppc-32@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-210911-206035@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

https://bugzilla.kernel.org/show_bug.cgi?id=3D210911

            Bug ID: 210911
           Summary: error: implicit declaration of function
                    'cleanup_cpu_mmu_context'
                    [-Werror=3Dimplicit-function-declaration]
           Product: Platform Specific/Hardware
           Version: 2.5
    Kernel Version: 5.10.3
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: PPC-32
          Assignee: platform_ppc-32@kernel-bugs.osdl.org
          Reporter: jason@bluehome.net
        Regression: No

Created attachment 294347
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D294347&action=3Dedit
Kernel config file

This began to appear starting with 5.10 and continues with 5.10.3. I had no
problems with the 5.9 series. I am building it with GCC 10.2. I have also t=
ried
going back to 9.3 but that makes no difference.

arch/powerpc/platforms/powermac/smp.c: In function 'smp_core99_cpu_disable':
arch/powerpc/platforms/powermac/smp.c:914:2: error: implicit declaration of
function 'cleanup_cpu_mmu_context' [-Werror=3Dimplicit-function-declaration]
  914 |  cleanup_cpu_mmu_context();
      |  ^~~~~~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors
scripts/Makefile.build:279: recipe for target
'arch/powerpc/platforms/powermac/smp.o' failed
make[3]: *** [arch/powerpc/platforms/powermac/smp.o] Error 1
scripts/Makefile.build:496: recipe for target 'arch/powerpc/platforms/power=
mac'
failed
make[2]: *** [arch/powerpc/platforms/powermac] Error 2
scripts/Makefile.build:496: recipe for target 'arch/powerpc/platforms' fail=
ed
make[1]: *** [arch/powerpc/platforms] Error 2
Makefile:1805: recipe for target 'arch/powerpc' failed
make: *** [arch/powerpc] Error 2

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
