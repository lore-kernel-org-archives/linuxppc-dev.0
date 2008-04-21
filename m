Return-Path: <cbouatmailru@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id DDC2FDE49C
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 08:04:47 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so692999uge.0
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 15:04:45 -0700 (PDT)
Date: Tue, 22 Apr 2008 02:04:40 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 5/5] [POWERPC] 83xx: new board support: MPC8360E-RDK
Message-ID: <20080421220440.GA25741@zarina>
References: <20080418190632.GA32204@polina.dev.rtsoft.ru>
	<20080418191009.GE4407@polina.dev.rtsoft.ru>
	<fa686aa40804211405mbe3f6beof07a3287d7157fbe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <fa686aa40804211405mbe3f6beof07a3287d7157fbe@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 21, 2008 at 03:05:25PM -0600, Grant Likely wrote:
> On Fri, Apr 18, 2008 at 1:10 PM, Anton Vorontsov
> <avorontsov@ru.mvista.com> wrote:
> > This is patch adds board file, device tree, and defconfig for the new
> >  board, made by Freescale Semiconductor Inc. and Logic Product Development.
> 
> >   arch/powerpc/platforms/83xx/mpc836x_rdk.c       |  106 +++
> 
> I don't see anything exotic in here.  This can be merged with one of
> the other non-exotic mpc83xx board files.  The dts parsing takes care
> of the differences.

Please name the board file in which you think I'll easily merge this
indeed non-exotic board.

The only QE boards there are: mpc832x_{rdb,mds} and mpc836x_mds. All of
them have board-specific fixups either in the machine_device_initcall()s
or setup_arch()s.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
