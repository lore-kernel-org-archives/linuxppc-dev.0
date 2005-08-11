Return-Path: <becky.bruce@freescale.com>
In-Reply-To: <20050811201821.GY3187@smtp.west.cox.net>
References: <20050811195927.GX3187@smtp.west.cox.net>
	<BF36E655-9534-4FCD-9EB3-A1CD36C7981D@freescale.com>
	<20050811201821.GY3187@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e14ba87891c3c976056fe2bac0e1ef19@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
Date: Thu, 11 Aug 2005 17:41:36 -0500
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Re: RFC: proposed arch/powerpc directory structure
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>
>>> I don't like the idea of sticking subdirs in classic32/ either, but
>>> also
>>> can't think of a better name for the catchall of 7xx and 74xx boards.
>>
>> I dont think we where planning on subdirs in classic32.
>
> I took "may collapse into classic 32 at some point" to mean "move into
> classic32/ at some point", for some reason.  collapsing the content 
> into
> classic32/ will bring us back to the bad-old-days of everything in
> platforms/ (or kernel/).

My apologies - this wasn't at all clear in the proposal.  The plan at 
present is to not have subdirs under classic32.  By "collapsing into 
classic32", I meant a move to a more common code base, not a wholescale 
copy of the existing files into classic32.

Cheers,
-B
