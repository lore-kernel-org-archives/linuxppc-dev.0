Message-ID: <3BE3A8A7.3070607@elsoft.ch>
Date: Sat, 03 Nov 2001 09:19:51 +0100
From: "David =?ISO-8859-1?Q?M=FCller?= (ELSOFT AG)" <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] Various patches against linuxppc_dev-2.4.14-pre7
References: <3BE2C0A5.7080707@elsoft.ch> <20011102092032.F26147@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: multipart/mixed;
 boundary="------------080702090805020103060508"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------080702090805020103060508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Tom Rini wrote:

> On Fri, Nov 02, 2001 at 04:49:57PM +0100, David M?ller (ELSOFT AG) wrote:
>
>
>>  - include/asm-ppc/ibm4xx.h
>>     missing include file  (I'm not sure if this is the correct fix)
>>
>>  - drivers/net/ppc405_enet.h
>>     missing include file  (ditto)
>>
>
> What's broken right now?  <asm/ibm405gp.h> gets included by CONFIG_FOO,
> if FOO is a 405GP board.


Sorry, my fault. I was a little bit too fast. ;-)


>
>
>
>>  - arch/ppc/kernel/ppc4xx_setup.c
>>     added call to board_setup_irq() in ppc4xx_init_IRQ()
>>     added call to board_setup_rtc_access() in platform_init()
>>
>>  - arch/ppc/kernel/walnut.c
>>  - arch/ppc/kernel/redwood.c
>>  - arch/ppc/kernel/cpci405.c
>>  - arch/ppc/kernel/ep405.c
>>     added necessary board_setup_irq() and
>>     board_setup_rtc_access() functions
>>
>
> Shouldn't board_setup_rtc_access() do all of the RTC stuff, not just
> changing the nvram bits?  If your board needs a different way to get
> nvram access, we should rename board_setup_rtc_access() to
> board_setup_nvram_access()
>
>

See attached patch


Dave

--------------080702090805020103060508
Content-Type: application/octet-stream;
 name="nvram_access.patch.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="nvram_access.patch.bz2"

QlpoOTFBWSZTWVEqax4AAg5fgDAwWn///3/v/76/7//aUARZ7Ftbjc4AABKFKeaUzRNBoeUa
aaMno1BoAaNAAabRMQDTSJp5JT1NGQ00NAAAAAAAAAASmilPEnqYJoGho9QAADQAAAABocZG
mTE0GTJhNMgZDQGgNMmhgBNAYRSJoAmgmTENKMQaMh6QxBoAB6jR6mnqXBiyVa85MJCiHgg6
Bh2chnQOEggdqbJY65pDVlkpJEJF5cLuRjPRA83yqCpJeSq1qk1+XwShhEL0JgBMrsXACdgQ
3xnBsSy9iyl5OHaohmEVC0ZPbKuOWSzLcYZ+QC1lKVyxpWNpRRVVdoiQm1YRlmUme0XiwmWJ
DERn2ITkEiEkVCjEMbxdp5qCCpT3iJApX5WqSD4XITknslYmoPIOQezxxRNBzq46yP9MiqrX
YTRx8Qb+s3ywuWh4zkvhz0/3V0yKgoH+OojEtMxvrddP2IjSahq7MwpmYyYYhgQwF3vUrd2r
NHMrKMy27rb+dRQ4BBUKQG4LWfEK9WtA8MzQ7jwj4QNotOUisFmdS6Ys5ilh4SStFbBcHPKJ
ITDsA2jVRKqCRLIymJ5IWu2ciHdMq6isdgSnMSCBmBaAJJSQkGSCBgzkqHdw7idIuC3jkgsz
3r2kSpUgqVpXEIYyYlhYFIBFChjXFdqlqKLBlOpVuCCB4mqoX0LMJgmWm+5aNnJUC6baBCCZ
P92PK3sDCbFTDODCYzGLZdAIAgDi+DCks70BhTyPP1MS4PnCcLvU8D5wGRI1gDjLxDozoqI2
eMjkiq1DWc+j+JqiEMKYweDWcl5zZzr79C3/Fkmjgp1tmFJsyaHsH0n53Hf5D8M1OZCco6W0
dNzQWY3XF6fIhSYWoySEuSAhIolExMB+vssE7QS572oA82FhgFx+KaRD3EtNHcdRptgZeYJS
kEuzmJND1KzdwMfrqUlMWWARSuztX07lzWq4d5Xrag2EVHwsCUpJNCNpCs3aLUndvrALBLrF
dB/BGbAlwkobzV0SJapGwggTETWUJCTExEkzLk0Hc8eYssKZ3ByS/Je3eRnJQuvOJzuwwkY+
uR03GwOjnwnmsoqvPCFXjzrJwx7Jd5uNJdxOkF53oLSg0DwagdmiJOJcJIZ6waCVCcLw6E5C
aeCSEw69uN9BuK5AGQhwN05BK80B3lJRNiSUUMmweAnMVBeIUdm5ojke0C+J4eUc+RiQyYF4
iPrLnT1kFQcU3G+RIkLuCu83LrvmRt1gEFiDiJmJiY6jLz57BMg1wly3h01GhNa1768iECsk
1LFqGpjSnVKt4kqJYEJftC0oCe+F19tMAxipWoE4hu4gkBa7xsBMLfABAclawCScSOTYJmuQ
fsveVl4EEQwv/i7kinChIKJU1jw=
--------------080702090805020103060508--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
