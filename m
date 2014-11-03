Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0107.outbound.protection.outlook.com [65.55.169.107])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 229881A0296
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Nov 2014 04:52:12 +1100 (AEDT)
Message-ID: <1415037117.23458.233.camel@snotra.buserror.net>
Subject: Re: [PATCH 0/2] Support multiple MSI interrupts on FSL-MPIC
From: Scott Wood <scottwood@freescale.com>
To: Johannes Thumshirn <johannes.thumshirn@men.de>
Date: Mon, 3 Nov 2014 11:51:57 -0600
In-Reply-To: <1415031514-27284-1-git-send-email-johannes.thumshirn@men.de>
References: <1415031514-27284-1-git-send-email-johannes.thumshirn@men.de>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-11-03 at 17:18 +0100, Johannes Thumshirn wrote:
> This series adds support for multiple MSI interrupts on FSL's MPIC.  The patch
> series was originally done by Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> and re-applied and tested by me.
> 
> I dodn't know whether it is OK to put my name on it or not. So if Sebastian has
> a problem with it I'll of cause change it immediately. It was just convenient to
> use my name in the git commit but I don't want to do any kind of copyright
> infrigement.

You should set the Author field to Sebastian, which will result in a
"From:" line at the top of the message body when sending patches via
e-mail.

-Scott
