Date: Thu, 30 Aug 2001 09:21:50 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: HHL 2.0 Journeyman and SuSE Linux
Message-ID: <20010830092150.O18618@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010830175217.H858@zax> <3B8DFF2F.44AFE98F@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3B8DFF2F.44AFE98F@imc-berlin.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Aug 30, 2001 at 10:54:07AM +0200, Steven Scholz wrote:

> is it possible to install and use the HHL 2.0 Journeyman Edition on a
> SuSE Linux 7.x machine?

Possibly.  The RedHat rpms should 'just work'.  Or you can download the
source rpms and compile the host tools for your setup.  The target binaries
are all the same.

> It looks like Journeyman only (!) suports Red Hat as a development host?
> Is that right?

Yes.  We also provide the source however.  And everything goes into /opt
anyways.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
