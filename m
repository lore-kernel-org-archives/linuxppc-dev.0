Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5D4FBDDD04
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Aug 2007 00:50:55 +1000 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1IOwyL-0004fq-Tb
	for linuxppc-dev@ozlabs.org; Sat, 25 Aug 2007 09:50:47 -0500
To: linuxppc-dev@ozlabs.org
Subject: Git Clone/Fetch Advice
Date: Sat, 25 Aug 2007 09:50:45 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IOwyL-0004fq-Tb@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Folks,

As someone who runs a git server _and_ reads their log files,
I would like to offer a few words of advice about cloning or
fetching git repositories.

First, watch those project path names carefully.  If someone
publishes a "linux-2.6-quux.git" repository, don't call it
the "linux-2.6.git" repository in your clone or fetch request.
And, oddly, don't call it "linux-2.6.quux.git" either! :-)

Second, upgrade your git installation.  I repeatedly see failed
clone requests due to outdated git clients trying to do a clone
or a fetch.  If you _know_ you have the clone path to the project
right, and it still doesn't seem to work, chance are very good
that you are using a git earlier than v1.4.2.  It is now time
to find something v1.5 or better.  1.5.3 is due out Real Soon Now!

I publish a _few_ repositories, and I see maybe 20 or 30 such
failed clone/fetch requests per day.  I hate to imagine what
the failure rate on kernel.org is!

Thanks,
jdl
