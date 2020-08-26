Return-Path: <SRS0=u8mG=CE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02BAC433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Aug 2020 14:37:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 545832177B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Aug 2020 14:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 545832177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bc7kV0cswzDqKK
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2020 00:37:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=xiz0=ce=bugzilla.kernel.org=bugzilla-daemon@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=bugzilla.kernel.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bc7g00rl7zDqMk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2020 00:34:51 +1000 (AEST)
From: bugzilla-daemon@bugzilla.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Subject: =?UTF-8?B?W0J1ZyAyMDg5NTddIDUuOS1yYzEgZmFpbHMgdG8gYnVpbGQgZm9y?=
 =?UTF-8?B?IGEgUG93ZXJNYWMgRzU6IC4uLi9ib29rM3M2NC9oYXNoX3V0aWxzLmM6MTEx?=
 =?UTF-8?B?OToyMTogZXJyb3I6IOKAmGRlZmF1bHRfdWFtb3LigJkgdW5kZWNsYXJlZCAo?=
 =?UTF-8?B?Zmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pICAxMTE5IHwgICBtdHNwcihT?=
 =?UTF-8?B?UFJOX1VBTU9SLCBkZWZhdWx0X3VhbW9yKTs=?=
Date: Wed, 26 Aug 2020 14:34:49 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo platform_ppc-64@kernel-bugs.osdl.org
X-Bugzilla-Product: Platform Specific/Hardware
X-Bugzilla-Component: PPC-64
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: michael@ellerman.id.au
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: platform_ppc-64@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc resolution
Message-ID: <bug-208957-206035-VsGKTJNo8P@https.bugzilla.kernel.org/>
In-Reply-To: <bug-208957-206035@https.bugzilla.kernel.org/>
References: <bug-208957-206035@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D208957

Michael Ellerman (michael@ellerman.id.au) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |michael@ellerman.id.au
         Resolution|OBSOLETE                    |CODE_FIX

--- Comment #2 from Michael Ellerman (michael@ellerman.id.au) ---
Fixed in 1e4e4bcaf70e ("powerpc/pkeys: Fix build error with PPC_MEM_KEYS
disabled")

--=20
You are receiving this mail because:
You are watching the assignee of the bug.=
