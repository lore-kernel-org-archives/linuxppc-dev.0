Message-ID: <38FC86C6.21EBC05C@embeddededge.com>
Date: Tue, 18 Apr 2000 12:01:10 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
CC: Graham Stoney <greyham@research.canon.com.au>, Dan Malek <dan@netx4.com>,
        LinuxPPC Embedded Mailing List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Bizarre initrd problem on CLLF860T
References: <20000418075704.C3E833C970@elph.research.canon.com.au> <kfybt37pyzg.fsf@kieraypc01.p.y.ki.era.ericsson.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Marcus Sundberg wrote:

> I'd suggest keeping the C-version of set_dec() in ppc/kernel/time.h
> where it used to be and change it to the followingcode :

I just use whatever comes from the Linux/PPC development tree.  It
seems to move around depending upon what compiler bugs exist at the time.
It may also be necessary to make this a real function for RT/Linux support.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
