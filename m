Return-Path: <B29397@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B75A52C007A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Aug 2013 00:08:26 +1000 (EST)
From: Chen Peter-B29397 <B29397@freescale.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Kernel Development
 <linux-kernel@vger.kernel.org>
Subject: RE: Build regressions/improvements in v3.11-rc3
Date: Wed, 31 Jul 2013 14:08:17 +0000
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803F691A5@039-SN2MPN1-021.039d.mgd.msft.net>
References: <alpine.DEB.2.02.1307301048280.23035@ayla.of.borg>,
 <alpine.DEB.2.02.1307301049230.23054@ayla.of.borg>
In-Reply-To: <alpine.DEB.2.02.1307301049230.23054@ayla.of.borg>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 Linux/PPC Development <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

My patches "usb: chipidea: fix the build error with randconfig" fixes chipi=
dea problem.=0A=
It has already at USB fixes for 3.11-rc4.=0A=
=0A=
On Tue, 30 Jul 2013, Geert Uytterhoeven wrote:=0A=
> JFYI, when comparing v3.11-rc3 to v3.11-rc2[3], the summaries are:=0A=
>   - build errors: +38/-14=0A=
=0A=
  + arch/powerpc/kvm/book3s_emulate.c: error: 'bat' may be used uninitializ=
ed in this function [-Werror=3Duninitialized]:  =3D> 349:2=0A=
  + arch/powerpc/kvm/book3s_pr_papr.c: error: 'H_ANDCOND' undeclared (first=
 use in this function):  =3D> 161:17, 86:16=0A=
  + arch/powerpc/kvm/book3s_pr_papr.c: error: 'H_AVPN' undeclared (first us=
e in this function):  =3D> 160:17, 85:16, 192:16=0A=
  + arch/powerpc/kvm/book3s_pr_papr.c: error: 'H_BULK_REMOVE' undeclared (f=
irst use in this function):  =3D> 246:7=0A=
  + arch/powerpc/kvm/book3s_pr_papr.c: error: 'H_CEDE' undeclared (first us=
e in this function):  =3D> 250:7=0A=
  + arch/powerpc/kvm/book3s_pr_papr.c: error: 'H_CPPR' undeclared (first us=
e in this function):  =3D> 257:7=0A=
  + arch/powerpc/kvm/book3s_pr_papr.c: error: 'H_ENTER' undeclared (first u=
se in this function):  =3D> 240:7=0A=
  + arch/powerpc/kvm/book3s_pr_papr.c: error: 'H_EOI' undeclared (first use=
 in this function):  =3D> 258:7=0A=
  + arch/powerpc/kvm/book3s_pr_papr.c: error: 'H_EXACT' undeclared (first u=
se in this function):  =3D> 50:6=0A=
  + arch/powerpc/kvm/book3s_pr_papr.c: error: 'H_IPI' undeclared (first use=
 in this function):  =3D> 259:7=0A=
  + arch/powerpc/kvm/book3s_pr_papr.c: error: 'H_IPOLL' undeclared (first u=
se in this function):  =3D> 260:7=0A=
  + arch/powerpc/kvm/book3s_pr_papr.c: error: 'H_NOT_FOUND' undeclared (fir=
st use in this function):  =3D> 193:27, 87:27=0A=
  + arch/powerpc/kvm/book3s_pr_papr.c: error: 'H_PARAMETER' undeclared (fir=
st use in this function):  =3D> 138:10=0A=
  + arch/powerpc/kvm/book3s_pr_papr.c: error: 'H_PROTECT' undeclared (first=
 use in this function):  =3D> 244:7=0A=
  + arch/powerpc/kvm/book3s_pr_papr.c: error: 'H_PTEG_FULL' undeclared (fir=
st use in this function):  =3D> 54:12=0A=
  + arch/powerpc/kvm/book3s_pr_papr.c: error: 'H_PUT_TCE' undeclared (first=
 use in this function):  =3D> 248:7=0A=
  + arch/powerpc/kvm/book3s_pr_papr.c: error: 'H_REMOVE' undeclared (first =
use in this function):  =3D> 242:7=0A=
  + arch/powerpc/kvm/book3s_pr_papr.c: error: 'H_RTAS' undeclared (first us=
e in this function):  =3D> 265:7=0A=
  + arch/powerpc/kvm/book3s_pr_papr.c: error: 'H_SUCCESS' undeclared (first=
 use in this function):  =3D> 67:26, 96:26, 211:26, 125:12=0A=
  + arch/powerpc/kvm/book3s_pr_papr.c: error: 'H_TOO_HARD' undeclared (firs=
t use in this function):  =3D> 224:12=0A=
  + arch/powerpc/kvm/book3s_pr_papr.c: error: 'H_XIRR' undeclared (first us=
e in this function):  =3D> 256:7=0A=
  + arch/powerpc/kvm/book3s_pr_papr.c: error: 'H_XIRR_X' undeclared (first =
use in this function):  =3D> 261:7=0A=
  + arch/powerpc/platforms/pseries/hotplug-memory.c: error: 'SECTION_SIZE_B=
