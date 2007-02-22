Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id D0EF4DDDF4
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2007 21:14:38 +1100 (EST)
Date: Thu, 22 Feb 2007 11:14:36 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: platform_ops.malloc() vs. realloc()
Message-ID: <Pine.LNX.4.62.0702221112010.22848@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


arch/powerpc/boot/ops.h has:

| /* Platform specific operations */
| struct platform_ops {
|         void    (*fixups)(void);
|         void    (*image_hdr)(const void *);
|         void *  (*malloc)(u32 size);
|         void    (*free)(void *ptr);
|         void *  (*realloc)(void *ptr, unsigned long size);
|         void    (*exit)(void);
| };

Is there a specific reason why the size parameters of malloc() and realloc()
differ in type?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
