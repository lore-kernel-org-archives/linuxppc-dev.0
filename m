Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0377DDDEDC
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 03:42:07 +1000 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1IivrG-00077n-O8
	for linuxppc-dev@ozlabs.org; Fri, 19 Oct 2007 12:42:03 -0500
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/4] DTC: Introduce better DTS literal support
Date: Fri, 19 Oct 2007 12:42:02 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IivrG-00077n-O8@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Folks,

This 4 part patch series for the DTC has:

    0001-Reformat-grammar-rules-to-not-mix-language-syntax-an.patch
    0002-Quiet-a-bogus-May-be-used-uninitialized-warning.patch
    0003-Appease-the-printf-format-Gods-with-a-correct-typ.patch
    0004-Begin-the-path-to-sane-literals-and-expressions.patch

The first is a pure whitespace formatting cleaning.
The second two clean compiler warnings.
The final one introduces a versioned DTS file with
    support for C-like literals.


 dtc-lexer.l      |  180 ++++++++++++++++++++++++++++--------
 dtc-parser.y     |  275 ++++++++++++++++++++++++++++++++++++++++--------------
 dtc.c            |   26 +++++
 dtc.h            |   23 ++++-
 flattree.c       |    2 +-
 srcpos.h         |    1 +
 tests/get_name.c |    2 +-
 treesource.c     |   24 ++++-
 8 files changed, 413 insertions(+), 120 deletions(-)


Thanks,
jdl
