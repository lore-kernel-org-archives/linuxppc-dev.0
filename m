Subject: RE: Virtex II Pro/405GP
From: James Campbell <jcampbell@omnigon.com>
To: Peter.Davey@csiro.au
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: 
	<2F62FF8D9BD6F647BD924E3889D0F6077F7BB0@prex1-fy.preston.cmst.csiro.au>
References: 
	<2F62FF8D9BD6F647BD924E3889D0F6077F7BB0@prex1-fy.preston.cmst.csiro.au>
Content-Type: text/plain
Date: 18 Apr 2002 08:40:35 -0700
Message-Id: <1019144435.3138.20.camel@skoll.omnigon.com>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

The file you are looking for is "dp83865avh.pdf", which I can send to
you directly if you wish.

We chose the 83865 over the 83861 because they removed about sixty
superfluous pins, and really cleaned the interface up as well.  It turns
out that the 83861 had some serious problems at 10mbit as well, which
they have now decided to respin all the silicon in that series.

We went to the "Programmable World 2002" telecast here yesterday, and
those new Virtex II Pro chips look hot.  I guess MonteVista is doing
some sort of board support package for the 405 cores inside the fpgas,
but they did not go into any detail about what will be provided in the
ISE dev kits for linux, and what you will have to buy from MonteVista.


Cheers,

James Campbell

On Wed, 2002-04-17 at 22:50, Peter.Davey@csiro.au wrote:
> James,
> 	We currently have a board with an XC2V3000, MPC8260 and a serial
> backplane using S2064.  We are intending to move to the Virtex Pro to use
> the built in serial.  Your use of the DP83865 sounds interesting.  I
> couldn't find the data on National's website.  Do you have the chips yet?
> Also if you have the datasheet I would be grateful if you could email me a
> copy.
>
> Regards,
>
> Peter Davey
> CSIRO CMST
> Preston VIC
>
> Phone  +613 9662 7824
> Fax    +613 9662 7853

--
James Campbell          -|-   Embedded Systems Engineer
jcampbell@omnigon.com   -|-     Omnigon International
pgp:  DA57 E174 4769 1B9D D0DF 73E6 D639 D867 A576 A5AE
work: +1.760.804.8884 x 332       cell: +1.760.803.8476
--
I bestride this world like a Colossus.  A very small
Colussus.  Without a torch.  Made of meat.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
