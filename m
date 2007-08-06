Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 03B7ADDE45
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 05:11:30 +1000 (EST)
In-Reply-To: <200708021214.51705.m.kozlowski@tuxland.pl>
References: <20070731230932.a9459617.akpm@linux-foundation.org>
	<200708011002.30962.m.kozlowski@tuxland.pl>
	<18096.24918.111376.805855@cargo.ozlabs.ibm.com>
	<200708021214.51705.m.kozlowski@tuxland.pl>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e2ac1b1e51999a427fc2567071577f11@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: 2.6.23-rc1-mm2
Date: Mon, 6 Aug 2007 21:10:52 +0200
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: linux-usb-devel@lists.sourceforge.net, gregkh@suse.de,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On 2 aug 2007, at 12:14, Mariusz Kozlowski wrote:

>>> Second issue as reported earilier allmodconfig fails to build on 
>>> imac g3.
>>
>> Do you really mean g3?  If so it's a 32-bit kernel and it shouldn't be
>> building lparmap.s.

It might be a bug nevertheless, there are more "issues" with
the interesting way lparmap.s is built and used.


Segher
