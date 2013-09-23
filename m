Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0251.outbound.messaging.microsoft.com [213.199.154.251])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7FE062C0120
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 04:06:41 +1000 (EST)
Message-ID: <1379959590.24959.10.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/2][v3] powerpc/fsl-booke: Add initial T104x_QDS board
 support
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@tabi.org>
Date: Mon, 23 Sep 2013 13:06:30 -0500
In-Reply-To: <523CE716.70909@tabi.org>
References: <1379581205-24424-1-git-send-email-prabhakar@freescale.com>
 <CAOZdJXVBV0LvEwTua_eyTHXJdOcHZKQCjiTrYocqfcQY5hosUw@mail.gmail.com>
 <071A08F2C6A57E4E94D980ECA553F874F9CF8D@039-SN1MPN1-005.039d.mgd.msft.net>
 <523BBC15.8030607@tabi.org> <523C0B78.7050005@freescale.com>
 <523C37CF.3030103@tabi.org> <1379693218.16231.7.camel@aoeu.buserror.net>
 <523CE716.70909@tabi.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Aggrwal Poonam-B10812 <B10812@freescale.com>,
 Jain Priyanka-B32167 <B32167@freescale.com>,
 Kushwaha Prabhakar-B32579 <B32579@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-09-20 at 19:23 -0500, Timur Tabi wrote:
> Scott Wood wrote:
> > The patch is not "lying".  It is describing the board, not what the
> > patch supports.  This was something you used to constantly tell people
> > to do...
> 
> The patch says:
> 
> 	"DIU supports video at up to 1280x1024x32bpp"
> 
> How is this not misleading?

Does it have different limits on this board?

> I understand that the patch describes the board, and that's correct.  It 
> should also indicate which major functionality is not supported.  I was 
> expecting something like this:
> 
> - Video
>       - DIU hardware is capable of video up to 1280x1024x32bpp
>       - DIU support is currently not implemented

Sure, it would be nice to point out notable limitations in the board
support.  That doesn't mean that it's lying as is, as it's quite
obviously a cut and paste from some other document rather than a
meaningful description of the patch itself.  I've never been a fan of
this sort of changelog, as we've discussed in the past.

-Scott
