To: Marco Schramel <Schramel.Linux@go.bartec.de>
Cc: "PPC_LINUX" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Init hangs 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 05 Aug 2004 17:28:52 +0200."
             <200408051728.52442.Schramel.Linux@go.bartec.de>
Date: Thu, 05 Aug 2004 19:48:52 +0200
Message-Id: <20040805174857.A42F4C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Marco,

in message <200408051728.52442.Schramel.Linux@go.bartec.de> you wrote:
>
> i started ethereal and saw that the NFS read calls from target to host, are answered with two IP "fragmented IP protocols" by the host,
> followed by a NFS read reply [Unreassembled Packet] by the host, too. And that goes on and on until the connection is dead.
> I am not sure whether the fragmentation of ip in two packets is correct? There is no additional traffic it is "only" mounting and using rootfs over NFS.

The fragmentation is OK, but this is not what you're looking for.

You should see a couple of LOOKUP calls, probably in the sequence  of
/dev, console, sbin, init, lib, ld.so.1, and so on. Find out what the
last succesful lookup call was, and what happens after this.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A metaphor is like a simile.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
