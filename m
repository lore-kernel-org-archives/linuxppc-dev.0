Date: Fri, 15 Mar 2002 13:05:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: andrew may <acmay@acmay.homeip.net>
Cc: linuxppc-embedded@lists.linuxppc.org, Armin <akuster@pacbell.net>
Subject: Re: [PATCH] another for ibm_ocp_enet gzip'd
Message-ID: <20020315200558.GG691@opus.bloom.county>
References: <20020315114137.A26609@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020315114137.A26609@ecam.san.rr.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Mar 15, 2002 at 11:41:37AM -0800, andrew may wrote:

> 3. added mal.sh to generate a new ibm_ocp_mal.c
>         mal.sh  DCRN_MAL_BASE >ibm_ocp_mal.c
> or      mal.sh  DCRN_MAL_BASE DCRN_MAL1_BASE >ibm_ocp_mal.c
> will work. It seems that the second on generates a smaller
> object file even though the code is bigger for the 405GP.
> I would think it is because MAL1 is 0.
> This condenses all the get/set mal calls into one for get
> and one for set. I also changed mal_num to mal, just to help
> me find/change things.
>
> I think this is a better approach than what was in the _mal.c,
> but I didn't change the makefile to generate the code on the
> fly yet.

This looks very cool.  Can you add in some comments to the shell script,
and I didn't see any bashisms in there, can you verify it works with
pdksh or one of the other script shells which can be /bin/sh ?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
