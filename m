Message-ID: <38B3D22A.A87DB453@wanadoo.fr>
Date: Wed, 23 Feb 2000 13:27:22 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: jjs <Jerry.Sexton@insignia.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: gdb and multi-threaded applications.
References: <001101bf7de6$07263dc0$571170c1@honda.isltd.insignia.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


jjs wrote:
>
> I recently installed linuxppc-1999 on my beige G3. The main motivation for
> doing this was to debug a multi-threaded application, which I could not do
> under the Release 4 that I previously had installed.
>
> The version of gdb that comes with the distribution (which I got from
> ftp.linuxppc.org) is 4.17.0.11, which is not multi-thread aware. I therefore
> got hold of the sources for 4.17 from ftp.gnu.org and H.J.Lu's patches for
> 4.17.0.14 and compiled up the resulting sources. According to the release
> notes for 4.17.0.14, the change form 4.17.0.11 to 4.17.0.12 adds support for
> LinuxThreads on PowerPC, so the version I have should work for
> multi-threaded applications. However, typing 'info threads' on the
> resultingexecutable, just returns me to the gdb prompt. Typing 'thread 1',
> yields the message 'Thread ID 1 not known. Use the "info threads" command to
> see the IDs of currently known threads.'. According to the gdb info, this is
> typical behaviour of a gdb that does not have multi-threaded support.

Franz Sirl has a gdb-4.18-4d RPM in his directory at devel.linuxppc.org.
His version 4.18-4c is also contained in the dev-rel-1.1. You might want
to try these.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
