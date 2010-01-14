Return-Path: <roel.kluin@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.27])
	by ozlabs.org (Postfix) with ESMTP id 94D27B7CA0
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jan 2010 09:56:24 +1100 (EST)
Received: by ey-out-2122.google.com with SMTP id 22so45542eye.33
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jan 2010 14:56:22 -0800 (PST)
Message-ID: <4B4FA225.90108@gmail.com>
Date: Fri, 15 Jan 2010 00:00:53 +0100
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: powerpc: should mem_end be assigned to dt_struct_end in
	flatten_device_tree()?
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

vi arch/powerpc/kernel/prom_init.c +1961 and note that in
flatten_device_tree() we do a

	RELOC(dt_struct_end) = PAGE_ALIGN(mem_start);

should that maybe be

	RELOC(dt_struct_end) = PAGE_ALIGN(mem_end);

thanks,

Roel
