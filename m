Return-Path: <bones@bonesio.net>
Message-ID: <4CE37663.2080806@bonesio.net>
Date: Tue, 16 Nov 2010 22:29:55 -0800
From: John Bonesio <bones@bonesio.net>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/5] scripts: dtc: Merge in changes from the dtc repository
References: <20101116204917.12146.39851.stgit@riker>	<20101116204951.12146.21084.stgit@riker>
	<AANLkTinYZYR_QtS5-Nodpaf2MBBuaw06SW9pDCNQ9ov3@mail.gmail.com>
In-Reply-To: <AANLkTinYZYR_QtS5-Nodpaf2MBBuaw06SW9pDCNQ9ov3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: jdl@jdl.com, devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, John Bonesio <bones@secretlab.ca>,
	linuxppc-dev@lists.ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Arg!

I had this working. I'll look into it.

- John

On 11/16/2010 10:11 PM, Grant Likely wrote:
> On Tue, Nov 16, 2010 at 1:49 PM, John Bonesio <bones@secretlab.ca> wrote:
>> Pull in recent changes from the main dtc repository. These changes primarily
>> allow multiple device trees to be declared which are merged by dtc. This
>> feature allows us to include a basic dts file and then provide more information
>> for the specific system through the merging functionality.
>>
>> Signed-off-by: John Bonesio <bones@secretlab.ca>
>> ---
>>
>>  0 files changed, 0 insertions(+), 0 deletions(-)
> ???  Something isn't right in patch generation.
>
> Also:
>
> ~/hacking/linux-2.6$ xc-6xx make -j3
>   GEN     /home/grant/hacking/linux-2.6.build/6xx/Makefile
>   HOSTCC  scripts/kconfig/zconf.tab.o
>   HOSTLD  scripts/kconfig/conf
> scripts/kconfig/conf --silentoldconfig Kconfig
> #
> # configuration written to .config
> #
>   GEN     /home/grant/hacking/linux-2.6.build/6xx/Makefile
>   CHK     include/linux/version.h
>   UPD     include/linux/version.h
>   HOSTCC  scripts/dtc/checks.o
> In file included from /home/grant/hacking/linux-2.6/scripts/dtc/checks.c:21:
> /home/grant/hacking/linux-2.6/scripts/dtc/dtc.h:37: fatal error:
> util.h: No such file or directory
> compilation terminated.
> make[3]: *** [scripts/dtc/checks.o] Error 1
> make[2]: *** [scripts/dtc] Error 2
> make[1]: *** [scripts] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [sub-make] Error 2
> (devicetree/test) ~/hacking/linux-2.6$
>
> Looks like the updated dtc is broken.
>
> g.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
