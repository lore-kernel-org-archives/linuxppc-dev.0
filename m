Return-Path: <frannk_m1@yahoo.com>
Message-ID: <20041024193333.98497.qmail@web13804.mail.yahoo.com>
Date: Sun, 24 Oct 2004 12:33:33 -0700 (PDT)
From: Frank <frannk_m1@yahoo.com>
To: Ryan Wilkins <ryan@elevated-networks.com>,
	linuxppc-embedded@ozlabs.com
In-Reply-To: <84A6F2F4-25E7-11D9-BA35-0050E4B0DC64@elevated-networks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: 
Subject: Re: MPC850 and GDB help
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

You probably want to post this to the u-boot users mailing
lists. Compiling and linking u-boot to run out of ram is not a
straight forward task. I've done it on more then one board, but
it is not easy if you're a u-boot novice.
Search the list for "running out of ram" or something like that
and you'll see what I mean.:-)


--- Ryan Wilkins <ryan@elevated-networks.com> wrote:

> Hello..  I'm very new to embedded systems but want to learn a
> bit more 
> by using existing hardware.  In this case, the existing
> hardware is a 
> DirectvDSL ADSL modem based on the MPC850 processor.  I've
> located the 
> BDM port and built a MPCBDM version 2 interface to communicate
> with the 
> MPC850.  The interface works just fine.
> 
> What I want to do now is to load the u-boot bootloader onto
> the board.  
> What I'm trying to accomplish now is to load the u-boot code
> into ram 
> and run it.  I don't have my flash definitions right in MPCBDM
> yet, 
> otherwise I'd try to flash it.  I realize that this is not
> going to be 
> an easy task, but what better way to learn than to dive right
> in.  So.. 
>   I'm stumped.  Can anyone provide just a little bit of idea
> of where to 
> go from here?  Perhaps a tutorial URL, or some past experience
> in 
> working with the 850?
> 
> The board has a single 4 Mbyte flash chip (Intel DA28F320J5)
> and 16 
> Mbyte RAM.
> 
> Thanks,
> Ryan Wilkins
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 



		
_______________________________
Do you Yahoo!?
Declare Yourself - Register online to vote today!
http://vote.yahoo.com
