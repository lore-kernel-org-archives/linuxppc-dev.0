Return-Path: <SRS0=hR0M=QY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3E5C43381
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Feb 2019 08:22:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E3932192D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Feb 2019 08:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3932192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 442Kjq0x9KzDqNF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Feb 2019 19:22:23 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 442Kh34ckYzDq5n
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Feb 2019 19:20:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 442Kh31Mqjz9sD4;
 Sun, 17 Feb 2019 19:20:51 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.0-5 tag
Date: Sun, 17 Feb 2019 19:20:50 +1100
Message-ID: <87k1hyddwd.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Linus,

Please pull one more powerpc fix for 5.0:

The following changes since commit 5a3840a470c41ec0b85cd36ca80370330656b163:

  powerpc/papr_scm: Use the correct bind address (2019-02-01 10:13:51 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.0-5

for you to fetch changes up to a58007621be33e9f7c7bed5d5ff8ecb914e1044a:

  powerpc/64s: Fix possible corruption on big endian due to pgd/pud_present() (2019-02-17 15:24:45 +1100)

- ------------------------------------------------------------------
powerpc fixes for 5.0 #5

Just one fix, for pgd/pud_present() which were broken on big endian since v4.20,
leading to possible data corruption.

Thanks to:
  Aneesh Kumar K.V., Erhard F., Jan Kara.

- ------------------------------------------------------------------
Michael Ellerman (1):
      powerpc/64s: Fix possible corruption on big endian due to pgd/pud_present()


 arch/powerpc/include/asm/book3s/64/pgtable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcaRiIAAoJEFHr6jzI4aWA6rYQAKQQGiQAWrbGlP65hMGjx++c
6YTsHnR88NpvWc0hGp9Pa8w/JCHBVWY1rlkrm/WfmerGb9y2vHR7HrwMVwA3Sw4Y
tTzYO4zUPtRghdcSQhLLKmkfxFtX6w/ZrLcBDwcQkhUhNKGxEptgIaJZFwJmdpfv
2eAbq+inaNwDK5IVjANOxniwUmRYCcj5HhmnBiK46zrQ5q6S/0Z77CvZri4OxrlX
ywyH9RjqTTqqfUe0abAt3C0/7SKjzjZeHOOGHeGb314+70zCYfT781IlCaII6d3J
sOP4WnXGXX4pKVuDqu6BzaRf/sJBppiyHe4+iWE4FGKFUT1AUU18wausYmIeJcE/
P4FzEMWk9dOJEOJ4/XKbvrpWmpOiUl9w1jY/PVNh1QWyrzk1NVr+jhhNTjgvX6lj
9SVrYuhl57Ops5nqv3b6we+WbnG9Irfy+LqopJUePyUrdq/OljrRGp21WiLF1GYI
fzYszqvv8+iES+F4sgocpgf0nt2M3YSu+f5HdHJ8Q2RwbeScZz24IVSV7N4/ko3e
aGG8PL8dhddu5jFxOWEKWesv5w4RaxPpnMqz+VolDoP21+p6nZvx2QsxtVwk0V/R
WXMV7iEMZpjJK+KvKN1dKDKVX+sf5XcMa2fbCZ2LiXEnj5esF3EL2YABuSUOapm3
i04uXRAf2lxI5mEXPxK7
=PcTT
-----END PGP SIGNATURE-----
