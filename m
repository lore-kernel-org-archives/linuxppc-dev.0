Date: Thu, 21 Oct 1999 22:36:11 +0200 (CEST)
From: Michael Schmitz <schmitz@amber.biophys.uni-duesseldorf.de>
To: Wolfgang Denk <wd@denx.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Probing for (non-existing) memory?
In-Reply-To: <199910211928.VAA20201@denx.local.net>
Message-ID: <Pine.LNX.4.10.9910212233220.22319-100000@amber.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Thu, 21 Oct 1999, Wolfgang Denk wrote:

> please excuse the silly question: is there a standard way to probe an
> address if it is readable/writable memory? Ideally something that  is
> portable across all architectures?

Look at what copy_to_user or copy_from_user does to set up a temporary
page fault handler, so to speak. m68k has hwreg_present() so I'd start by
translating that to ppc assembly. 

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
