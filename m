Return-Path: <tkil@scrye.com>
Received: from mail.scrye.com (scrye.com [75.148.32.185])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "mail.scrye.com", Issuer "mail.scrye.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8A8742C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 May 2013 10:34:47 +1000 (EST)
Message-ID: <5180631F.6080106@scrye.com>
Date: Tue, 30 Apr 2013 18:34:39 -0600
From: Anthony Foiani <tkil@scrye.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: ppc/sata-fsl: orphan config value: CONFIG_MPC8315_DS
References: <1367345751.24133.0@snotra>
In-Reply-To: <1367345751.24133.0@snotra>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "Robert P.J.Day" <rpjday@crashcourse.ca>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>, Jeff Garzik <jeff@garzik.org>,
 Adrian Bunk <bunk@stusta.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott --

Thanks for the quick reply / review!

On 04/30/2013 12:15 PM, Scott Wood wrote:
> [The devtree approach] might be OK for a new board, but adding it now 
> means that people using existing device trees won't get the 
> workaround.  It might be better to just put the knowledge in platform 
> code.

That would be fantastic, if I knew what to test.

If you look at the thread from last year, it seems that even there in 
Freescale, nobody knows exactly what triggers this.

There was the "orphan" config value, and I simply turned that into a 
devtree switch.

If you can find an answer inside Freescale, I can try to respin the 
patch to accommodate that knowledge.  But until then, this is the best I 
can do.

(And it's not a new board -- it's based on the 8315ERDB, and the 
orphaned symbol is apparently related to another 8315 board that never 
got released?)

> Please use standard Linux coding style, 

Huh.  I thought I had.  I'll double-check.

> and submit the patch inline rather than as an attachment (e.g. use git 
> send-email).

Will see if I can do so.  I don't actually have any sort of MTA set up 
on this machine, hence these Thunderbirded messages.

Thanks again,
Anthony Foiani
