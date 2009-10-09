Return-Path: <RFeany@mrv.com>
Received: from bos-spam.mrv.com (mx5.mrv.com [140.179.254.12])
	by ozlabs.org (Postfix) with ESMTP id E96F9B7B8E
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 17:47:03 +1100 (EST)
Date: Thu, 8 Oct 2009 23:46:49 -0700
From: Rex Feany <RFeany@mrv.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH 0/6] 8xx MMU fixes
Message-ID: <20091009064649.GA9660@compile2.chatsunix.int.mrv.com>
References: <1255008298-19949-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091009001527.GA6196@compile2.chatsunix.int.mrv.com>
	<OF505AFA1E.D2D84793-ONC125764A.0020E20A-C125764A.00210186@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF505AFA1E.D2D84793-ONC125764A.0020E20A-C125764A.00210186@transmode.se>
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

> Rex Feany <RFeany@mrv.com> wrote on 09/10/2009 02:15:27:

> > open("/proc/mounts", O_RDONLY)          = 3
> > fstat64(0x3, 0x7fe7e2a8)                = 0
> > mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3001f000
> > read(3, 0x3001f000, 1024)               = -1 EFAULT (Bad address)
> > exit_group(0)                           = ?
> 
> Try making the tlbil_va in fault.c unconditional, just to make sure
> there isn't any old TLBs  around.

didn't make a difference
