Date: Mon, 30 Aug 1999 08:36:24 -0500 (CDT)
From: Nicholas Coult <coult@ima.umn.edu>
To: David Riley <happyoscar42@usa.net>
cc: Stephen Edie <sedie@terraplex.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Xfree86 support for Voodoo 3 acceleration
In-Reply-To: <37C973C9.B6FB489@usa.net>
Message-ID: <Pine.LNX.4.10.9908300832530.16851-100000@lilac.ima.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 29 Aug 1999, David Riley wrote:

> 
> Stephen Edie wrote:
> 
> > Is the full source code to the driver available?  Or is it written using
> > the Glide libraries?  If it is written using Glide, than it will be
> > necessary to contact 3dfx and get Glide ported to PPC Linux before it can
> > be ported.  Otherwise, it's entirely possible.  :)
> 
> This ought to happen once someone gets a LinuxPPC machine to Darryl Strauss
> <http://glide.xxedgexx.com>.
> 
> 

>From all appearances we don't need to wait for Darryl to have support
for 2-d acceleration in XFreee86.  Here is what Darryl himself had
to say in response to a post of mine in 3dfx.glide.linux:

> Nicholas Coult wrote:
>> 
>> What would it take to get support for the Voodoo 3 card under XFree-86 on
>> Linux/PPC?  How much of the support on the Intel side is
>> Intel-hardware-specific?
>
>Getting the X server to run shouldn't be bad. It might require changes
>to do byte swapping. 
>
>3D support would require Glide and at the moment there aren't any plans
>to port Glide to other platforms.
>
>                                                        - |Daryll

What I'm saying is, someone just needs to take the existing code and
tweak it a bit and plug it into the FBDev code and voila! We'll
have support for 2-d acceleration with Voodoo 3 cards.  I'd do it
myself if I had even the least clue where to begin - anybody have some 
pointers?

Dr. Nicholas Coult, Research Associate
Institute for Mathematics and Its Applications, University of Minnesota
Home Page: www.ima.umn.edu/~coult              Office: 555 Vincent Hall
Email: coult@ima.umn.edu      Phone: (612) 624-2527 Fax: (612) 624-4163


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
