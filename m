Return-Path: <fthain@mail.telegraphics.com.au>
Received: from mail.telegraphics.com.au (www.telegraphics.com.au
	[204.15.192.19]) by ozlabs.org (Postfix) with ESMTP id EB1C6B7C59
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Mar 2010 14:57:44 +1100 (EST)
Date: Wed, 10 Mar 2010 14:48:13 +1100 (EST)
From: fthain@telegraphics.com.au
To: Michael Beardsworth <mbeards2@uoregon.edu>
Subject: madness, was Re: [PATCH 2/2] Macintosh: fix coding style issues in
	adb.c This is a patch to the adb.c file that cleans up many warnings
	found by the checkpatch.pl tool
In-Reply-To: <1268172438-76422-1-git-send-email-mbeards2@uoregon.edu>
Message-ID: <alpine.LNX.2.00.1003101428460.4583@nippy.intranet>
References: <1268172438-76422-1-git-send-email-mbeards2@uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: monstr@monstr.eu, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	geert@linux-m68k.org, Nick Savage <nagaten@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Tue, 9 Mar 2010, Michael Beardsworth wrote:

> -	/* If a probe is in progress or we are sleeping, wait for it to complete */
> +	/* If a probe is in progress or we are sleeping, wait until complete */

If you must "fix" what aint broke, please try not to damage it. I'm sorry 
if your VT52 is limited to 80 cols, but IMNSHO this sort of effort is 
misguided.

Maybe I could point out again (I do this periodically) that checkpatch.pl 
is great but code that fails it is NOT always wrong.

"Check patch" is a good idea but "check existing code" is a waste of 
everyone's time.

Finn
