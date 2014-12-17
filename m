Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 915941A050D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Dec 2014 14:45:00 +1100 (AEDT)
Date: Wed, 17 Dec 2014 14:44:59 +1100
From: Anton Blanchard <anton@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 1/3] powerpc: Don't use local named register variable in
 current_thread_info
Message-ID: <20141217144459.09701a76@kryten>
In-Reply-To: <5490D981.7040905@suse.de>
References: <1414727247-31838-1-git-send-email-anton__19440.5086375356$1414727300$gmane$org@samba.org>
 <5490D981.7040905@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ulrich.weigand@de.ibm.com, paulus@samba.org,
 Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Alex,

> Git bisect managed to point me to this commit as the offender for
> OOPSes on e5500 and e6500 (and maybe the G4 as well, not sure).
> 
> Doing a git revert of this commit on top of linus/master makes things
> work fine for me again.

Ouch, sorry for that, I'll work to reproduce. What gcc version are you
using?

Anton
