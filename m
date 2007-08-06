Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <46B792B3.8020000@am.sony.com>
Date: Mon, 06 Aug 2007 14:29:23 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2] cell: move SPU affinity init to spu_management_of_ops
References: <200707252342.50244.adetsch@br.ibm.com> <46B3DC2A.408@am.sony.com>
	<200708040925.49098.arnd@arndb.de>
In-Reply-To: <200708040925.49098.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org, hch@lst.de,
	Arnd Bergmann <arnd@arndb.de>, Andre Detsch <adetsch@br.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Saturday 04 August 2007, Geoff Levand wrote:
>> 
>> From: Andre Detsch <adetsch@br.ibm.com>
>> 
>> This patch moves affinity initialization code from spu_base.c to a
>> new spu_management_of_ops function (init_affinity), which is empty
>> in the case of PS3. This fixes a linking problem that was happening
>> when compiling for PS3.
>> Also, some small code style changes were made.
>> 
>> Signed-off-by: Andre Detsch <adetsch@br.ibm.com>
>> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> 
> 
> Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Hi Paul,

As this one fixes a build breakage, I would like you to queue it
up for Linus to pull at the next opportunity.

-Geoff
