Date: Sat, 8 Mar 2003 04:37:18 +1100
From: Anton Blanchard <anton@samba.org>
To: Dan Malek <dan@embeddededge.com>
Cc: Nathan Ingersoll <ningerso@ruralcenter.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Runtime Altivec detection
Message-ID: <20030307173717.GA22556@krispykreme>
References: <20030307164753.GA5240@ruralcenter.org> <3E68D5BF.1050906@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E68D5BF.1050906@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> For some time now the Linux kernel has provided support for emulating
> the 'mfspr rd, PVR' instruction in user space.  Do this once, get the
> PVR and determine the processor type.

That will fail on a ppc64 box since we havent implemented that
emulation.

Anton

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
