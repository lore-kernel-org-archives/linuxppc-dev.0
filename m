Message-ID: <38968C21.23315043@netx4.com>
Date: Tue, 01 Feb 2000 02:32:49 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Brendan.Simon@ctam.com.au
CC: szg98@mail.zhongxing.com,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc8xx-2.2.13 kernel hangs during boot.
References: <48256878.00018A59.00@mail.zhongxing.com> <3896C7E6.D6B236B3@ctam.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brendan John Simon wrote:


> .....  Maybe the MMU requires the caches ?

No, but the MMU control registers contain cache modes to use
when the MMU is disabled.....which reminds me there could be
a bug if we are running copyback.....


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
