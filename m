Message-Id: <200311152230.hAFMUwT32990@makai.watson.ibm.com>
To: Olaf Hering <olh@suse.de>
Cc: Alan Modra <amodra@bigpond.net.au>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: kernel oops due to unaligned access with lswi 
In-Reply-To: Message from Olaf Hering <olh@suse.de>
   of "Sat, 15 Nov 2003 23:24:30 +0100." <20031115222430.GA13820@suse.de>
References: <20031115210449.GA10105@suse.de>  <20031115222430.GA13820@suse.de> 
Date: Sat, 15 Nov 2003 17:30:57 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Olaf Hering writes:

Olaf> 2.6 has a function parse_header(), its part of gunzip and used for
Olaf> initramfs as example. I got an oops, exception 600, sig 7. I think that
Olaf> means unaligned access.

Olaf> +               memcpy(buf, s, 7 + j); /* s might be unaligned, gcc will optimized the call to lswi on ppc */

	lswi specifically accepts unaligned addresses.

david

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
