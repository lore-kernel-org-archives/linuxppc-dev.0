Date: Mon, 17 Nov 2003 08:55:45 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Cc: Alan Modra <amodra@bigpond.net.au>,
	Kumar Gala <kumar.gala@motorola.com>, benh@kernel.crashing.org,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	David Edelsohn <dje@watson.ibm.com>
Subject: Re: kernel oops due to unaligned access with lswi
Message-ID: <20031117075545.GA7821@suse.de>
References: <20031115210449.GA10105@suse.de> <20031115222430.GA13820@suse.de> <200311152230.hAFMUwT32990@makai.watson.ibm.com> <20031115224342.GA16897@suse.de> <200311152259.hAFMxGT27464@makai.watson.ibm.com> <1068977831.681.8.camel@gaston> <3C0F7C71-185D-11D8-976A-000393DBC2E8@motorola.com> <20031116221932.GD14287@bubble.sa.bigpond.net.au> <16312.7017.405972.816440@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <16312.7017.405972.816440@cargo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Mon, Nov 17, Paul Mackerras wrote:

> Olaf, do we know what the source and destination addresses were?

source was c0fe4ffa, I cant reproduce it righht now to get the
destination address.

--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
