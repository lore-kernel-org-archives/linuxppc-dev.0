Message-ID: <400B289B.7020208@kegel.com>
Date: Sun, 18 Jan 2004 16:45:15 -0800
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: Anchi Shlomi-BSA021 <BSA021@motorola.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: LTP
References: <0F48024310E5D6118D200002B3A440DB09558ACD@zil01exm08.mcil.comm.mot.com>
In-Reply-To: <0F48024310E5D6118D200002B3A440DB09558ACD@zil01exm08.mcil.comm.mot.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Anchi Shlomi-BSA021 wrote:
> I have a custom 8270 board and a custom kernel.
 > I am trying to set up a test procedure to test the entire system.
 > Is there any source of tests for this (besides the LTP)?
 > The LTP looks too big to be ran on a target with low resources.

I've run the LTP on systems with 32MB RAM and no swap with good success.
Might be possible on 16MB systems, too.
You might want to mount the test programs via nfs...
- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
