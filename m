Message-ID: <39B5546F.A1A9857@wanadoo.fr>
Date: Tue, 05 Sep 2000 22:15:43 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Kaoru Fukui <k_fukui@highway.ne.jp>
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: copy_to_user_ret in 2.4.0-test8
References: <20000906044141.Postino-015892@smtp01.highway.ne.jp>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kaoru Fukui wrote:
>
> Hi!
>
> I tried to compile today's linux-2.4.0-test8.
> rtc.c has copy_to_user_ret untill,
> but new uaccess.h hasn't copy_to_user_ret.
> So I couldn't compile today's 2.4.0-test8.

Yes. While this one is easy to fix (see drivers/sbus/char/rtc.c), you
should probably be grateful that it didn't work :-) I got it to compile
and boot, and it destroyed 3MB worth of personal mail. There are reports
by others on the linux kernel list about similar experiences. It is
possible that the fix is a simple swap of "1" and "0" in
fs/ext2/inode.c:all_zeroes(), but until this is confirmed, I for my part
will stay at a safe distance from this version.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
