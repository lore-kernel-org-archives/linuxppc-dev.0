Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.236])
	by ozlabs.org (Postfix) with ESMTP id 08C26DE005
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 02:30:53 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so198393nzh
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 09:30:51 -0700 (PDT)
Message-ID: <fa686aa40710100930k65cc2b4i5acc836ae9ffb194@mail.gmail.com>
Date: Wed, 10 Oct 2007 10:30:50 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Paul Mackerras" <paulus@samba.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
	"Sylvain Munaut" <tnt@246tnt.com>
Subject: Please pull linux-2.6-mpc52xx.git
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paulus,

Sylvain has asked if I would like to help with the mpc52xx
maintainership.  If it's okay by you, here is a patch that adds me as
co-maintainer for the mpc52xx platform along with 3 other mpc52xx
related fixes.

Sylvain, can you please reply to this message confirming that this is
what we talked about?

Thanks,
g.

The following changes since commit dcccb37e98e0444b0c6a03b303855771aa463c96:
  Grant Likely (1):
        [POWERPC] Lite5200: Use comma delimiter format for lists in device tree

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-mpc52xx.git for-2.6.24

Grant Likely (4):
      [POWERPC] MPC52xx: Drop show_cpuinfo platform hooks from Lite5200
      [POWERPC] MPC52xx: Trim includes on mpc5200 platform support code
      [POWERPC] MPC5200: Don't make firmware fixups into common code
      [POWERPC] Add co-maintainer for PowerPC MPC52xx platform

 MAINTAINERS                                  |    2 +
 arch/powerpc/platforms/52xx/efika.c          |   19 +-----
 arch/powerpc/platforms/52xx/lite5200.c       |   95 ++++++++++++++------------
 arch/powerpc/platforms/52xx/mpc52xx_common.c |   38 ++++-------
 arch/powerpc/platforms/52xx/mpc52xx_pic.c    |   11 +---
 include/asm-powerpc/mpc52xx.h                |    2 +-
 6 files changed, 68 insertions(+), 99 deletions(-)

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
