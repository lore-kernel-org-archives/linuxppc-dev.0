Message-ID: <37A2BA72.6478427F@agelectronics.co.uk>
Date: Sat, 31 Jul 1999 09:57:22 +0100
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: embedded PowerPC porting coordination [was Re: Motorola Web Site]
References: <199907290636.IAA07134@denx.muc.de> <37A19963.AE7DBE66@mitre.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Charles Lepple wrote:
> Wolfgang Denk wrote:
> > To support a  broader  range  ofborads  some  cleanup  is  necessary,
> > isolating  HW  dependent  parts  of  the  code  in "BSP" like groups,
> > allowing for easier configuration of device configuration,  port  pin
> > assignment etc.
> 
> I'm not exactly volunteering for the job of coordinating this, but I
> would have to agree. Would it make sense to start another list
> ("linuxppc-embedded," perhaps?) to discuss this at greater length?

Another thing to consider - linuxppc-dev is already a mix of PPC kernel
development, and linuxppc distribution userspace issues. I've ported
2.2.10 to my embedded board, but I'm using a Debian userspace.

The PPC kernel is halfway towards a sensible BSP structure already - all
it needs is some tidying up, a sensible directory structure for BSPs,
and a few new conditions like CONFIG_PPC_HAVE_OPEN_FIRMWARE. The main
area to work on is arch/ppc/mm/init.c, which has to have too many board
specific functions in its current form.

- Adrian Cox, AG Electronics.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
