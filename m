Message-ID: <3E68D5BF.1050906@embeddededge.com>
Date: Fri, 07 Mar 2003 12:24:15 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Nathan Ingersoll <ningerso@ruralcenter.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Runtime Altivec detection
References: <20030307164753.GA5240@ruralcenter.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Nathan Ingersoll wrote:

> I've recently been working on some Altivec optimizations for a library,
> and was looking for a relatively clean way to perform runtime detection.

For some time now the Linux kernel has provided support for emulating
the 'mfspr rd, PVR' instruction in user space.  Do this once, get the
PVR and determine the processor type.

You can also just read /proc/cpuinfo and search for the 'cpu :' line.
It will indicate the processor type and if altivec is supported.

There are probably other ways as well....


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
