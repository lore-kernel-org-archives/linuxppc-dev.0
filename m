Return-Path: <moris_dong@hotmail.com>
Received: from hotmail.com (bay19-f22.bay19.hotmail.com [64.4.53.72])
	by ozlabs.org (Postfix) with ESMTP id 049B467A70
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 30 Apr 2006 18:32:49 +1000 (EST)
Message-ID: <BAY19-F22FE6D4F4F38A760BBF9B2F8B00@phx.gbl>
From: "moris dong" <moris_dong@hotmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Large Page Support, 2.6 kernel , PPC440
Date: Sun, 30 Apr 2006 08:15:43 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Friends,
My PPC440 (32bit) MMU supports multiple page sizes.
For the default 4K pages, my 2.6.11 kernel compiles and boots just fine.
I want to re-build it with large pages, to improve my application 
performance.
I tried modifying PAGE_SHIFT in "page.h" to 13 (8K pages) and re-build my 
kernel.
Compilation worked out fine, but my kernel does NOT boot, nor it prints 
anything to the console.

Has anyone successfully compiled & booted a 2.6 kernel with pages larger 
than 4K ?
What am I doing wrong ?

Thanks a lot.

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
