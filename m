Message-Id: <200311162331.hAGNVjT29698@makai.watson.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kumar Gala <kumar.gala@motorola.com>, Olaf Hering <olh@suse.de>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Alan Modra <amodra@bigpond.net.au>
Subject: Re: kernel oops due to unaligned access with lswi 
In-Reply-To: Message from Benjamin Herrenschmidt <benh@kernel.crashing.org>
   of "Mon, 17 Nov 2003 10:12:38 +1100." <1069024357.4760.14.camel@gaston>
References: <20031115210449.GA10105@suse.de> <20031115222430.GA13820@suse.de> <200311152230.hAFMUwT32990@makai.watson.ibm.com> <20031115224342.GA16897@suse.de> <200311152259.hAFMxGT27464@makai.watson.ibm.com> <1068977831.681.8.camel@gaston> <3C0F7C71-185D-11D8-976A-000393DBC2E8@motorola.com>  <1069024357.4760.14.camel@gaston> 
Date: Sun, 16 Nov 2003 18:31:45 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Benjamin Herrenschmidt writes:

Ben> We surely don't want them on G5 at least as they are microcoded

	Again, one cannot approach this as black or white.  What about
optimizing for size?

david

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
