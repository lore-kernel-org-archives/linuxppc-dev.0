Message-ID: <3C94FB7B.5040007@amberdata.demon.co.uk>
Date: Sun, 17 Mar 2002 20:24:27 +0000
From: David Monro <davidm@amberdata.demon.co.uk>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: Michael Sokolov <msokolov@ivan.Harhan.ORG>,
	linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] My GT-64260 enhancements
References: <0203170703.AA00587@ivan.Harhan.ORG> <3C94D78E.3010100@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:
 >
 > Michael Sokolov wrote:
 >
 >> But Troy's personal preferences shouldn't affect the public tree, should
 >> they? If 9600 is the default baud rate for all of Linux, why
 >> should one port be different?
 >
 >
 > I didn't know there was a "default" baud rate for Linux.  I think
 > the lowest I have ever seen is 9600, but I certainly wouldn't call
 > it a default.  It seems every one of the boards I have uses
 > something different,
 >
The default for just about any unix box (and an awful lot of other
things - network switches etc) seems to be 9600 8N1, partly because even
ancient terminals can cope with that (a lot of older ones don't go past
38400 for example). Allowing an override is fine, but leaving the
default at 9600 will follow the 'path of least surprise'.

Cheers,

	David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
