Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id BE1DDB7C07
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  6 Dec 2009 23:16:13 +1100 (EST)
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To: David Airlie <airlied@linux.ie>
Subject: [RESEND][PATCH 0/2] Uninorth AGP fix / cleanup
Date: Sun,  6 Dec 2009 13:15:54 +0100
Message-Id: <1260101756-22645-1-git-send-email-michel@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Looks like these got lost somewhere last time, so trying again...

These patches should allow KMS environments to work with U3 AGP bridges as
well.

[PATCH 1/2] agp/uninorth: Also handle user memory types in u3_remove_memory().
[PATCH 2/2] agp/uninorth: Unify U3 and pre-U3 insert_memory and remove_memory hooks.
