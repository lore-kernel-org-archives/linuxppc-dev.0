Return-Path: <jsamch@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.232])
	by ozlabs.org (Postfix) with ESMTP id 5DE2FDDE0D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Dec 2007 03:33:54 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id 68so1895956wri
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Dec 2007 08:33:53 -0800 (PST)
Message-ID: <169c03cb0712100833m36842bf7j95aab235f67b5250@mail.gmail.com>
Date: Mon, 10 Dec 2007 11:33:51 -0500
From: "Jean-Samuel Chenard" <jsamch@macs.ece.mcgill.ca>
Sender: jsamch@gmail.com
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: Xilinx ML310 Linux 2.6 PCI bridge
In-Reply-To: <20071210054659.D373C16006E@mail51-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <169c03cb0712082151k74e504bvc6e21bb57534ef28@mail.gmail.com>
	<fa686aa40712082218k7e520e45q1266ecb4692b7dbb@mail.gmail.com>
	<169c03cb0712090932y52cb2744p245cdeb0cccc2ff2@mail.gmail.com>
	<fa686aa40712091223x3efb1143kfd81277890fb74ae@mail.gmail.com>
	<20071210054659.D373C16006E@mail51-dub.bigfish.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Dec 10, 2007 12:46 AM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
> I would strongly recommend not spending a huge amount of time on the ml31=
0.
> The University program board is dirt cheap for universities, very well
> supported under Linux, using either secretlab.ca or git.xilinx.com and yo=
u
> won't spend your time getting PCI to place and route correctly, followed =
by
> figuring out how to get Linux to talk to it nicely.

Hi Stephen,

Thanks for the insight.  I was aware of the XUP V2P board and I think
this is a nice initiative to let students use some great technology.

>  If your lab can afford a bee2, then you should be able to afford one (or
> better yet, several) xupv2p's to go with it.

That's where things get complicated...  In our lab, we get expensive
hardware such as the BEE2 via CMC Microsystems (a Canadian granting
agency).  However, getting funds locally to buy other equipment is a
relatively long and administratively complex process...

One of my colleague did not use his ML-310 board so I got a hold of it
(in a day, with little overhead).  So far, the ML-310 has helped me
bring up Linux 2.6 and experiment most of what I need to use on the
BEE2.  I am only missing the networking.  This would make things much
nicer to work via a NFS-exported root file system.  However, I'm OK
swapping the CompactFlash card...

I find it strange that Xilinx would not invest in supporting Linux 2.6
for an important feature such as a PCI bridge (not specifically for
the ML-310, but in general) when this can bring many interesting
benefits to an embedded platform.  Is this something that is "in
progress" at Xilinx?  You seem to imply that most of the difficulty in
getting the PCI core working is in meeting the timing requirements
(not with the SW drivers), so I might be missing driver files when I
generate the BSP code for Linux 2.6.

Regards,

Jean-Samuel
--=20
Integrated Microsystems Laboratory
McGill University, Montr=E9al, QC, CANADA
Web Page: http://chaos.ece.mcgill.ca
