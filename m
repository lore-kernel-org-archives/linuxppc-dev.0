Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 98F42DDF69
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 12:09:42 +1100 (EST)
Date: Wed, 5 Dec 2007 04:09:27 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: John Tyner <jtyner@cs.ucr.edu>
Subject: Re: [PATCH] Fix 8xx compile errors
Message-ID: <20071205040927.4fa4e28f@kernel.crashing.org>
In-Reply-To: <20071203205837.GA22557@cs.ucr.edu>
References: <20071203205837.GA22557@cs.ucr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 3 Dec 2007 12:58:38 -0800
John Tyner wrote:

> Building for 8xx fails to compile due to errors in a couple of
> places. The first is due to the casting of an lvalue (if I remember
> correctly), and the second was due to the cpmp variable being
> declared static even though the headers previously defined it as
> extern. The following patch corrects these errors. The patch is
> against 2.4 since that's what I'm working with. (I've been unable to
> get 2.6 to run properly on my hardware so far.)
> 
> Please CC me on any responses since I'm not subscribed.
> 
You don't need these quirks with 2.6 and arch/powerpc... It does not use 8xx_io
and arch/powerpc/boot/* having a bit different meaning.

What is your platform btw? Adding something to 8xx camp should not be huge effort with powerpc... 

-- 
Sincerely, Vitaly
