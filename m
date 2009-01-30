Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 0D5B3DDFCD
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jan 2009 04:05:57 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so181845yxg.39
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 09:05:55 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 30 Jan 2009 10:05:54 -0700
Message-ID: <fa686aa40901300905h7ed39d59g334ee7a3074c42c6@mail.gmail.com>
Subject: Re: Please pull 'merge' branch of linux-2.6-mpc52xx.git
From: Grant Likely <grant.likely@secretlab.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hey Ben,

Updating my pull request; I've added one more patch as can been seen
in the diffstat.  The new one is a documentation-only change.

g.


The following changes since commit 18e352e4a73465349711a9324767e1b2453383e2:
  Linus Torvalds (1):
        Linux 2.6.29-rc3

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-mpc52xx merge

Grant Likely (3):
      powerpc/5200: update defconfigs
      powerpc/5200: Bugfix for PCI mapping of memory and IMMR
      powerpc/5200: update device tree binding documentation

 Documentation/powerpc/dts-bindings/fsl/mpc5200.txt |  180 +++++++++++++
 .../powerpc/mpc52xx-device-tree-bindings.txt       |  277 --------------------
 arch/powerpc/configs/52xx/cm5200_defconfig         |   83 +++++--
 arch/powerpc/configs/52xx/lite5200b_defconfig      |   86 +++++--
 arch/powerpc/configs/52xx/motionpro_defconfig      |   85 +++++--
 arch/powerpc/configs/52xx/pcm030_defconfig         |   82 ++++--
 arch/powerpc/configs/52xx/tqm5200_defconfig        |   89 +++++--
 arch/powerpc/configs/mpc5200_defconfig             |  104 ++++++--
 arch/powerpc/platforms/52xx/mpc52xx_pci.c          |   24 +-
 9 files changed, 576 insertions(+), 434 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/mpc5200.txt
 delete mode 100644 Documentation/powerpc/mpc52xx-device-tree-bindings.txt

On Thu, Jan 29, 2009 at 5:31 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> Ummm, I'm batting 1000 today.... Please pull the **MERGE** branch of
> linux-2.6-mpc52xx.git tree (The URL below was correct though).
>
> g.
>
> On Thu, Jan 29, 2009 at 5:29 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
>> Oops, forgot to CC the mailing list.
>>
>> g.
>>
>> On Thu, Jan 29, 2009 at 5:28 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
>>> Hi Ben,
>>>
>>> Here is the traditional defconfig update plus a bugfix for mpc5200
>>> PCI.  Please pull into 2.6.29.
>>>
>>> Thanks,
>>> g.
>>>
>>> The following changes since commit 18e352e4a73465349711a9324767e1b2453383e2:
>>>  Linus Torvalds (1):
>>>        Linux 2.6.29-rc3
>>>
>>> are available in the git repository at:
>>>
>>>  git://git.secretlab.ca/git/linux-2.6-mpc52xx merge
>>>
>>> Grant Likely (2):
>>>      powerpc/5200: update defconfigs
>>>      powerpc/5200: Bugfix for PCI mapping of memory and IMMR
>>>
>>>  arch/powerpc/configs/52xx/cm5200_defconfig    |   83 ++++++++++++++------
>>>  arch/powerpc/configs/52xx/lite5200b_defconfig |   86 +++++++++++++++-----
>>>  arch/powerpc/configs/52xx/motionpro_defconfig |   85 +++++++++++++++-----
>>>  arch/powerpc/configs/52xx/pcm030_defconfig    |   82 +++++++++++++------
>>>  arch/powerpc/configs/52xx/tqm5200_defconfig   |   89 +++++++++++++++------
>>>  arch/powerpc/configs/mpc5200_defconfig        |  104 ++++++++++++++++++-------
>>>  arch/powerpc/platforms/52xx/mpc52xx_pci.c     |   24 +++----
>>>  7 files changed, 396 insertions(+), 157 deletions(-)
>>>
>>>
>>> --
>>> Grant Likely, B.Sc., P.Eng.
>>> Secret Lab Technologies Ltd.
>>>
>>
>>
>>
>> --
>> Grant Likely, B.Sc., P.Eng.
>> Secret Lab Technologies Ltd.
>>
>
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
