Message-ID: <388F677E.59321B87@netx4.com>
Date: Wed, 26 Jan 2000 16:30:38 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Alan Mimms <alan@packetengines.com>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc-embedded: main kernel tree
References: <388F3D65.3B420FED@ctam.com.au> <00012611055301.05597@alan.corp.packetengines.com> <388F4CCF.661A2D75@netx4.com> <00012613095603.05597@alan.corp.packetengines.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alan Mimms wrote:

> Thank you.  However, since I started out with the 2.2.13 sources and found
> they just didn't work really at all on the CLLF


Huh?  They should.  The only bug was the FEC driver.


> .......  Do you have a feeling
> for whether the CLLF board will work with 2.3.18?


As well as anything else will.....

> ...  Certainly the 2.2.13 from
> the ftp.us.kernel.org did NOT work, even configured precisely as your kernel
> was configured.


Of course not.  I sometimes wonder why I bother posting messages
and writing development notes......The 2.2.xx kernels do not have
any up to date 8xx functions.  You must use the tar files from
ppc.kernel.org that I have updated......




	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
