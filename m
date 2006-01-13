Return-Path: <jacmet@sunsite.dk>
Received: from hoboe2bl1.telenet-ops.be (hoboe2bl1.telenet-ops.be
	[195.130.137.73]) by ozlabs.org (Postfix) with ESMTP id B207E68A58
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Jan 2006 05:48:58 +1100 (EST)
To: grant.likely@secretlab.ca
Subject: Re: [PATCH 08/10] ML300 & ML403 need embed_config.o linked in
References: <11367955811900-git-send-email-grant.likely@secretlab.ca>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Fri, 13 Jan 2006 19:18:57 +0100
In-Reply-To: <11367955811900-git-send-email-grant.likely@secretlab.ca> (grant
	likely's message of "Mon, 9 Jan 2006 01:33:01 -0700")
Message-ID: <87psmwq9da.fsf@48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: glikely@gmail.com, dhlii@dlasys.net, gnathita@gmail.com,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "grant" == grant likely <grant.likely@secretlab.ca> writes:

 grant> +boot-$(CONFIG_XILINX_ML300)	+= embed_config.o
 grant> +boot-$(CONFIG_XILINX_ML403)	+= embed_config.o

Notice that the ML300 line already is in mainline and pending for
2.6.15.1.

-- 
Bye, Peter Korsgaard
