Subject: Re: kernel oops due to unaligned access with lswi
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@motorola.com>
Cc: Olaf Hering <olh@suse.de>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Alan Modra <amodra@bigpond.net.au>,
	David Edelsohn <dje@watson.ibm.com>
In-Reply-To: <3C0F7C71-185D-11D8-976A-000393DBC2E8@motorola.com>
References: <20031115210449.GA10105@suse.de>
	 <20031115222430.GA13820@suse.de>
	 <200311152230.hAFMUwT32990@makai.watson.ibm.com>
	 <20031115224342.GA16897@suse.de>
	 <200311152259.hAFMxGT27464@makai.watson.ibm.com>
	 <1068977831.681.8.camel@gaston>
	 <3C0F7C71-185D-11D8-976A-000393DBC2E8@motorola.com>
Content-Type: text/plain
Message-Id: <1069024357.4760.14.camel@gaston>
Mime-Version: 1.0
Date: Mon, 17 Nov 2003 10:12:38 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2003-11-17 at 04:49, Kumar Gala wrote:
> If Ben's comments are correct simply removing -mstring as an option
> passed to the build should get the desired behavior.

We surely don't want them on G5 at least as they are microcoded

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
