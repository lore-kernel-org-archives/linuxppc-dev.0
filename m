To: brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: FW: Need openssh for embedded linux on 440GP
References: <995FF289C9D69747A09E42992644595405B236B3@penguin.adic.com>
From: Roland Dreier <roland@topspin.com>
Date: 12 Mar 2003 08:11:09 -0800
In-Reply-To: <995FF289C9D69747A09E42992644595405B236B3@penguin.adic.com>
Message-ID: <52zno0woo2.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


    brian> As an update to what's written below, I did try
    brian> cross-compiling and that was even less successful than
    brian> compiling on my embedded target.

I cross-compiled OpenSSH 3.5 for the 440GP.  I did have to go through
the "configure" file and hard-code all the tests that try to run
programs.

 - Roland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
