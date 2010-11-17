Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20101116204951.12146.21084.stgit@riker>
References: <20101116204917.12146.39851.stgit@riker>
	<20101116204951.12146.21084.stgit@riker>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 16 Nov 2010 23:11:27 -0700
Message-ID: <AANLkTinYZYR_QtS5-Nodpaf2MBBuaw06SW9pDCNQ9ov3@mail.gmail.com>
Subject: Re: [PATCH 1/5] scripts: dtc: Merge in changes from the dtc repository
To: John Bonesio <bones@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss@lists.ozlabs.org, jdl@jdl.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 16, 2010 at 1:49 PM, John Bonesio <bones@secretlab.ca> wrote:
> Pull in recent changes from the main dtc repository. These changes primar=
ily
> allow multiple device trees to be declared which are merged by dtc. This
> feature allows us to include a basic dts file and then provide more infor=
mation
> for the specific system through the merging functionality.
>
> Signed-off-by: John Bonesio <bones@secretlab.ca>
> ---
>
> =A00 files changed, 0 insertions(+), 0 deletions(-)

???  Something isn't right in patch generation.

Also:

~/hacking/linux-2.6$ xc-6xx make -j3
  GEN     /home/grant/hacking/linux-2.6.build/6xx/Makefile
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf --silentoldconfig Kconfig
#
# configuration written to .config
#
  GEN     /home/grant/hacking/linux-2.6.build/6xx/Makefile
  CHK     include/linux/version.h
  UPD     include/linux/version.h
  HOSTCC  scripts/dtc/checks.o
In file included from /home/grant/hacking/linux-2.6/scripts/dtc/checks.c:21=
:
/home/grant/hacking/linux-2.6/scripts/dtc/dtc.h:37: fatal error:
util.h: No such file or directory
compilation terminated.
make[3]: *** [scripts/dtc/checks.o] Error 1
make[2]: *** [scripts/dtc] Error 2
make[1]: *** [scripts] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [sub-make] Error 2
(devicetree/test) ~/hacking/linux-2.6$

Looks like the updated dtc is broken.

g.
