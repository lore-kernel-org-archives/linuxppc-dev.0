Return-Path: <RFeany@mrv.com>
Received: from bos-spam.mrv.com (mx5.mrv.com [140.179.254.12])
	by ozlabs.org (Postfix) with ESMTP id 8AB1CB7C35
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Oct 2009 07:25:46 +1100 (EST)
Date: Fri, 16 Oct 2009 13:25:41 -0700
From: Rex Feany <RFeany@mrv.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH 0/8]  Fix 8xx MMU/TLB
Message-ID: <20091016202541.GA16358@compile2.chatsunix.int.mrv.com>
References: <1255597466-30976-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091015165650.GA3837@compile2.chatsunix.int.mrv.com>
	<OFF665748B.AAF26319-ONC1257651.00296F23-C1257651.002D6BF7@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OFF665748B.AAF26319-ONC1257651.00296F23-C1257651.002D6BF7@transmode.se>
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thus spake Joakim Tjernlund (joakim.tjernlund@transmode.se):

> Right, it is the pte table walk that is blowing up.
> I just noted that 2.6 lacks a tophys() call in its table walk
> so I removed that one(there is one more tophys call but I don't think
> it should be removed).
> Try this addon patch:

no difference

take care!
/rex.
