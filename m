Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) by ozlabs.org (Postfix) with ESMTP id 55F11B6F01
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  7 Aug 2010 13:55:35 +1000 (EST)
Received: by gya1 with SMTP id 1so3362250gya.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 06 Aug 2010 20:55:33 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 6 Aug 2010 21:55:13 -0600
Message-ID: <AANLkTikmNMRacefpzWfETsCDDwn4AB4HA89Dwehuxhab@mail.gmail.com>
Subject: [git pull] powerpc allmodconfig build fix and missed 5200 audio
	drivers (Was: [PATCH] powerpc: fix i8042 module build error)
To: Stephen Rothwell <sfr@canb.auug.org.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: martyn.welch@ge.com, linuxppc-dev@lists.ozlabs.org,
	Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,  Here's the promised pull request:

Let me know if this is okay, or if you would like to respin it.

The 2 mpc5200 patches are in here (and not in my previous request)
because of a breakdown in coordination between me and the ASoC folks.
Turns out the (potentially) conflicting patches weren't ready for
2.6.36, so Mark asked me to pick them back up[1].  It also has the
powerpc allmodconfig build failure fix.

[1]http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg45616.html

Cheers,
g.

The following changes since commit 17879857821adad4e180c5d6457c3b8bbf1d0c0c=
:
  Linus Torvalds (1):
        Merge branch 'irq-core-for-linus' of
git://git.kernel.org/.../tip/linux-2.6-tip

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 next

Eric Millbrandt (2):
      powerpc/5200: add mpc5200_psc_ac97_gpio_reset
      sound/soc: mpc5200_psc_ac97: Use gpio pins for cold reset

Grant Likely (1):
      powerpc: fix i8042 module build error

 arch/powerpc/include/asm/mpc52xx.h           |    1 +
 arch/powerpc/include/asm/mpc52xx_psc.h       |    1 +
 arch/powerpc/kernel/setup-common.c           |    2 +
 arch/powerpc/platforms/52xx/mpc52xx_common.c |  106 ++++++++++++++++++++++=
++++
 sound/soc/fsl/mpc5200_psc_ac97.c             |   22 +++++-
 5 files changed, 128 insertions(+), 4 deletions(-)

On Fri, Aug 6, 2010 at 8:54 PM, Grant Likely <grant.likely@secretlab.ca> wr=
ote:
> On Fri, Aug 6, 2010 at 6:01 PM, Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>> Hi Grant,
>>
>> On Fri, 06 Aug 2010 12:42:12 -0600 Grant Likely <grant.likely@secretlab.=
ca> wrote:
>>>
>>> of_i8042_{kbd,aux}_irq needs to be exported
>>>
>>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>>> ---
>>>
>>> Stephen and Ben, this fixes up the build error in linux-next. =A0If you=
 prefer,
>>> I can stuff this patch into my next-powerpc branch. =A0Ben, I've got ot=
her
>>> commits in that branch that I'll be sending to you early next week anyw=
ay.
>>
>> This failure also exists in Linus' tree, so the earlier this goes to
>> Linus the better.
>
> Okay then. =A0Ben, I'll send out my pull request out right away so
> you've got it if you want to use it.
>
> Cheers,
> g.
>> --
>> Cheers,
>> Stephen Rothwell =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sfr@canb.auug.or=
g.au
>> http://www.canb.auug.org.au/~sfr/
>>
>
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
