Subject: preliminary HFS+ support
To: linuxppc-dev@lists.linuxppc.org
Date: Fri, 14 Dec 2001 00:36:55 -0800 (PST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20011214083655.9F4B92B54A@marcus.pants.nu>
From: flar@pants.nu (Brad Boyer)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have just uploaded to Sourceforge a patch to add basic support for HFS+
to the 2.4 kernel. The patch should apply to about any 2.4 kernel, but I
haven't tried too many of them myself. This release can read directories,
as well as the data forks of normal files. That's about it. I'm sure
there will be many bugs found, but it was pretty stable for me. I know
the unicode handling isn't quite right, but it works for plain ASCII.
More features to come, and probably bug fixes as well.

http://sourceforge.net/projects/linux-hfsplus/

	Brad Boyer
	flar@allandria.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
