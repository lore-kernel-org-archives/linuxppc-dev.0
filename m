Message-ID: <20040511172318.88343.qmail@web21412.mail.yahoo.com>
Date: Tue, 11 May 2004 10:23:18 -0700 (PDT)
From: Huailin Chen <chen_huailin@yahoo.com>
Reply-To: huailin@xtrj.org
Subject: Re: IBM 750GX SMP on Marvell Discovery II or III?
To: Dan Malek <dan@embeddededge.com>,
	Paul Mackerras <paulus@samba.org>
Cc: Amit Shah <amitshah@gmx.net>, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <517E783F-A362-11D8-942E-003065F9B7DC@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> My experience has been that MPC750s work in a SMP environment on a 60x
> bus. Maybe I was just lucky? The way I read the manual, they should
> work with a proper memory controller.

750 MEI protocol does NOT support SMP well. Sure, you
are right. It works, but not that good.

Ideally, MESI + MPX Bus is the best one for SMP under
PPC arch. That's why need go to G4+ GT 64360.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
