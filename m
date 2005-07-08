Return-Path: <rsiemsen@rossvideo.com>
Received: from server06.rossvideo.com (gw-rossvideo.storm.ca [209.87.241.202])
	by ozlabs.org (Postfix) with ESMTP id 8183867BF5
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Jul 2005 03:26:31 +1000 (EST)
Message-ID: <42CEB744.1070301@rossvideo.com>
Date: Fri, 08 Jul 2005 13:26:28 -0400
From: Ralph Siemsen <rsiemsen@rossvideo.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <F795765B112E7344AF36AA91127964151EC368@xmb-sjc-212.amer.cisco.com>
	<354AB8A8-1BE5-4BC0-8252-D51D1CEF6B51@freescale.com>
In-Reply-To: <354AB8A8-1BE5-4BC0-8252-D51D1CEF6B51@freescale.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: "Bizhan Gholikhamseh \\\(bgholikh\\\)" <bgholikh@cisco.com>,
	linuxppc-embedded@ozlabs.org
Subject: Re: remap_page_range not resolved
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> This is probably due to the change of remap_page_range to  
> remap_pfn_range.  I forget the exact kernel version this was changed in.

It just happened in 2.6.12.
http://lwn.net/Articles/129480/

-R
