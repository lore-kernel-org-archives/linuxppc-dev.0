Return-Path: <simon@fire.lp0.eu>
Received: from proxima.lp0.eu (proxima.lp0.eu [85.158.45.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "proxima.lp0.eu",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 22BD6DDEB8
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 05:56:13 +1000 (EST)
Message-ID: <463649D5.9000406@simon.arlott.org.uk>
Date: Mon, 30 Apr 2007 20:56:05 +0100
From: Simon Arlott <simon@fire.lp0.eu>
MIME-Version: 1.0
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: Revert "[POWERPC] <various>"
References: <46362B14.6090106@simon.arlott.org.uk>
	<20070430194911.GA1156@aepfle.de>
In-Reply-To: <20070430194911.GA1156@aepfle.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 30/04/07 20:49, Olaf Hering wrote:
> On Mon, Apr 30, Simon Arlott wrote:
> 
>> There are a few powerpc patches plus reverts in the recent push to 
>> torvalds/linux-2.6 - shouldn't this be avoided whenever possible because it 
>> could cause problems for people trying to use git bisect?
> 
> The reverts do not cause compile failures (I hope).
> You may lose IDE if you happen to debug something on Pegasos.
> I'm sure the real bisect breakers are elsewhere.

The reverts themselves are not the real problem, a git bisect could occur 
between the commit adding it and the one that reverts it. If that commit 
introduced a bug then surely it would be better to avoid releasing it 
elsewhere even if it will be reverted in the same batch.

Of course, this is probably difficult to do with git and impossible if 
someone has cloned the bad commit already and tries to pull :/

Is it possible to mass copy all the good commits to create a clean branch?

-- 
Simon Arlott
