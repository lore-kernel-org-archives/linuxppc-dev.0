Message-ID: <38DFD121.173F5883@embeddededge.com>
Date: Mon, 27 Mar 2000 16:22:41 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Tom Miles <tmiles@teltronics.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Swap space on Embedded Planet CLLF 860
References: <7143C7BA3BFAD2119AAC0008C7094B9965043E@postoffice2.teltronics.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Miles wrote:

> I am running linuxplanet-2.2.13.  I have since learned that the 860T Rev B3
> silicon has a bug in the data cache and since I disabled the data caching
> the kernel is stable.

I must have screwed up....there should be an option to enable the "CPU6"
software patches.  If not, I should probably post a patch......


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
