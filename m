Content-Type: text/plain;
  charset="iso-8859-1"
From: Trevor Woerner <ppc339@vtnet.ca>
Reply-To: ppc339@vtnet.ca
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: address translation
Date: Thu, 15 May 2003 23:13:13 -0400
References: <200305150729.36436.ppc339@vtnet.ca> <1052999180.1568.129.camel@hermes>
In-Reply-To: <1052999180.1568.129.camel@hermes>
MIME-Version: 1.0
Message-Id: <200305152313.13244.ppc339@vtnet.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On May 15, 2003 07:46 am, Gary Thomas wrote:
> On Thu, 2003-05-15 at 05:29, Trevor Woerner wrote:
> > I want to setup a mapping so that when anything tries to read/write
> > the 16 bytes at 0x1f0 - 0x1ff the actual physical memory that gets
> > accessed is 0xf7000000 - 0xf700000f.
>
> Perhaps a specialized device driver would be a better choice.

Unfortunately, that seems to be the path I'm going down.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
