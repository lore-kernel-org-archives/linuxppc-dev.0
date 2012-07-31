Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BC0442C0078
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2012 00:24:34 +1000 (EST)
Subject: Re: [PATCH 1/3] powerpc/mpic: finish supporting timer group B on
 Freescale chips
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <C5ECD7A89D1DC44195F34B25E172658D14C328@039-SN2MPN1-013.039d.mgd.msft.net>
Date: Tue, 31 Jul 2012 09:23:44 -0500
Message-Id: <C0CB0FAA-2433-4BB1-8B85-B01A6FED5B14@kernel.crashing.org>
References: <1341823542-15654-1-git-send-email-Varun.Sethi@freescale.com>
 <A0409C87-73AF-4D08-8AAC-676B4C6DC602@kernel.crashing.org>
 <C5ECD7A89D1DC44195F34B25E172658D14C328@039-SN2MPN1-013.039d.mgd.msft.net>
To: Sethi Varun-B16395 <B16395@freescale.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 31, 2012, at 8:55 AM, Sethi Varun-B16395 wrote:

> 
> 
>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Tuesday, July 31, 2012 7:20 PM
>> To: Sethi Varun-B16395
>> Cc: Wood Scott-B07421
>> Subject: Re: [PATCH 1/3] powerpc/mpic: finish supporting timer group B on
>> Freescale chips
>> 
>> 
>> On Jul 9, 2012, at 3:45 AM, Varun Sethi wrote:
>> 
>>> Previously, these interrupts would be mapped, but the offset
>>> calculation was broken, and only the first group was initialized.
>>> 
>>> Signed-off-by: Scott Wood <scottwood@freescale.com>
>>> ---
>>> arch/powerpc/include/asm/mpic.h |    5 +++
>>> arch/powerpc/sysdev/mpic.c      |   58 ++++++++++++++++++++++++++++----
>> -------
>>> 2 files changed, 47 insertions(+), 16 deletions(-)
>> 
>> Varun,
>> 
>> Can you reply with a Signed-off-by to the thread.
>> 
> Signed-off-by: Varun Sethi <varun.sethi@freescale.com>

thanks

applied to next

- k
