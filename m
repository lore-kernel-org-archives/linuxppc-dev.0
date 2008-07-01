Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id BBD2ADDF77
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 08:04:40 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so18812anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 01 Jul 2008 15:04:38 -0700 (PDT)
Message-ID: <fa686aa40807011504i5e09e7f1r1f00bb7450b9a9d8@mail.gmail.com>
Date: Tue, 1 Jul 2008 16:04:37 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>,
	"Paul Mackerras" <paulus@samba.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, "John Linn" <John.Linn@xilinx.com>
Subject: Please pull into 2.6.26
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Josh & Paul,

Here are a couple of last minute bug fixes for 2.6.26.  These are both
Xilinx 4xx related.

Could either of you please pull the tree?

Thanks,
g.

The following changes since commit 1702b52092e9a6d05398d3f9581ddc050ef00d06:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../mchehab/v4l-dvb

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-virtex.git virtex-for-2.6.26

John Linn (2):
      powerpc/bootwrapper: update for initrd with simpleImage
      powerpc/legacy_serial: Bail if reg-offset/shift properties are present

 arch/powerpc/boot/Makefile          |    3 ++-
 arch/powerpc/kernel/legacy_serial.c |    5 +++++
 2 files changed, 7 insertions(+), 1 deletions(-)


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
