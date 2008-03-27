Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18412.10455.702432.911134@cargo.ozlabs.ibm.com>
Date: Fri, 28 Mar 2008 10:08:07 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Please pull powerpc.git merge branch
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Olof Johansson has a defconfig update for the pasemi platform that he
would like to have in 2.6.25, so please do:

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

Thanks,
Paul.

 arch/powerpc/configs/pasemi_defconfig |  142 ++++++++++++++++++++-------------
 1 files changed, 88 insertions(+), 54 deletions(-)

commit 5c29934de29ddd7ecd913d83cad28e872f2e8c78
Author: Olof Johansson <olof@lixom.net>
Date:   Tue Mar 25 10:28:26 2008 -0500

    [POWERPC] update pasemi_defconfig
    
    Disable GEN_RTC since it conflicts with the i2c rtc drivers registering,
    besides that keep most of the new defaults.
    
    Signed-off-by: Olof Johansson <olof@lixom.net>
