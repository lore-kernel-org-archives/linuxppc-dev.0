Message-ID: <38515C9B.359D913@netx4.com>
Date: Fri, 10 Dec 1999 15:03:39 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Grant Carter <gcarter@eng.uct.ac.za>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel woes for versions > 2.2.5
References: <3850F28A.D36731A3@eng.uct.ac.za>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Grant Carter wrote:


> processor just hangs with no output on the console.

Take a look at arch/ppc/mbxboot/embed_config.c.  At the end
of this is the function for initializing the board information
structure.  Make sure you use the same information from the
kernel that is booting correctly, in particular assigning the
proper processor speed.  I have discussed this with Stuart of
BrightStar Engineering, and I haven't yet included a processor
speed variable in the environment variables.  The default
configuration is not correct for this processor, so you have
to assign the proper values here.  I am likely to have missed
this when making the last kernel update.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
