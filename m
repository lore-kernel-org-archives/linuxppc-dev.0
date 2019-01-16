Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242CCC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 00:37:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CFF620657
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 00:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CFF620657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fSw43lRYzDqQN
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 11:37:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmx.net
 (client-ip=212.227.17.21; helo=mout.gmx.net;
 envelope-from=j.neuschaefer@gmx.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=gmx.net
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fStP0PYyzDqPF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 11:35:56 +1100 (AEDT)
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MQvDO-1goOzU1N4Y-00UFes; Wed, 16
 Jan 2019 01:35:38 +0100
Date: Wed, 16 Jan 2019 01:35:35 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2 00/15] powerpc/32s: Use BATs/LTLBs for STRICT_KERNEL_RWX
Message-ID: <20190116003535.GE22334@latitude>
References: <cover.1547132681.git.christophe.leroy@c-s.fr>
 <20190113181621.GA22334@latitude>
 <714e78ba-1e92-a856-3dd6-a1fb96ad3785@c-s.fr>
 <20190113210227.GB22334@latitude>
 <334b1b02-b652-499c-904e-09e6f7164b8c@c-s.fr>
 <20190115003353.GD22334@latitude>
 <b37e3635-9c69-0cfc-1283-25459b394033@c-s.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qFgkTsE6LiHkLPZw"
Content-Disposition: inline
In-Reply-To: <b37e3635-9c69-0cfc-1283-25459b394033@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:VSgsAzQCc9gmuCtLlefW/FPnlUiah4/IVguTYpWJ7IVW1Wn74xd
 cmCwARS4/ZDA8pimUkFkUYX/L6QqaQzmsa7f3MYz4XaTb0T3v7rvl+uWI9TuzCMQEj3zxep
 j7+T7iE23Hkis+U/FFOF7dn4sZfsQDyjnozAa+zUW45r7G8X+57DwgqmF7sW2rA8RwDpXKz
 w4LFpQW/05hTkxU2QoxNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l15+fE2illc=:nyGVOtLXIWT4NFqLXV24Ls
 oi1niqvtEqEYEhlDYWddco+88xvasgpydV7lW+RtS4SsSijCWcETGETc6XP7E1mFl/FDFwdAq
 PhzZNVY5S+igefumiNvp3w4H2cV0t+QbVCeQKmRQKlacPsR43+1YIB8pMa17xZGzF6ZKIBtSI
 y9jy3gusuyOHn2gjc6CsIW8Umn0s0nqrElvzF61DXKshRG3NWj4EHZQXmHPwxHI/owjYHKyUy
 kZ3NgHg93kt7N4Wnw0GxiSL1R0J5ESNtmmouEqJhNUZ9nMq8YnnQsimn56Mb7+qXEvcwKKUQ+
 P3Ie1Kf/6m/n3LJh3QGRgDczi9Qaf7Y27MAcmtZ9fy3EMzbg3Ffe9IgS9WV2B5eUWOwqaiD6G
 Q/6GTsZ457ciSN0OELrLcOzU4mPrg1l1k0re7LyVk1zZ4InJZ5KF9jbuzV7bWl3/gx70J3+Jc
 uiij+AO881PVGNFp7hKbtIRw9Fnbjq9W6acYIqyoWqsxkWmwIX1TR4vLgyj/2PPeUxfLAunAy
 crQDEPYfbZKj9s6SoOY/JFnIpGqTVYy4/ARWrKkqYv5y9UQI4/6ooEHuMYKD6gzlnKAJWm7aR
 zRcKy31kEltN4/wFoSBrO+yS5O9XB19uhe6nea6sfyIz6Nkl2vejHAYMNZL0R++bByfXRTzen
 dlNJZZbqsR0E/RW7Ym5b6HJ0U0EdCkbyTKRqXgaS7oUbN9uhiKzZgic4Nk2N9szpnlejZPawf
 hcFmJzMb+yYRxz5LmeqsswyOsvIQy3e68wSlEqprSg7ZLMuo4TW5Mx6NJO9+gsaobbRmJXRf3
 ZiuC5Jn2BfHUwgmZHX3ZZC0E961m2YzzSd6gmCxFDY53YZ0PBprxGvSf7fKMgQNVZCYZe9WiW
 03KFlNia73DNSX35pS3lwOdlZgQuTECmkNHqjIlfyxUtLQWTlNFLHQj/+UhZsx
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--qFgkTsE6LiHkLPZw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2019 at 07:51:01AM +0100, Christophe Leroy wrote:
> Le 15/01/2019 =C3=A0 01:33, Jonathan Neusch=C3=A4fer a =C3=A9crit=C2=A0:
[...]
> > I've checked it patch-by-patch now (with STRICT_KERNEL_RWX):
> >=20
> > - patches 1 and 2 build and boot fine
> > - patches 3 to 6 build, but fail to boot with this error:
>=20
> The bug is in patch 2, mmu_mapin_ram() should return base instead of
> returning 0 when __map_without_bats is set.

