Message-ID: <3958FD77.97001F7A@netx4.com>
Date: Tue, 27 Jun 2000 15:16:07 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Jerry Van Baren <vanbaren_gerald@si.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PLPRCR & Checkstop reset
References: <Pine.LNX.3.96.1000625172850.17884A-100000@tristar.cc.absoval.com>
	 <3958E040.15B86909@netx4.com> <4.3.2.20000627142525.00b61100@falcon.si.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jerry Van Baren wrote:

> It would be better to not jump to the reset vector on a warm
> start.

Yes, but there isn't any standard among the 8xx boot roms.

This seems to work on all of the boards I have ever tested.  If
it doesn't work for you, let's discuss it and find something that
does.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
