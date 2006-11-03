Return-Path: <ptich@hotmail.com>
Received: from hotmail.com (bay102-f21.bay102.hotmail.com [64.4.61.31])
	by ozlabs.org (Postfix) with ESMTP id BA7C967C62
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 14:56:07 +1100 (EST)
Message-ID: <BAY102-F21F34507B25D8615CACD06A9FE0@phx.gbl>
From: "M Ptich" <ptich@hotmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Clear OS / HAL separation
Date: Fri, 03 Nov 2006 03:39:01 +0000
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

I am porting 2.6 kernel from Freescale onto our PPC platform. This is my 
first experience with Linux, and I was unpleasantly surprised how poorly OS 
and platform code are separated. So I have a question: is there a project 
underway, somewhere, that is trying to separate OS and HAL (or Board Support 
Package) for the next Linux kernel ?

Would highly appreciate any relevant pointers.

_________________________________________________________________
Stay in touch with old friends and meet new ones with Windows Live Spaces 
http://clk.atdmt.com/MSN/go/msnnkwsp0070000001msn/direct/01/?href=http://spaces.live.com/spacesapi.aspx?wx_action=create&wx_url=/friends.aspx&mkt=en-us
