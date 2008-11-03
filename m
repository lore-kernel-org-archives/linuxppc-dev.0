Return-Path: <mditto@consentry.com>
Received: from tidalnetworks.net (mail.consentry.com [75.35.230.10])
	by ozlabs.org (Postfix) with ESMTP id E5E63DDDEA
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Nov 2008 14:50:29 +1100 (EST)
Message-ID: <490E74FC.4060106@consentry.com>
Date: Sun, 02 Nov 2008 19:50:20 -0800
From: Mike Ditto <mditto@consentry.com>
MIME-Version: 1.0
To: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH] i2c-cpm: Detect and report NAK right away instead of
	timing out.
References: <490BA2E5.8010309@consentry.com>
	<20081103002328.GC30438@fluff.org.uk>
In-Reply-To: <20081103002328.GC30438@fluff.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben Dooks wrote:
>> When reading from a device that is not present or declines to respond
>> to, e.g., a non-existent register address, CPM immediately reports a
>> NAK condition in the TxBD, but the driver kept waiting until a timeout,
>> which takes 1 second and causes an ugly console error message.
> 
> hmm, that block of text could probably go into the patch description.

It's certainly fine with me if you want to include it.  I was just
trying, perhaps inappropriately, to separate the "bug report" from the
"description of the change".

					-=] Mike [=-
