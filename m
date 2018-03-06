Return-Path: <ruscur@russell.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwQpT4sQwzF1DQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 16:49:53 +1100 (AEDT)
Message-ID: <1520315388.2077.15.camel@russell.cc>
Subject: Re: [PATCH 9/9] powerpc/eeh: Add eeh_state_active() helper
From: Russell Currey <ruscur@russell.cc>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 06 Mar 2018 16:49:48 +1100
In-Reply-To: <2c6264797f9efd44679fa8c8ac4f8beb11a38c18.1520294174.git.sam.bobroff@au1.ibm.com>
References: <cover.1520294174.git.sam.bobroff@au1.ibm.com>
 <2c6264797f9efd44679fa8c8ac4f8beb11a38c18.1520294174.git.sam.bobroff@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-03-06 at 11:00 +1100, Sam Bobroff wrote:
> Checking for a "fully active" device state requires testing two flag
> bits, which is open coded in several places, so add a function to do
> it.
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Thanks for the patches.

Reviewed-by: Russell Currey <ruscur@russell.cc>
