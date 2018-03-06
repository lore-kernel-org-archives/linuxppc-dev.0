Return-Path: <ruscur@russell.cc>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwJKh6ZKjzDrK6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 11:58:00 +1100 (AEDT)
Message-ID: <1520297875.2077.7.camel@russell.cc>
Subject: Re: [PATCH 5/9] powerpc/eeh: Rename frozen_bus to bus in
 eeh_handle_normal_event()
From: Russell Currey <ruscur@russell.cc>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 06 Mar 2018 11:57:55 +1100
In-Reply-To: <a8d5f7792b761721852b68363c68519c6c8b62ff.1520294174.git.sam.bobroff@au1.ibm.com>
References: <cover.1520294174.git.sam.bobroff@au1.ibm.com>
 <a8d5f7792b761721852b68363c68519c6c8b62ff.1520294174.git.sam.bobroff@au1.ibm.com>
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
> The name "frozen_bus" is misleading: it's not necessarily frozen,
> it's
> just the PE's PCI bus.
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Reviewed-by: Russell Currey <ruscur@russell.cc>
