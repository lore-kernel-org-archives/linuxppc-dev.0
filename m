Message-ID: <39D11274.A2AF2410@snmc.com>
Date: Tue, 26 Sep 2000 16:17:41 -0500
From: Daris A Nevil <dnevil@snmc.com>
MIME-Version: 1.0
To: "Dan A. Dickey" <ddickey@charter.net>
CC: Navin Boppuri <nboppuri@trinetcommunication.com>,
        linuxppc-embedded@lists.linuxppc.org, greyham@research.canon.com.au
Subject: Re: NFS problem- neighbout table overlow
References: <018601bfc7e6$30ab9560$4a1f76d8@washington> <39D10BB4.D6F1897@charter.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


When you see the "neighbour table overflow" message it simply means that
NFS cannot communicate with the server.  It could mean anything from a
bad cable, invalid IP setup, bad driver, incorrect driver setup, etc.
It really means that you are not successfully transporting IP packets.

Regards,
Daris Nevil


"Dan A. Dickey" wrote:
>
> Navin Boppuri wrote:
> > Hello Everyone,
> > I have been having problems with my custom board. The NFS mount does
> > not
> > work. The NFS request does not actually go the server. I dont see any
> > packets coming to the server from this board. I did have some ring
> > dump
> > problems. There were some errors in Port A setting which I fixed and
> > that is
> > gone now. By I still see 'neighbour table overflow' messages. What can
> > be
> > the problem?
>
> Navin,
> I can't say that I remember for sure - but I seem to recall
> this as being a problem in the Linux NFS implementation.
> Check through the linux-kernel archives for messages regarding
> the neighbour table overflow.  There may be a suggestion
> on how to solve this.  I know I remember something about this...
>         -Dan
>

--
Daris A Nevil
Simple Network Magic Corporation
401 Kentucky Lane
McKinney, TX 75069
214-793-7757
dnevil@snmc.com
www.snmc.com
quickstack.com
qslinux.org

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
