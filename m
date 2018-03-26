Return-Path: <shea@shealevy.com>
Received: from smtprelay.hostedemail.com (smtprelay0092.hostedemail.com
 [216.40.44.92])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 408bL50RC0zF1xw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 11:55:55 +1100 (AEDT)
From: Shea Levy <shea@shealevy.com>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
 uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@lists.linux-m68k.org,
 nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
 user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 02/16] riscv: Use INITRAMFS_GENERIC_UNLOAD.
In-Reply-To: <mhng-5691a509-dedf-4092-bd6d-020a81512c15@palmer-si-x1c4>
References: <mhng-5691a509-dedf-4092-bd6d-020a81512c15@palmer-si-x1c4>
Date: Sun, 25 Mar 2018 20:55:48 -0400
Message-ID: <87o9jbu02z.fsf@xps13.shealevy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Palmer,

Palmer Dabbelt <palmer@sifive.com> writes:

> On Sun, 25 Mar 2018 15:18:39 PDT (-0700), shea@shealevy.com wrote:
>> Signed-off-by: Shea Levy <shea@shealevy.com>
>> ---
>>  arch/riscv/Kconfig   | 1 +
>>  arch/riscv/mm/init.c | 6 ------
>>  2 files changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index c22ebe08e902..ab1b4cee84fc 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -37,6 +37,7 @@ config RISCV
>>  	select THREAD_INFO_IN_TASK
>>  	select RISCV_TIMER
>>  	select GENERIC_IRQ_MULTI_HANDLER
>> +	select INITRAMFS_GENERIC_UNLOAD
>>
>>  config MMU
>>  	def_bool y
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index c77df8142be2..36f83fe8a726 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -62,9 +62,3 @@ void free_initmem(void)
>>  {
>>  	free_initmem_default(0);
>>  }
>> -
>> -#ifdef CONFIG_BLK_DEV_INITRD
>> -void free_initrd_mem(unsigned long start, unsigned long end)
>> -{
>> -}
>> -#endif /* CONFIG_BLK_DEV_INITRD */
>
> I haven't looked through the rest of the patch set, but this is a pretty=
=20
> trivial change so feel free to add a=20
>
> Reviewed-By: Palmer Dabbelt <palmer@sifive.com>
>
> if you'd like.  If you'd like it merged through my tree then just say=20
> something!

I'm not sure how these cross-cutting changes go, if you can take the
series through your tree that'd be great!

Thanks,
Shea

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6ESKvwKkwnxgMLnaXAvWlX2G/icFAlq4RRQACgkQXAvWlX2G
/idVvw//eVifwGjCVA7W+miXNnrCgZRDqcXBSsy5+RJM0TcRiPp6DHk/yebLED8j
i3/bd9OxMb6FyO2no4XZMZcsCrBPyeXZkwlbU0qhhc4DI/cNicmOUZro8Aj22Zmh
MFmOPbShBJG95BW7OfbCbVwAMxJXzGqzVoIHFE6xN4ZkOYvFytX9R/rruZJORHgO
3+sZBR2g2QG6y7KdXz3yoaRg00neNL8u6kOnDifPDBLBKo/8GI4J1nuycLGt4U3x
/adDOQx6/jTpC22B8AnC1cLS1O9ws/k3aDLgtpaLyPoFvyMp6WbAoSJYZZlVKXE6
/iqreLOaLVy67NPtldqJbcIgOCCZcOKuEhwlMtXNFQXBcC5FOmtI+Ske9MBKJsxJ
dzbS8JTliRn858IJR52cTSo+jaeM7dTqwjYw2lpl8CZsdVOxwyh6ytIAP3h8LYBJ
IyJrSbeDLkfWnQRcyTQBfR2ZHeTb2CDw40+VPMYm8EpRyQoI1oUkwKuPhaiUpcRz
OSJpw7bHo3Nnj+V7PR4+7avRIpZSMoPtPHUcWxKkQURS/3HyMsE49Vzz6Ozz91jK
GVb3D2dM/QDTDA5qY3r9bzJcgbmnKKdaqT9ybKyhjhs3AZJ1HjFhPhBqFgjcOSL/
VXjOvwvokD+HXOJOHW/CAOnF85kFwysKxYUBoj38xxrx4rjT1W8=
=L1b7
-----END PGP SIGNATURE-----
--=-=-=--
