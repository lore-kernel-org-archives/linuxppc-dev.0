Message-ID: <405090F3.1000900@embeddededge.com>
Date: Thu, 11 Mar 2004 11:16:51 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: "Matthew S. McClintock" <mattsm@arlut.utexas.edu>
Cc: Jason McMullan <jason.mcmullan@timesys.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8560ADS issues
References: <1078945499.3748.4.camel@veena.timesys> <1079019785.29565.36.camel@chuck.arlut.utexas.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matthew S. McClintock wrote:

> What version of u-boot are you using? There was a patch around Feb. 24th
> that fixed some things in the ethernet driver for u-boot. Although since
> you seem to have the TSEC ports working it seems you have the latest
> version.

The TSECs work, but the FCCs don't.  I spend time here and there debugging
when I have a chance.


> I have not attempted to use the FCC in u-boot but I have it working in
> Linux, well sort of anyways... it is going extremely slow and I am still
> investigating that.

Do you keep up to date with the linuxppc trees?  Some of us have been
pushing lots of CPM updates lately.  We recently updated all of the
common code for 82xx and 85xx.  If this doesn't work there must be
some I/O or board configuration that is amiss.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
