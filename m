Return-Path: <ruscur@russell.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40cjNv18hPzF15L
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 16:51:58 +1000 (AEST)
Message-ID: <1525416712.2560.6.camel@russell.cc>
Subject: Re: [PATCH 06/13] powerpc/eeh: Add message when PE processing at
 parent
From: Russell Currey <ruscur@russell.cc>
To: Sam Bobroff <sbobroff@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Fri, 04 May 2018 16:51:52 +1000
In-Reply-To: <dcc5a3ed61264ac43265fd4be8509be71824cff6.1525242772.git.sbobroff@linux.ibm.com>
References: <cover.1525242772.git.sbobroff@linux.ibm.com>
 <dcc5a3ed61264ac43265fd4be8509be71824cff6.1525242772.git.sbobroff@linux.ibm.com>
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

On Wed, 2018-05-02 at 16:35 +1000, Sam Bobroff wrote:
> To aid debugging, add a message to show when EEH processing for a PE
> will be done at the device's parent, rather than directly at the
> device.
> 
> Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>

Good idea!

Reviewed-by: Russell Currey <ruscur@russell.cc>
