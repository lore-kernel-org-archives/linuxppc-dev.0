Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Wed, 2 Apr 2003 12:46:22 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Cc: Matt Porter <porter@cox.net>,
	Jean-Denis Boyer <jdboyer@mediatrix.com>,
	kas turi <inox_kas@yahoo.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Disabling data cache
Message-ID: <20030402194622.GA30107@ip68-0-152-218.tc.ph.cox.net>
References: <2702075D4DE2B043BF5EB82E9CFAD45B763543@mail1.mediatrix.com> <20030402094037.A31751@home.com> <3E8B3895.5050908@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E8B3895.5050908@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Apr 02, 2003 at 02:23:01PM -0500, Dan Malek wrote:
>
> Matt Porter wrote:
>
> >On Wed, Apr 02, 2003 at 09:28:21AM -0500, Jean-Denis Boyer wrote:
> >
> >>There is a kernel configuration option for that: CONFIG_DCACHE_DISABLE.
> >>In the kernel configuration UI, look into the section 'MPC8260 CPM
> >>Options'.
> >
> >
> >There is no code backing that option in linuxppc_2_4_devel, it is useless.
>
> It was orginally done for 8xx processors.  I suspect someone (I don't
> think it was me) :-) tried to consolidate 8xx and 82xx CPM configurations
> and messed it up.

My guess and recollection is that the 8260 version of this was to
disable the DCACHE in a certain manner, because of buggy silicon on a
specific board.  Someone unmerged this bit of code later I think.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
