Message-ID: <39099239.307199E6@student.ethz.ch>
Date: Fri, 28 Apr 2000 15:29:29 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: root <whschult@uncc.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Latest XFree86 v4.0 crashing (possible culprit sawmill)
References: <200004270502.AAA08920@lists.linuxppc.org>
	 <39090775.BFEECFA1@uncc.edu> <39092CEA.1321BC79@student.ethz.ch> <3909892A.41387BC1@uncc.edu>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


root wrote:

> I'm roughly familiar with gdb, but not enough to really know what I
> should be doing to help.  Where should I expect to find the core file,

The server doesn't normally dump core. I suggest you build a server with
'#define DoLoadableServer NO' uncommented in either
xc/config/cf/{xf86site,host}.def and run the server from gdb.

Beware that you'll most probably have to do that from a remote machine as you
won't have access to gdb's console otherwise.


> and what information do you need?

Where it crashes :)

Hint: Rebuild the file(s) it shows with makeg to see the actual code in gdb.


> Which log file do you need?

/var/log/XFree86.0.log

But sadly it's only rarely helpful in such cases.


Michel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
