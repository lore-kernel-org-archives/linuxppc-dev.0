Message-ID: <3BB8F007.C68D53B6@comdev.cc>
Date: Mon, 01 Oct 2001 15:36:55 -0700
From: Adam Wozniak <adam.wozniak@comdev.cc>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppcdev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: crash in fault.c
References: <3BB8B3AC.3A97D7D@comdev.cc> <20011001193753.838@smtp.adsl.oleane.com> <3BB8C658.38832E91@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:
>
> I suspect this is a hardware configuration problem in the
> memory controller or memory interface.  As I have always said,
> random problems that occur when the network is used usually
> point to that.  The reason is you can get back to back burst
> mode transfers to the memory, something you aren't likely
> to see with just normal CPU usage.

Ok.  I'm a little new to this.  How do I start troubleshooting
"a hardware configuration problem in the memory controller or
memory interface" ?

I'm using PPCBoot for a boot monitor, and VisionProbe for a JTAG
debugger.  I've run a number of RAM tests, and don't seem to have
any problems reading/writing to RAM.  What kind of thing am I
looking for?

--Adam
--
Adam Wozniak (KG6GZR)   COM DEV Wireless - Digital and Software Systems
awozniak@comdev.cc      3450 Broad St. 107, San Luis Obispo, CA 93401
                        http://www.comdev.cc
                        Voice: (805) 544-1089       Fax: (805) 544-2055

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
