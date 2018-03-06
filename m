Return-Path: <ruscur@russell.cc>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwJ2F1hb0zF1KD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 11:44:35 +1100 (AEDT)
Message-ID: <1520297067.2077.0.camel@russell.cc>
Subject: Re: [PATCH 1/9] powerpc/eeh: Remove eeh_handle_event()
From: Russell Currey <ruscur@russell.cc>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 06 Mar 2018 11:44:27 +1100
In-Reply-To: <d3d01073da02a5eb844cc8998fdac602b8121b62.1520294174.git.sam.bobroff@au1.ibm.com>
References: <cover.1520294174.git.sam.bobroff@au1.ibm.com>
 <d3d01073da02a5eb844cc8998fdac602b8121b62.1520294174.git.sam.bobroff@au1.ibm.com>
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

On Tue, 2018-03-06 at 10:58 +1100, Sam Bobroff wrote:
> The function eeh_handle_event(pe) does nothing other than switching
> between calling eeh_handle_normal_event(pe) and
> eeh_handle_special_event(). However it is only called in two places,
> one where pe can't be NULL and the other where it must be NULL (see
> eeh_event_handler()) so it does nothing but obscure the flow of
> control.
> 
> So, remove it.
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Reviewed-by: Russell Currey <ruscur@russell.cc>
