Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17432.31197.789876.815753@cargo.ozlabs.ibm.com>
Date: Thu, 16 Mar 2006 07:32:29 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: please pull powerpc-merge.git
In-Reply-To: <Pine.LNX.4.64.0603150748380.3618@g5.osdl.org>
References: <17431.43915.712222.861194@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0603150748380.3618@g5.osdl.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus Torvalds writes:

> Umm. What _have_ you done to that tree?

Just stuffed up the objects/info/alternates file.  It's fixed now.

> Please just do "git push" to push to master.  Use the "-f" flag if you
> want to force it because you did bad things.  Don't use rsync.  rsync on
> git repos is evil and wrong when there are other alternatives, and leads
> to crap like the above. 

OK, will do.

Paul.
