Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 9CA7EDF114
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 04:26:25 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 0/9] Rework PowerPC 44x board support
Date: Tue, 19 Aug 2008 20:26:12 +0200
References: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
In-Reply-To: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808192026.12632.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 19 August 2008, Josh Boyer wrote:
> The following patch series reworks the board support code for PowerPC 44x
> platforms.  It eliminates a number of redundant <board>.c files and add a
> ppc44x_simple.c file that has an explicit list of boards that are supported
> by it.  This is the same mechanism that Grant Likely has used for MPC 5200
> boards.
>
> It also adds some more explicit support for Glacier and Yosemite boards, as
> those boards were using a board level compatible property in their DTS
> files that was a bit confusing.
>
> Review would be appreciated.  Tested on Sequoia, and I plan on testing on
> as many boards as I can before committing to my tree.

Looks great at first glance. I'll try to do some testing here too in the next 
few days.

Thanks.

Best regards,
Stefan
