Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DD80B2C0132
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Sep 2013 02:07:10 +1000 (EST)
Message-ID: <1379693218.16231.7.camel@aoeu.buserror.net>
Subject: Re: [PATCH 1/2][v3] powerpc/fsl-booke: Add initial T104x_QDS board
 support
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@tabi.org>
Date: Fri, 20 Sep 2013 11:06:58 -0500
In-Reply-To: <523C37CF.3030103@tabi.org>
References: <1379581205-24424-1-git-send-email-prabhakar@freescale.com>
 <CAOZdJXVBV0LvEwTua_eyTHXJdOcHZKQCjiTrYocqfcQY5hosUw@mail.gmail.com>
 <071A08F2C6A57E4E94D980ECA553F874F9CF8D@039-SN1MPN1-005.039d.mgd.msft.net>
 <523BBC15.8030607@tabi.org> <523C0B78.7050005@freescale.com>
 <523C37CF.3030103@tabi.org>
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

On Fri, 2013-09-20 at 06:55 -0500, Timur Tabi wrote:
> Prabhakar Kushwaha wrote:
> >
> > I think patch set is OK for now. No need to send v4.
> 
> It needs an updated patch description because the patch lies.  It 
> advertises DIU support, which is not true.

The patch is not "lying".  It is describing the board, not what the
patch supports.  This was something you used to constantly tell people
to do...

There are other things in that description that Linux doesn't do
anything with, such as QIXIS.

-Scott
