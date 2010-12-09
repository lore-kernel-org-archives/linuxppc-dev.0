Return-Path: <hs@denx.de>
Received: from a.relay.invitel.net (a.relay.invitel.net [62.77.203.3])
	by ozlabs.org (Postfix) with ESMTP id A9C3BB70B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Dec 2010 17:49:50 +1100 (EST)
Date: Thu, 09 Dec 2010 07:49:45 +0100
From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 1/2] video, sm501: add OF binding to support SM501
In-reply-to: <20101208053635.GB31508@linux-sh.org>
To: Paul Mundt <lethal@linux-sh.org>
Message-id: <4D007C09.3040308@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
References: <1291451028-22532-1-git-send-email-hs@denx.de>
	<20101208053635.GB31508@linux-sh.org>
Cc: linux-fbdev@vger.kernel.org, devicetree-discuss@ozlabs.org,
	linuxppc-dev@lists.ozlabs.org, Samuel Ortiz <sameo@linux.intel.com>,
	Ben Dooks <ben-linux@fluff.org>
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Paul,

Paul Mundt wrote:
> On Sat, Dec 04, 2010 at 09:23:47AM +0100, Heiko Schocher wrote:
>> - add binding to OF, compatible name "smi,sm501"
>>
[...]
>>  Documentation/kernel-parameters.txt          |    7 +
>>  Documentation/powerpc/dts-bindings/sm501.txt |   30 +++
>>  drivers/mfd/sm501.c                          |  141 ++++++++------
>>  drivers/video/sm501fb.c                      |  264 +++++++++++++++++---------
>>  include/linux/sm501.h                        |    8 +
>>  5 files changed, 299 insertions(+), 151 deletions(-)
>>  create mode 100644 Documentation/powerpc/dts-bindings/sm501.txt
>>
> Given that this is all SM501 dependent, is there some particular reason
> why you neglected to Cc the author or the MFD folks?

Hups, sorry! No, there is no reason, thanks for detecting this.

Hmm.. couldn;t find a MFD maillinglist?

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
