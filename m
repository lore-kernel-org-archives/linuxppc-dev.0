Message-ID: <3EA94AA9.3070401@embeddededge.com>
Date: Fri, 25 Apr 2003 10:48:09 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: "Wells, Charles" <Charles.Wells@nielsenmedia.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: boot/simple in ROM?
References: <DF2B720CF774D21189EE00805FA7FA22051784AD@nmrusdunsx3.nielsenmedia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wells, Charles wrote:

> Where is the "standard Linux startup call" documented?

It's found in the code and in lots of archive discussions.
It boils down to building a board descriptor structure or
using bi_recs created at a known address.  The kernel is
uncompressed to location 0 and the bootloader jumps there
when finished.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
