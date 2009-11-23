Return-Path: <michal.simek@petalogix.com>
Message-ID: <4B0A8DB1.9050501@petalogix.com>
Date: Mon, 23 Nov 2009 14:27:13 +0100
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
To: microblaze-uclinux@itee.uq.edu.au
Subject: Re: [microblaze-uclinux] Re: [PATCH 0/4 v2] Merge OF dynamic patches
References: <4B06AF33.1000400@austin.ibm.com>
	<fa686aa40911201340i77bc4098ud866d103acaefd30@mail.gmail.com>
In-Reply-To: <fa686aa40911201340i77bc4098ud866d103acaefd30@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
Reply-To: michal.simek@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Fri, Nov 20, 2009 at 8:01 AM, Nathan Fontenot <nfont@austin.ibm.com> wrote:
>> This set of patches merges the common dynamic device tree
>> updating routines of_attach_node() and of_detach_node() to
>> drivers/of/of_dynamic.c.
>>
>> Built and tested on powerpc, I have no access to build/test
>> this on microblaze.
> 
> Heh.  Actually, I've got a patch in my tree that does the same thing
> (except to a different location).  I could pick up your version and
> drop mine, but you need to rework it to be bi-sectable.  As the series
> exists right now, the build will fail if only part of the series is
> applied.  This change is simple enough that you can do the whole thing
> in a single patch.  Or, fix the Kconfig and include stuff in the first
> patch with the merge of of_attach_node, and then move of_detach_node
> in the second.
> 
> But I'm really close to posting my 3rd series, so it may be better to
> wait until that is published and build a patch on top of that to move
> them into of_dynamic.c

ACK.
Michal

> 
> Cheers,
> g.
> 
>> ---
>>
>> 1/4 - Merge of_attach_node
>> 2/4 - Merge of_detach_node
>> 3/4 - Makefile/Kconfig updates
>> 4/4 - Update powerpc/pseries to include of_dynamic.h
>>
>> arch/microblaze/Kconfig                   |    1
>> arch/microblaze/include/asm/prom.h        |    4 -
>> arch/microblaze/kernel/prom.c             |   59 -----------------------
>> arch/powerpc/Kconfig                      |    1
>> arch/powerpc/include/asm/prom.h           |    4 -
>> arch/powerpc/kernel/prom.c                |   59 -----------------------
>> arch/powerpc/platforms/pseries/reconfig.c |    1 drivers/of/Kconfig
>>                |    4 +
>> drivers/of/Makefile                       |    1 drivers/of/of_dynamic.c
>>               |   75 ++++++++++++++++++++++++++++++
>> include/linux/of_dynamic.h                |   27 ++++++++++
>> 11 files changed, 110 insertions(+), 126 deletions(-)
>>
> 
> 
> 


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663
