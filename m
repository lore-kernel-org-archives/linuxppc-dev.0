Date: Fri, 20 Apr 2001 11:00:01 -0500 (CDT)
From: Ramprasad Rao <ramp@oddjob.uchicago.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: crash/hang/freeze with 2.4.3 or later
Message-ID: <Pine.GSO.4.10.10104201058510.18930-100000@oddjob.uchicago.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi everyone,

I keep having some hangs/freezes with kernels later than 2.4.3. This
basically happens when there is intense disk activity. It always happens
when there is an slocate cron job. This freeze does not occur with
2.4.3-pre6.

After this hang I have to physically boot the machine and almost always
the automatic fsck on boot fails.

I was wondering if there is something wrong with the kernel or my hard drive.

Thanks - Ram


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
