Return-Path: <hs@denx.de>
Received: from a.relay.invitel.net (a.relay.invitel.net [62.77.203.3])
	by ozlabs.org (Postfix) with ESMTP id D9070B7234
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  3 May 2011 15:27:20 +1000 (EST)
Date: Tue, 03 May 2011 07:17:42 +0200
From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH v6 0/6] powerpc, 52xx: add charon board support
In-reply-to: <20110502221406.GA15043@ponder.secretlab.ca>
To: Grant Likely <grant.likely@secretlab.ca>
Message-id: <4DBF8FF6.8030100@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
References: <1291451028-22532-1-git-send-email-hs@denx.de>
	<1300782452-528-1-git-send-email-hs@denx.de>
	<20110502221406.GA15043@ponder.secretlab.ca>
Cc: linux-fbdev@vger.kernel.org, devicetree-discuss@ozlabs.org,
	Samuel Ortiz <sameo@linux.intel.com>, Vincent Sanders <vince@simtec.co.uk>,
	linux-kernel@vger.kernel.org, Ben Dooks <ben@simtec.co.uk>,
	Randy Dunlap <rdunlap@xenotime.net>,
	Paul Mundt <lethal@linux-sh.org>, linuxppc-dev@lists.ozlabs.org,
	Wolfgang Denk <wd@denx.de>
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Grant,

Grant Likely wrote:
> On Tue, Mar 22, 2011 at 09:27:26AM +0100, Heiko Schocher wrote:
>> cc: Wolfram Sang <w.sang@pengutronix.de>
>> cc: Grant Likely <grant.likely@secretlab.ca>
>> cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> cc: linux-fbdev@vger.kernel.org
>> cc: devicetree-discuss@ozlabs.org
>> cc: Ben Dooks <ben@simtec.co.uk>
>> cc: Vincent Sanders <vince@simtec.co.uk>
>> cc: Samuel Ortiz <sameo@linux.intel.com>
>> cc: linux-kernel@vger.kernel.org
>> cc: Randy Dunlap <rdunlap@xenotime.net>
>> cc: Wolfgang Denk <wd@denx.de>
>> cc: Paul Mundt <lethal@linux-sh.org>
>>
>> changes since v5:
>> - repost complete patchseries, as Paul Mundt suggested
>> - rebased against current head
>> - add Acked-by from Samuel Ortiz (MFD parts)
>>   http://www.spinics.net/lists/linux-fbdev/msg02550.html
>>   http://linux.derkeiler.com/Mailing-Lists/Kernel/2011-01/msg11798.html
>>
>>   and Benjamin Herrenschmidt (DTS parts)
>>   http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-February/088279.html
>> - removed patch 
>>   "powerpc, mpc5200: update mpc5200_defconfig to fit for charon board."
>>   therefore added
>>   "powerpc, tqm5200: update tqm5200_defconfig to fit for charon board."
> 
> Refresh my memory, why was the mpc5200_defconfig updated dropped?

Because it is a board based on the tqm5200 board port ... no other
reason.

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
