Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
 by lists.ozlabs.org (Postfix) with ESMTP id 9EDAF1A00A5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 May 2014 12:45:41 +1000 (EST)
Message-ID: <5379704B.4090301@daenzer.net>
Date: Mon, 19 May 2014 11:45:31 +0900
From: =?UTF-8?B?TWljaGVsIETDpG56ZXI=?= <michel@daenzer.net>
MIME-Version: 1.0
To: Luigi Burdo <intermediadc@hotmail.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: G5 Quad working with Linux PPC and RadeonHD
References: <BLU436-SMTP80159B93A5EE9CE9979A56C8310@phx.gbl>
 <5376DD44.4040402@daenzer.net>
 <BLU436-SMTP260B93781C0F77CDD26FD4AC8300@phx.gbl>
In-Reply-To: <BLU436-SMTP260B93781C0F77CDD26FD4AC8300@phx.gbl>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 17.05.2014 17:28, Luigi Burdo wrote:
> 
> on X1000 r600 boards dont gave decoration problems
> there is probably needed some other trick about
> for the other architecture.
> 
> https://bugs.freedesktop.org/show_bug.cgi?id=74939

That bug is specific to Evergreen / Northern Islands family cards, which
includes your 6570, but not your 4650 for example.


-- 
Earthling Michel Dänzer            |                  http://www.amd.com
Libre software enthusiast          |                Mesa and X developer
