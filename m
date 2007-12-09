Return-Path: <gvb.linuxppc.dev@gmail.com>
Received: from QMTA05.westchester.pa.mail.comcast.net
	(qmta05.westchester.pa.mail.comcast.net [76.96.62.48])
	by ozlabs.org (Postfix) with ESMTP id EF48FDDE10
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Dec 2007 16:21:07 +1100 (EST)
Message-ID: <475B7B41.4000505@gmail.com>
Date: Sun, 09 Dec 2007 00:21:05 -0500
From: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Stupid git question: adding acked-by
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

OK git gurus, this is something I have not figured out: the best way to 
add acked-by (or additional signed-off-by) lines to git patches.

What I'm talking about is when I've applied a patch to my repo and 
published the change on the list and get an "acked-by" back.  By the 
time I get the ack, the acked patch may be several patches deep.  My 
current technique is to reset the repo, edit the patch(es) to add the 
"acked-by" lines, and then re-apply the patches.  PITA and probably the 
stupidest way.

Stacked git should work (effectively does the same thing but more 
gracefully), but I have not gone that route yet.

There must be a better way, if only I could find the right (of 137) 
git-* command...

Hints, please?

Thanks,
gvb