ITS' undeclared (first use in this function):  =3D> 24:31=0A=
  + mm/memory_hotplug.c: error: 'PAGES_PER_SECTION' undeclared (first use i=
n this function):  =3D> 1630:46=0A=
  + mm/memory_hotplug.c: error: implicit declaration of function '__nr_to_s=
ection' [-Werror=3Dimplicit-function-declaration]:  =3D> 1635:3=0A=
  + mm/memory_hotplug.c: error: implicit declaration of function 'find_memo=
ry_block_hinted' [-Werror=3Dimplicit-function-declaration]:  =3D> 1642:3=0A=
  + mm/memory_hotplug.c: error: implicit declaration of function 'pfn_to_se=
ction_nr' [-Werror=3Dimplicit-function-declaration]:  =3D> 1631:3=0A=
  + mm/memory_hotplug.c: error: implicit declaration of function 'present_s=
ection_nr' [-Werror=3Dimplicit-function-declaration]:  =3D> 1632:3=0A=
=0A=
powerpc-randconfig=0A=
=0A=
  + drivers/md/dm-cache-policy-mq.c: error: conflicting types for 'remove_m=
apping':  =3D> 962:13=0A=
=0A=
sparc-allmodconfig, not a regression (was hidden due to a sparc64/sparc32=
=0A=
mixup on kissb), patch submitted=0A=
=0A=
  + error: "usb_add_gadget_udc" [drivers/usb/chipidea/ci_hdrc.ko] undefined=
!:  =3D> N/A=0A=
  + error: "usb_del_gadget_udc" [drivers/usb/chipidea/ci_hdrc.ko] undefined=
!:  =3D> N/A=0A=
  + error: "usb_gadget_map_request" [drivers/usb/chipidea/ci_hdrc.ko] undef=
ined!:  =3D> N/A=0A=
  + error: "usb_gadget_unmap_request" [drivers/usb/chipidea/ci_hdrc.ko] und=
efined!:  =3D> N/A=0A=
=0A=
x86_64-randconfig=0A=
=0A=
> [1] http://kisskb.ellerman.id.au/kisskb/head/6490/ (all 120 configs)=0A=
> [3] http://kisskb.ellerman.id.au/kisskb/head/6461/ (all 120 configs)=0A=
=0A=
Gr{oetje,eeting}s,=0A=
=0A=
                                                Geert=0A=
=0A=
--=0A=
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org=0A=
=0A=
In personal conversations with technical people, I call myself a hacker. Bu=
t=0A=
when I'm talking to journalists I just say "programmer" or something like t=
hat.=0A=
                                                            -- Linus Torval=
ds=0A=
--=0A=
To unsubscribe from this list: send the line "unsubscribe linux-usb" in=0A=
the body of a message to majordomo@vger.kernel.org=0A=
More majordomo info at  http://vger.kernel.org/majordomo-info.html=0A=
=0A=
