MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16181.43369.219750.258015@cargo.ozlabs.ibm.com>
Date: Sun, 10 Aug 2003 12:09:45 +1000
From: Paul Mackerras <paulus@samba.org>
To: Samuel Rydh <samuel@ibrium.se>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] 2.6 timebase synchronization
In-Reply-To: <20030809011305.GA12030@ibrium.se>
References: <20030808001523.GA9274@ibrium.se>
	<20030809011305.GA12030@ibrium.se>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Samuel Rydh writes:

> Attached is an improved version of the patch.

How many SMP machines are there where we don't know how to freeze/thaw
the timebase?  We know how to do that on the old powersurge powermacs,
on CHRP systems and on at least some of the recent core99 powermacs
(those that have a timebase-enable property on the cpu device nodes).
What machines are left?

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
