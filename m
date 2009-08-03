Return-Path: <paulus@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EAFFBB6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  3 Aug 2009 22:57:26 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D48DDDDD1B
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Aug 2009 22:57:26 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <19062.57005.981901.24666@cargo.ozlabs.ibm.com>
Date: Mon, 3 Aug 2009 22:57:17 +1000
From: Paul Mackerras <paulus@samba.org>
To: Roel Kluin <roel.kluin@gmail.com>
Subject: Re: [PATCH] powerpc: Read buffer overflow
In-Reply-To: <4A76DB06.7090405@gmail.com>
References: <4A76DB06.7090405@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Roel Kluin writes:

> Check whether index is within bounds before grabbing the element.

The change seems unnecessary since we only compute the address of the
element before the bounds check, we don't actually access the
element.  I believe that is legal in C.

Paul.
