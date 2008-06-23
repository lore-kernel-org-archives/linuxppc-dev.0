Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 588BBDDEF9
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jun 2008 18:16:46 +1000 (EST)
Date: Mon, 23 Jun 2008 18:16:44 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/1] Change the default link address for pSeries zImage
	kernels.
Message-ID: <20080623081643.GI20457@bakeyournoodle.com>
References: <1a551391a3c4925271cc86cb2e957aaccb0b599c.1214208801.git.tony@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1a551391a3c4925271cc86cb2e957aaccb0b599c.1214208801.git.tony@bakeyournoodle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 23, 2008 at 06:13:23PM +1000, Tony Breeds wrote:
> Currently we set the start of the .text section to be 4Mb for pSeries.
> In situations where the zImage is > 8Mb we'll fail to boot (due to
> overlapping with OF).  Move .text in a zImage from 4MB to 64MB (well past OF).
> 
> We still will not be able to load large zImage unless we also move OF,
> to that end, add a note to the zImage ELF to move OF to 32Mb.  If this
> is the very first kernel booted then we'll need to moev OF manually by
> setting real-base.
> 
> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
> ---

Ooops should have said that this has been boot tested on power
3,4,5,5+,6 and JS20.  POWER4 firmware seems to have aproblem manually
reloacting realbase but asside from that it booted.

Yours Tony

  linux.conf.au    http://www.marchsouth.org/
  Jan 19 - 24 2009 The Australian Linux Technical Conference!
