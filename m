To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Sandpoint 8240 or 7400
References: <524rylvl3d.fsf@love-boat.topspincom.com>
From: Roland Dreier <roland@topspincom.com>
Date: 26 Jan 2001 17:59:39 -0800
In-Reply-To: Roland Dreier's message of "26 Jan 2001 17:29:26 -0800"
Message-ID: <52zogdvjp0.fsf@love-boat.topspincom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


    Roland> Also, if I wanted to build my own kernel for a Sandpoint
    Roland> system, what source tree should I use?  And (forgive the
    Roland> naive question) how do I build a kernel image that I can
    Roland> send to the Sandpoint via the serial port and start from
    Roland> DINK32?  What are the prospects of being able to build a
    Roland> PPC kernel from Linus's tree?

Just to add a little info here... I managed to get 2.4.1-pre10 to
build for PPC and I got enough of a clue to boot zvmlinux.  However,
(at least on the 7400 board) that kernel also seems to stop in
openpic.

I guess my question is still whether anyone has booted Linux on a
Sandpoint 7400.

Thanks,
Roland


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
