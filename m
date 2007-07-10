Return-Path: <blackfin.kang@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by ozlabs.org (Postfix) with ESMTP id F1B48DDED2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Jul 2007 12:11:29 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so197247anc
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 09 Jul 2007 19:11:28 -0700 (PDT)
Message-ID: <a7f827420707091911x5c3b538fp5f0dd8a316d862ad@mail.gmail.com>
Date: Tue, 10 Jul 2007 10:11:28 +0800
From: "kang shuo" <blackfin.kang@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: A question about _PAGE_PRESENT flag when ioremap is executed....
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi:
           I had read some confusing code about io address map in
MPC8560 that employs E500 core. My confusion is when io address map is
setup, if _PAGE_PRESENT flag of page is set? In implementation of
mpc8560 , that seems page flag that maps to io address region is
0x280, means only the following flag is set:
#define _PAGE_GUARDED   0x00080 /* H: G bit */
#define _PAGE_NO_CACHE  0x00200 /* H: I bit */

But  I think _PAGE_PRESENT shoulbe be set for BOOKE too...
/* Definitions for FSL Book-E Cores */
#define _PAGE_PRESENT   0x00001 /* S: PTE contains a translation */
           Any guys give me some idea about that? Thanks....


-- Michael.Kang
