Message-ID: <382B66F8.BFE03655@jlc.net>
Date: Thu, 11 Nov 1999 20:01:44 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: bsimon@ctam.com.au
CC: linux-embedded <linux-embedded@waste.org>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: LinuxEmbedded: minimal network system packages.
References: <382B4396.57669F9B@ctam.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brendan Simon wrote:


> 
> Things I think I need are :
> * init

I don't run init, I just have the kernel start up with a
shell and runs /linuxrc to start whatever daemons I need.

> * mount (do I NEED this ?)

It's nice, because I at least mount /proc.

> * ifconfig (do I NEED this ?)

Depends how you start the embedded system.  If it is always part
of a network where a server can provide the necessary information
via BOOTP/DHCP, you don't need ifconfig.

> * inet

inetd....and associated network information files.


> Any pointers to documentation about getting a minimal embedded networked
> system up and running.

It's pretty straight forward.  Just think about what you need.  If
you have the "disk" space, you can go through the layers of rc.x and
sysconfig files, or just make a simple shell script to configure what
you need.  Do you want resolver library baggage or just use /etc/hosts?
Things like that.  It's a learning experience :-).


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
