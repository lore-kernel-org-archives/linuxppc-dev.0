Subject: Re: 405LP compile fix
From: Hollis Blanchard <hollis@austin.ibm.com>
To: embedded list <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <1040154588.1100.171.camel@granite.austin.ibm.com>
References: <1040154588.1100.171.camel@granite.austin.ibm.com>
Date: 17 Dec 2002 17:31:55 -0600
Message-Id: <1040167916.1100.174.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2002-12-17 at 13:49, Hollis Blanchard wrote:
>
> This patch fixes the Beech build, which is calling the now-nonexistant
> function beech_time_init. In actuality beech_time_init was never called
> anyways... :)

Oops, I meant to say "beech_calibrate_decr was never called anyways",
but you knew what I meant...

-Hollis
--
PowerPC Linux
IBM Linux Technology Center

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
