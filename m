Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [GIT PULL] Please pull spufs master branch
Message-Id: <1208403837.286854.46120525208.0.gpush@pingu>
To: Paul Mackerras <paulus@samba.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Thu, 17 Apr 2008 13:43:57 +1000
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

A few bugfixes for spufs.

Cheers,


Jeremy


--- 4 commits:

  [POWERPC] spufs: add newline to signal{1,2}_type files
    Jeremy Kerr <jk@ozlabs.org>

    arch/powerpc/platforms/cell/spufs/file.c           |    4 ++--
    1 file changed, 2 insertions(+), 2 deletions(-)
   
  [POWERPC] spufs: reacquire LS pointer in spu_process_callback
    Jeremy Kerr <jk@ozlabs.org>

    arch/powerpc/platforms/cell/spufs/run.c            |    4 ++++
    1 file changed, 4 insertions(+)
   
  [POWERPC] spufs: save MFC command channel before purging MFC queue
    Jeremy Kerr <jk@ozlabs.org>

    arch/powerpc/platforms/cell/spufs/switch.c         |    2 +-
    1 file changed, 1 insertion(+), 1 deletion(-)
   
  [POWERPC] spufs: fix incorrect file descriptors in SPU coredump note names
    Gerhard Stenzel <stenzel@de.ibm.com>

    arch/powerpc/platforms/cell/spufs/coredump.c       |    8 ++++++--
    1 file changed, 6 insertions(+), 2 deletions(-)
   
