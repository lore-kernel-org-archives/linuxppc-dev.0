Return-Path: <det.nicolas@free.fr>
From: Nicolas DET <det.nicolas@free.fr>
To: Sven Luther <sven.luther@wanadoo.fr>,
	Dale Farnsworth <dale@farnsworth.org>, Nicolas DET <det.nicolas@free.fr>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, linuxppc-embedded@ozlabs.org
Date: 09 Mar 2005 00:18:08 +0100
In-Reply-To: <20050308195239.GA14126@pegasos>
Message-Id: <20050308230859.9BE031C00088@mwinf0708.wanadoo.fr>
Subject: Re: final mv643xx_eth pegasos patch set ...
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Sven,

On 08/03/2005, you wrote:
> On Tue, Mar 08, 2005 at 08:28:05PM +0100, luther wrote:
>> Hello,
>> 
>> Ok, thanks for your help, here is the final (hopefully) and cleaned up
>> version of my patches :
>> 
>>   1) mv643xx-eth-pegasos.diff
>>   This is the arch/ppc/platform diff, benh, could you look it over, and
>> merge   it in ? It is not really usefull without the mv643xx_eth.c
>> changes, but dale   is going to move those in together with his patches.
>> 
>>   2) linux-2.5-mv643xx-enet-pegasos.diff
>>   This is just two small hunks against dale's linux-2.5-mv643xx-enet
>> tree,   which include the SA_INTERRUPT -> SA_IRQ and the Kconfig change.
>> Dale said   he would merge them with his stuff, hopefully for 2.6.12.
>> 
>>   3) mv643xx-eth.diff
>>   This is the linux-2.5-mv643xx-enet diff against 2.6.11, together with
>> the   linux-2.5-mv643xx-enet-pegasos.diff changes, for those who want to
>> build   against 2.6.11.
>> 
>> So to build against the linux-2.5-mv643xx-enet tree, you need 1) and 2)
>> and to build against 2.6.11 you need 1) and 3).
>> 

This patch is requiered to get the ethernet driver working.
http://powernico.free.fr/patch_2.6.11_mv64360_peg2

It only check deepers if we have a Marvell chipset.
this patch has been made against 2.6.11 from kernel.org and only touch:
arch/ppc/platform/Makefile
arch/ppc/mv643xx_eth_pegasos.c

Regards
-- 
Nicolas DET
MorphOS & Linux developer
