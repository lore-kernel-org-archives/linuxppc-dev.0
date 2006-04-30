Return-Path: <moris_dong@hotmail.com>
Received: from hotmail.com (bay19-f20.bay19.hotmail.com [64.4.53.70])
	by ozlabs.org (Postfix) with ESMTP id BB27C679F0
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Apr 2006 18:34:25 +1000 (EST)
Message-ID: <BAY19-F2029D64D920AE728D87064F8B00@phx.gbl>
From: "moris dong" <moris_dong@hotmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Large Page Support, 2.6 kernel , PPC440
Date: Sun, 30 Apr 2006 08:17:18 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Friends,
My PPC440 (32bit) MMU supports multiple page sizes.
For the default 4K pages, my 2.6.11 kernel compiles and boots just fine.
I want to re-build it with large pages, to improve my application 
performance.
I tried modifying PAGE_SHIFT in "page.h" to 13 (8K pages) and re-build my 
kernel.
Compilation worked out fine, but my kernel does NOT boot, nor it prints 
anything to the console.

Has anyone successfully compiled & booted a 2.6 kernel for PPC440 with pages 
larger than 4K ?
What am I doing wrong ?

Thanks a lot.

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
