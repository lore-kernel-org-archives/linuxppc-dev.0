Return-Path: <morten.banzon@axxessit.no>
Received: from pt20-qms-01.ptn.no (pt20-qms-01.ptn.no [64.28.25.138])
	by ozlabs.org (Postfix) with SMTP id 1BE2567A80
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Feb 2005 06:50:36 +1100 (EST)
To: Tom Rini <trini@kernel.crashing.org>
MIME-Version: 1.0
Message-ID: <OFBD33500D.E8DD3F33-ONC1256FA9.006C5F4F-C1256FA9.006CFE15@axxessit.no>
From: morten.banzon@axxessit.no
Date: Tue, 15 Feb 2005 20:50:11 +0100
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][PPC32] Adds mcc cpm commands
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Tom Rini <trini@kernel.crashing.org>
15.02.2005 20:23

 
        To:     morten.banzon@axxessit.no
        cc:     linuxppc-embedded@ozlabs.org
        Subject:        Re: [PATCH][PPC32] Adds mcc cpm commands


On Mon, Feb 14, 2005 at 01:56:07PM +0100, morten.banzon@axxessit.no wrote:

>> This patch adds mcc cpm commands to the cpm2.h file in the 2.6.10 
kernel
>> 
>> Signed-off-by:  Morten Banzon  <morten.banzon at axxessit.no>

> What is this used for / needed by?  Thanks.


> -- 
> Tom Rini
> http://gate.crashing.org/~trini/

This is needed for a MPC82xx MCC driver. Curently no MCC driver is in the 
kernel.
My intention is to supply more patches with definitions for MCC interrupts 
and buffer descriptors, if there is acceptance for such.
Even if no MCC driver is currently in the kernel these patches could go 
in. They do not break anything, only easy the job for those who need a MCC 
driver, like me :-)

-- Morten
