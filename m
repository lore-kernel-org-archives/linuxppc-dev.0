Message-Id: <199905020931.LAA23358@denx.muc.de>
To: Claude Robitaille <crobitaille@videotron.ca>
Cc: linuxppc-dev@lists.linuxppc.org
From: Wolfgang Denk <wd@denx.muc.de>
Subject: Re: BDM for MPC860 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 01 May 1999 18:28:05 EDT."
             <Pine.LNX.3.95.990501181912.11708A-100000@localhost>
Date: Sun, 02 May 1999 11:31:51 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <Pine.LNX.3.95.990501181912.11708A-100000@localhost> you write:
> 
> I've search the net but I couldn't find anything supporting
> the BDM on an MPC8xx. I found a driver for Coldfire and for
> CPU32.

Well, of course there are lots of tools - commercial  ones.  See  for
instance  PowerTAP  by Applied Microsystems (www.amc.com), Trace32 by
Lauterbach (www.lauterbach.de), visionPROBE by EST (www.estc.com)  or
BlackBird  by  SDS  (www.sdsi.com)  [there  are some other vendors as
well, and usually there is more than one solution from each of  those
vendors]. Be prepared to hear prices in the 5...10 k$ range.

But I guess you  are  looking  for  a  (cheap)  hardware  probe  that
cooperates  nicely  with  some of the common freeware debugging tools
like GDB? This is something I'm looking for, too...

> First, I'd like to use the BDM to download the kernel; is
> there any tools? Eventually, I would also like to debug 
> applications and eventually the kernel.

With one of the above tools those things can be  done.  But  I  don't
know of a solution for the 860 or 8260 that does not take a few k$.

Wolfgang

-- 
Phone:  (+49)-8142-4596-86   Fax: (+49)-8142-4596-88   wd@denx.muc.de
Office: (+49)-89-722-27328               Wolfgang.Denk@ICN.Siemens.DE
It is impractical for  the  standard  to  attempt  to  constrain  the
behavior  of code that does not obey the constraints of the standard.
                                                          - Doug Gwyn

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
