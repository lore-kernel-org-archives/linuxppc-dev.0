Subject: FW: timesys linux on RPX-classic
From: Bill von Hagen <bill.vonhagen@timesys.com>
To: Linux PPC Embedded List <linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain
Date: 04 Mar 2002 16:20:49 -0500
Message-Id: <1015276851.18664.65.camel@wvh.timesys>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Though our customer support manager already repsonded to the person who posed the initial question about TimeSys Linux on the RPX-Classic, I thought that we'd forward his response to the list to help ensure that no one else experiences the same problem.


  Bill

-----------------
Bill von Hagen
Content Manager
TimeSys Corp

-----------------
From: Ference, Barry
Sent: Wednesday, February 27, 2002 2:56 PM
To: 'crax4ever@yahoo.com'
Subject: timesys linux on RPX-classic

William,

The answer to your question is found below.


> > Hi,
 > >
 > > We just bought a RPX-classic from EmbeddedPlanet,
 > > and I downloadded the linux image from
 > > www.timesys.com.
 > >
 > > I got the linux image to boot in the board.  But while
 > > in init, it stopped.  It always stopped after
 > > rc init at run level 2.  then it just print out:
 > > "....b" on the console then stopped.
 > >
 > > can anyone help us at this case?
 > >
 > > thanks
 > >
 > > sincerely
 > >
 > > William Wu
 > >


You have to change the baud rate of minicom/seyon to 115200 in order
to see the login prompt. Also, flow control needs to be turned off.

Note: the default rate for the boot monitor on this board is 9600.

FYI - All of our TimeSys Linux GPL kernels are free to download.
However, we do have support packages that customers can purchase
for these products. To find out more information on our GPL support
packages go to :

     http://www.timesys.com/gpl/index.phtml

--------------------------
Barry Ference
Manager - Customer Service
1-412-232-3250 x280
1-888-432-TIME
www.timesys.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
