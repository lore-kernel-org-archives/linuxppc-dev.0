Return-Path: <madhvesh.s@ap.sony.com>
Received: from IE1EHSOBE005.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id B5205DDE1D
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 00:14:56 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [RFC] Kprobes for book-e
Date: Tue, 3 Jun 2008 19:40:55 +0530
Message-ID: <7B7EF7F090B9804A830ACC82F2CDE95D2609E8@insardxms01.ap.sony.com>
From: "Sulibhavi, Madhvesh" <madhvesh.s@ap.sony.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, rsmadhvesh@vsnl.net,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote on Tuesday, June 03, 2008 5:22 PM
> What build issues?  Ebony should build fine for 2.6.26-rc3, unless
> you're trying to apply this patchset to it without the other=20
> patches it
> requires.

I am trying without kprobes patches. I get build error
as below

--------------------------------------------------------------
BFD: ./vmlinux.strip.28275: section .bss lma 0xc034f000 overlaps
previous sections
BFD: ./vmlinux.strip.28275: section `.text' can't be allocated in
segment 0
/usr/local/powerpc-linux/bin/powerpc-linux-objcopy:
./vmlinux.strip.28275: Bad value
BFD: ./vmlinux.strip.28275: section .text lma 0xc0000000 overlaps
previous sections
BFD: ./vmlinux.strip.28275: section .ref.text lma 0xc024e000 overlaps
previous sections
BFD: ./vmlinux.strip.28275: section .devinit.text lma 0xc024f860
overlaps previous sections
BFD: ./vmlinux.strip.28275: section .devexit.text lma 0xc0253624
overlaps previous sections
BFD: ./vmlinux.strip.28275: section .rodata lma 0xc0254000 overlaps
previous sections
BFD: ./vmlinux.strip.28275: section .pci_fixup lma 0xc02ebcc8 overlaps
previous sections
BFD: ./vmlinux.strip.28275: section __ksymtab lma 0xc02ec280 overlaps
previous sections
BFD: ./vmlinux.strip.28275: section __ksymtab_gpl lma 0xc02f0c58
overlaps previous sections
BFD: ./vmlinux.strip.28275: section __kcrctab lma 0xc02f2620 overlaps
previous sections
BFD: ./vmlinux.strip.28275: section __kcrctab_gpl lma 0xc02f4b0c
overlaps previous sections
BFD: ./vmlinux.strip.28275: section __ksymtab_strings lma 0xc02f57f0
overlaps previous sections
BFD: ./vmlinux.strip.28275: section __param lma 0xc0302d74 overlaps
previous sections
BFD: ./vmlinux.strip.28275: section __ex_table lma 0xc0304000 overlaps
previous sections
BFD: ./vmlinux.strip.28275: section __bug_table lma 0xc0305780 overlaps
previous sections
BFD: ./vmlinux.strip.28275: section .init.text lma 0xc0309000 overlaps
previous sections
BFD: ./vmlinux.strip.28275: section .exit.text lma 0xc0321010 overlaps
previous sections
BFD: ./vmlinux.strip.28275: section .init.data lma 0xc0321bd4 overlaps
previous sections
BFD: ./vmlinux.strip.28275: section .init.setup lma 0xc03253e0 overlaps
previous sections
BFD: ./vmlinux.strip.28275: section .initcall.init lma 0xc032568c
overlaps previous sections
BFD: ./vmlinux.strip.28275: section .con_initcall.init lma 0xc03258c4
overlaps previous sections
BFD: ./vmlinux.strip.28275: section __ftr_fixup lma 0xc03258d0 overlaps
previous sections
BFD: ./vmlinux.strip.28275: section .machine.desc lma 0xc0326000
overlaps previous sections
BFD: ./vmlinux.strip.28275: section .data lma 0xc0327000 overlaps
previous sections
BFD: ./vmlinux.strip.28275: section .data.init_task lma 0xc0348000
overlaps previous sections
BFD: ./vmlinux.strip.28275: section .data.page_aligned lma 0xc034a000
overlaps previous sections
BFD: ./vmlinux.strip.28275: section .data.cacheline_aligned lma
0xc034d000 overlaps previous sections
BFD: ./vmlinux.strip.28275: section .data.read_mostly lma 0xc034d100
overlaps previous sections
BFD: ./vmlinux.strip.28275: section .bss lma 0xc034f000 overlaps
previous sections
BFD: ./vmlinux.strip.28275: section `.text' can't be allocated in
segment 0
/usr/local/powerpc-linux/bin/powerpc-linux-objcopy:
./vmlinux.strip.28275: Bad value
make[1]: *** [arch/powerpc/boot/treeImage.ebony] Error 1
rm arch/powerpc/boot/ebony.dtb
make: *** [zImage] Error 2
--------------------------------------------------------------


>=20
> You'll need to use either my git tree with Kumar's exception series
> applied, or use Kumar's tree.  The kprobes code is 2.6.27 material,
> so .26-rc3 (or -rc4) is too old.

I will try with kumar's git repository

-Madhvesh


-------------------------------------------------------------------
This email is confidential and intended only for the use of the =
individual or entity named above and may contain information that is =
privileged. If you are not the intended recipient, you are notified that =
any dissemination, distribution or copying of this email is strictly =
prohibited. If you have received this email in error, please notify us =
immediately by return email or telephone and destroy the original =
message. - This mail is sent via Sony Asia Pacific Mail Gateway.
-------------------------------------------------------------------
