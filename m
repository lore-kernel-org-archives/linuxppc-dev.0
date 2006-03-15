Return-Path: <torvalds@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2BE87679E7
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Mar 2006 02:52:06 +1100 (EST)
Date: Wed, 15 Mar 2006 07:52:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: please pull powerpc-merge.git
In-Reply-To: <17431.43915.712222.861194@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0603150748380.3618@g5.osdl.org>
References: <17431.43915.712222.861194@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Wed, 15 Mar 2006, Paul Mackerras wrote:
> 
> Please do a pull from
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc-merge.git

Umm. What _have_ you done to that tree?

  error: object directory /home/paulus/kernel/linux-2.6/.git/objects does not exist; check .git/objects/info/alternates.
  error: object directory /home/paulus/kernel/linux-2.6/.git/objects does not exist; check .git/objects/info/alternates.
  Generating pack...
  error: object directory /home/paulus/kernel/linux-2.6/.git/objects does not exist; check .git/objects/info/alternates.
  error: Could not read a488edc914aa1d766a4e2c982b5ae03d5657ec1b
  error: Could not read 3759fa9c55923f719ae944a3f8fbb029b36f759d
  error: Could not read 153b1d3f0a5ec0760deef783e337e2164bfa1a68
  fatal: bad tree object 153b1d3f0a5ec0760deef783e337e2164bfa1a68
  Done counting 0 objects.
  Total 0, written 0 (delta 0), reused 0 (delta 0)
  Unpacking 0 objects

Hmm? Looks like you're _still_ using rsync to move git trees around, and
that is just not valid.

Please just do "git push" to push to master.  Use the "-f" flag if you
want to force it because you did bad things.  Don't use rsync.  rsync on
git repos is evil and wrong when there are other alternatives, and leads
to crap like the above. 

		Linus
