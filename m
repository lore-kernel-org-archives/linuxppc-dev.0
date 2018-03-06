Return-Path: <ruscur@russell.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwPCm5ZkZzF1Mx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 15:38:12 +1100 (AEDT)
Message-ID: <1520311087.2077.11.camel@russell.cc>
Subject: Re: [PATCH 7/9] powerpc/eeh: Remove always-true tests in
 eeh_reset_device()
From: Russell Currey <ruscur@russell.cc>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 06 Mar 2018 15:38:07 +1100
In-Reply-To: <62fba6f13022a6d3cfb1e6468560abce10b0abfc.1520294174.git.sam.bobroff@au1.ibm.com>
References: <cover.1520294174.git.sam.bobroff@au1.ibm.com>
 <62fba6f13022a6d3cfb1e6468560abce10b0abfc.1520294174.git.sam.bobroff@au1.ibm.com>
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

On Tue, 2018-03-06 at 10:59 +1100, Sam Bobroff wrote:
> eeh_reset_device() tests the value of 'bus' more than once but the
> only caller, eeh_handle_normal_device() does this test itself and
> will
> never pass NULL.
> 
> So, remove the dead tests.
> 
> This should not change behaviour.
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Reviewed-by: Russell Currey <ruscur@russell.cc>
