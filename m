Message-ID: <3E8E31AD.3050302@mvista.com>
Date: Fri, 04 Apr 2003 19:30:21 -0600
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Darin.Johnson@nokia.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: glibc vs. newlib
References: <F0B628F30F48064289D8CCC1EE21B7A80C4869@mvebe001.americas.nokia.com>
In-Reply-To: <F0B628F30F48064289D8CCC1EE21B7A80C4869@mvebe001.americas.nokia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Darin.Johnson@nokia.com wrote:
> What are the experiences and tradeoffs of using newlib vs. glibc?  I'm targetting 16M board (maybe some 8M), no swap space, and I'm concerned that adding glibc will suck much of this up.  At the same time we'd also like to be able to use off-the-shelf components like dhcpd or telnetd, and are not sure if newlib would give us too many headaches there.
>
> Darin Johnson

I strongly recommend you stay away from newlib.

My recommendation is to use glibc "optimized"  (there are numerous programs that
will re-link glibc based on particular requirements you may have.)

Or if you need a more "generic solution" look into uclibc.

--Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
