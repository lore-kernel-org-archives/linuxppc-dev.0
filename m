Message-Id: <200311162304.hAGN4CT32140@makai.watson.ibm.com>
To: benh@kernel.crashing.org
Cc: Olaf Hering <olh@suse.de>, Alan Modra <amodra@bigpond.net.au>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: kernel oops due to unaligned access with lswi 
In-Reply-To: Message from Benjamin Herrenschmidt <benh@kernel.crashing.org>
   of "Sun, 16 Nov 2003 21:17:11 +1100." <1068977831.681.8.camel@gaston>
References: <20031115210449.GA10105@suse.de> <20031115222430.GA13820@suse.de> <200311152230.hAFMUwT32990@makai.watson.ibm.com> <20031115224342.GA16897@suse.de> <200311152259.hAFMxGT27464@makai.watson.ibm.com>  <1068977831.681.8.camel@gaston> 
Date: Sun, 16 Nov 2003 18:04:11 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Benjamin Herrenschmidt writes:

Ben> I remember beeing regulary told (I think by Apple while I was still
Ben> doing MacOS hacking) that those string instructions were evil,
Ben> deprecated, and should be avoided as they weren't peforming better
Ben> than the equivalent set of load/store instructions... Is this
Ben> still true ? In which case we may want to avoid generating them
Ben> from gcc..

	The information that you received about lwsi are overly
simplistic.  The instructions are neither overly good nor overly bad --
they should not be used for everything, but neither should they be avoided
at all cost.  They are particularly good for producing compact code and
preserving the instruction cache.  Remember, programming, including
assembly language programming, is an art.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
