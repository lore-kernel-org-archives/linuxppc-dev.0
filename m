Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401RG60YNfzDrBV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 20:27:42 +1100 (AEDT)
In-Reply-To: <20180130142351.23511-1-Larry.Finger@lwfinger.net>
To: Larry Finger <Larry.Finger@lwfinger.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [v2] macintosh: Add module license to ans-lcd
Message-Id: <401RG55bn7z9sTw@ozlabs.org>
Date: Wed, 14 Mar 2018 20:27:41 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-01-30 at 14:23:51 UTC, Larry Finger wrote:
> In kernel 4.15, the modprobe step on my PowerBook G4 started complaining that
> there was no module license for ans-lcd.
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/47d703e1d55f068c737c0c9f0c18f0

cheers
