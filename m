Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id DD12BDDE0D
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 20:04:17 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org,
 rrnelson@linux.vnet.ibm.com
Subject: Re: [PATCH 2/2] Add support to OProfile for profiling Cell BE SPUs
Date: Fri, 13 Jul 2007 12:02:19 +0200
References: <1184284059.16584.7.camel@bnelson60.rchland.ibm.com>
In-Reply-To: <1184284059.16584.7.camel@bnelson60.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707131202.19635.arnd@arndb.de>
Cc: oprofile <oprofile-list@lists.sf.net>,
	Andrew Morton <akpm@linuxfoundation.org>,
	Philippe Elie <phil.el@wanadoo.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 13 July 2007, Bob Nelson wrote:
> We would like this patch included in -mm and 2.6.23.
>=20
> Subject: Add support to OProfile for profiling Cell BE SPUs
>=20
> From: Maynard Johnson <mpjohn@us.ibm.com>
>       Bob Nelson <rrnelson@us.ibm.com>
>=20

The patch itself looks ok, but unfortunately, you have a few
formal mistakes in the submission. Most importantly, the long
lines got wrapped by your mail client, so it won't apply.

About the start of the mail, please put the 'We would like to...'
part and everything else that is not supposed to show up in
the changelog _below_ the introduction, separated from the
changelog with a single line containing the string '---'.

The Subject: line should not be in the mail body, it's only
used if you want to use the 'quilt mail' tool, which will
move it to the real subject of the mail.

The From: line can only have one name in it. If you want to
give credit to multiple people, that should be in the
changelog text.

Please resend.

	Arnd <><

> This patch updates the existing arch/powerpc/oprofile/op_model_cell.c
> to add in the SPU profiling capabilities. =A0In addition, a 'cell'
> subdirectory
> was added to arch/powerpc/oprofile to hold Cell-specific SPU profiling
> code.
> Also incorporated several fixes from other patches. =A0Check pointer
> returned from kzalloc. =A0Eliminated unnecessary cast. =A0Better error
> handling and cleanup in the related area. =A064-bit unsigned long
> parameter
> was being demoted to 32-bit unsigned int and eventually promoted back to
> unsigned long.
>=20
> Signed-off-by: Carl Love <carll@us.ibm.com>
> Signed-off-by: Maynard Johnson <mpjohn@us.ibm.com>
> Signed-off-by: Bob Nelson <rrnelson@us.ibm.com>
> Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
> Acked-by: Paul Mackerras <paulus@samba.org>
