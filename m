From: "Jeffrey D. Kowing" <jeffrey.d.kowing1@jsc.nasa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15456.30159.56888.598661@igor.jsc.nasa.gov>
Date: Tue, 5 Feb 2002 18:16:15 -0600
To: Hollis Blanchard <hollis@austin.ibm.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: io.h and I/O port access from user space
In-Reply-To: <1012950466.1350.17.camel@granite>
References: <15456.16854.183292.343027@igor.jsc.nasa.gov>
	<1012945690.1265.11.camel@granite>
	<15456.23060.255087.831957@igor.jsc.nasa.gov>
	<1012950466.1350.17.camel@granite>
Reply-To: jeffrey.d.kowing1@jsc.nasa.gov
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hollis Blanchard writes:
 > Have you tried enabling CONFIG_PNP and CONFIG_ISAPNP? That's all I had
 > to do to get ISA PnP working for an onboard sound card here.

Yes, I had tried that but all I got was the following message on my
console during bootup:

isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found

I did notice that on my Redhat 7.1 host machine I have a
/usr/lib/modules/modules.isapnpmap file that I lack the equivalent for
on my target powerpc machine.  The file is a listing of
vendor/device/function ids.  Perhaps this may be important for the
CONFIG_ISAPNP functionality?  Any suggestions or pointers welcome !

Anyways, thanks for the suggestion.  I guess I need to go educate
myself on the PnP protocol a bit more.

Regards,
Jeff

--
Jeff Kowing
jeffrey.d.kowing1@jsc.nasa.gov

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