Indeed, with this change, I can boot up to patch 11.

> > - patches 12 to 15 build but fail to boot with this error:
>=20
> Thats the one we need to really understand.
>=20
> Do you have modules ? If so, can you try without ?

I don't use any modules in my test setup, but I have module support
enabled. Disabling CONFIG_MODULES makes no difference, as far as I can
see (I get the same backtrace with memblock_alloc_base+0x34/0x44).

> > 	[    0.000000] [c0f1ff30] [c00280f0] panic+0x144/0x324 (unreliable)
> > 	[    0.000000] [c0f1ff90] [c0c18a34] memblock_alloc_base+0x34/0x44
> > 	[    0.000000] [c0f1ffa0] [c0c071e0] MMU_init_hw+0xcc/0x300
> > 	[    0.000000] [c0f1ffd0] [c0c06554] MMU_init+0x12c/0x198
> > 	[    0.000000] [c0f1fff0] [c0003418] start_here+0x40/0x78

With a few printks[1], I traced this error, and got the following
result:

[    0.000000] __memblock_find_range_top_down(1000:1800000, 100000:100000, =
ffffffff, 0)
[    0.000000] __memblock_find_range_top_down: in loop, 10000000:13f00000
[    0.000000] __memblock_find_range_top_down: in loop, 179962d:1800000
[    0.000000] __memblock_find_range_top_down: in loop, 1676000:17987a0
[    0.000000] __memblock_find_range_top_down: nothing found :(

The limit of 0x1800000 comes from setup_initial_memory_limit, which only
considers the first memblock, but the second memblock starts at 256MiB,
so it wouldn't be usable anyway, according to the comment in
setup_initial_memory_limit.

Thinning the kernel down a bit actually makes it boot again. Ooops...!
Maybe enabling CONFIG_STRICT_KERNEL_RWX has made it just large enough to
fail the hash table allocation, but there may have been other factors
involved (I'm not sure exactly).  Sorry for the confusion!


Jonathan

[1]:
diff --git a/mm/memblock.c b/mm/memblock.c
index 022d4cbb3618..66d588e08487 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -215,8 +215,11 @@ __memblock_find_range_top_down(phys_addr_t start, phys=
_addr_t end,
 	phys_addr_t this_start, this_end, cand;
 	u64 i;
=20
+	printk("%s(%x:%x, %x:%x, %x, %x)\n", __func__, start, end, size, align, n=
id, flags);
+
 	for_each_free_mem_range_reverse(i, nid, flags, &this_start, &this_end,
 					NULL) {
+		printk("%s: in loop, %x:%x\n", __func__, this_start, this_end);
 		this_start =3D clamp(this_start, start, end);
 		this_end =3D clamp(this_end, start, end);
=20
@@ -228,6 +231,7 @@ __memblock_find_range_top_down(phys_addr_t start, phys_=
addr_t end,
 			return cand;
 	}
=20
+	printk("%s: nothing found :(\n", __func__);
 	return 0;
 }
=20

--qFgkTsE6LiHkLPZw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlw+fE8ACgkQCDBEmo7z
X9sj1xAApd7XmkKA6yw+nslWus1bdPEyDtHwpeUR/UUCt5LeCMlsinl7iM+WAPpp
VlDbEdmx3ysIMNj2fq8b6ixGkgevzQFnSmxEj39DOpPnbX2/TowIVyJjVdjru/N8
rIDiARcOs3QhwsTkFsI2nYWF1cHCz9EskoUT5mqynX2q5MfRE6Y36Yz9PIkA6Mu6
rRbE71wAwWPveXgTdlPdZx64LZZdbZ/8lLXCYgFwrS2nKAldrHDAuTCIs5EUcDie
ST6e3ePQUJ5Hksq50CTb4rHHD0LC28mM10XEMLxG5eppOGP0NyVMjKPWmF3535gZ
ROVJcPlT8lpv36EMKL4lft4AQwX80Zc+z5Y4E4xqghaa3xiJcqfM9IFvFJtZ1vQP
piXCYlyNu553V2oXDhYq8/TCRfjVnNODugP0SkyAnS+cal/wg/HjwZuG+CaK/IK0
jjaH5JRZJ8e7K/yuz+jPcanskpJkO5+Dtezry0OYBy+GXeWPo65as/Vi9PVflo7A
nmWK+E3vF1lZ86lYuKp4PW65oT/m1+R8CtFGh0wdh60yu6V0Z/SG0SduU8SdN7iA
YnP/wzIDTDy1EKFeLKd2U3ZEOpDIcA9EPK1jOniB/Ov3gl00EnVoAgz6jZfTHTKU
ZsHTWlBmFihGThto2nLt5D7b97JYnbPGzspfRrYHbBJH4wrD7eQ=
=vJhG
-----END PGP SIGNATURE-----

--qFgkTsE6LiHkLPZw--
