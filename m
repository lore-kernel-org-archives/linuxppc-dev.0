Date: Thu, 6 Jun 2002 05:24:43 -0700
To: linuxppc-dev@lists.linuxppc.org
Cc: linux-fsdevel@vger.kernel.org
Subject: HFS+ support (read-only)
Message-ID: <20020606052443.A21838@pants.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: flar@pants.nu (Brad Boyer)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've just uploaded a new release of my hfsplus module. If anyone
would like to try it out, or critique my code, you can find it
on Sourceforge (I am currently using 2.4.18-pre7 as a base):

http://www.sourceforge.net/projects/linux-hfsplus/

This is still read-only, and no resource forks in any format,
but it can handle most standard UNIX features other than
hard links, which will show up as empty files. (Don't ask...)

I haven't had any stability problems, but the performance is
somewhat slow on a disk with a large number of files.

I appreciate any feedback or suggestions.

	Brad Boyer
	flar@allandria.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
