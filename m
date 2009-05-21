Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id 7113EDE15A
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 02:24:22 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id j37so284748waf.9
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 09:24:20 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v4 0/3] Add support for ML510 board
To: linuxppc-dev@ozlabs.org, Roderick Colenbrander <thunderbird2k@gmail.com>
Date: Thu, 21 May 2009 10:24:17 -0600
Message-ID: <20090521162202.10880.34056.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Heck, I don't know if this stuff even works, but I've refactored
Roderick's patches into something closer to the structure that I'd like
to see.  There are still a few things that bother me, but I think it
is mostly there.

It at least boots on an ML507 board.

Roderick, can you please take a look?

Thanks,
g.

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
