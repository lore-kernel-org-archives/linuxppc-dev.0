Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 96D36DE17C
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 11:31:14 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so84443ywh.39
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jan 2009 16:31:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <fa686aa40901291629q37ca42a9j6c38a3fe26a9d979@mail.gmail.com>
References: <fa686aa40901291628k5b58e485n2eadb59d851e7b0e@mail.gmail.com>
	<fa686aa40901291629q37ca42a9j6c38a3fe26a9d979@mail.gmail.com>
Date: Thu, 29 Jan 2009 17:31:11 -0700
Message-ID: <fa686aa40901291631o1d0b9400t2e83952629d7bd5e@mail.gmail.com>
Subject: Re: Please pull 'next' branch of linux-2.6-mpc52xx.git
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

Ummm, I'm batting 1000 today.... Please pull the **MERGE** branch of
linux-2.6-mpc52xx.git tree (The URL below was correct though).

g.

On Thu, Jan 29, 2009 at 5:29 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> Oops, forgot to CC the mailing list.
>
> g.
>
> On Thu, Jan 29, 2009 at 5:28 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
>> Hi Ben,
>>
>> Here is the traditional defconfig update plus a bugfix for mpc5200
>> PCI.  Please pull into 2.6.29.
>>
>> Thanks,
>> g.
>>
>> The following changes since commit 18e352e4a73465349711a9324767e1b2453383e2:
>>  Linus Torvalds (1):
>>        Linux 2.6.29-rc3
>>
>> are available in the git repository at:
>>
>>  git://git.secretlab.ca/git/linux-2.6-mpc52xx merge
>>
>> Grant Likely (2):
>>      powerpc/5200: update defconfigs
>>      powerpc/5200: Bugfix for PCI mapping of memory and IMMR
>>
>>  arch/powerpc/configs/52xx/cm5200_defconfig    |   83 ++++++++++++++------
>>  arch/powerpc/configs/52xx/lite5200b_defconfig |   86 +++++++++++++++-----
>>  arch/powerpc/configs/52xx/motionpro_defconfig |   85 +++++++++++++++-----
>>  arch/powerpc/configs/52xx/pcm030_defconfig    |   82 +++++++++++++------
>>  arch/powerpc/configs/52xx/tqm5200_defconfig   |   89 +++++++++++++++------
>>  arch/powerpc/configs/mpc5200_defconfig        |  104 ++++++++++++++++++-------
>>  arch/powerpc/platforms/52xx/mpc52xx_pci.c     |   24 +++----
>>  7 files changed, 396 insertions(+), 157 deletions(-)
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
