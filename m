Date: Tue, 19 Jan 1999 11:51:15 -0800 (PST)
From: "Ian K. Erickson" <ian@ns0.ipeg.com>
To: Brad Boyer <flar@cegt201.bradley.edu>
cc: Keith Jacob <kjacob@wantree.com.au>, linuxppc-user@lists.linuxppc.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: 15 partitions max prob revisited
In-Reply-To: <199901191033.EAA19277@cegt201.bradley.edu>
Message-ID: <Pine.LNX.3.96.990119114919.10611D-100000@ns1.ipeg.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 19 Jan 1999, Brad Boyer wrote:
> No, this is a Linux problem.  You cannot have more than 15 partitions
> on a drive because there are not device numbers allocated for anything
> higher than partition number 15.  So even if you create a partion 16,
> there is no way to access it under Linux.  This is the way that the
> device numbers were allocated.  As far as I know, there isn't a
> reasonable way to change this either.  Sorry I have to be the bearer
> of bad news, but that's the way things currently stand.

Not that know anything about it, but out of curiosity: couldn't you use
mknod to create >15 [hs]da's? Or could you recompile the kernal to allow
them?

Ian K. Erickson                 iPEG, the Internet Productivity Group
Systems Administator            W 422 Riverside, Suite 628
ian@ipeg.com                    Spokane, WA 99204
http://www.ipeg.com             (509)462-iPEG

4F6E65204F5320746F2072756C65207468656D20616C6C2C204F6E65204F5320746
F2066696E64207468656D2CDA4F6E65204F5320746F206272696E67207468656D20
616C6C20616E6420696E20746865206461726B6E6573732062696E64207468656D 


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
