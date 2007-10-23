Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18205.30425.343811.555243@cargo.ozlabs.ibm.com>
Date: Tue, 23 Oct 2007 14:21:45 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Please pull powerpc.git merge branch
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please do

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get a commit that adds Vitaly Bordug as a maintainer for the
powerpc embedded 8xx processors.  This is something that Marcelo asked
me to push ages ago, but it kept falling through the cracks.

Thanks,
Paul.

 MAINTAINERS |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

Marcelo Tosatti (1):
      [POWERPC] Add Vitaly Bordug as PPC8xx maintainer
