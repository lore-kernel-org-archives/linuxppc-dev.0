Subject: Re: Max swap size ?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
To: Christopher Murtagh <christopher.murtagh@mcgill.ca>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.33.0112041131460.28164-100000@blues.wcg.mcgill.ca>
References: <Pine.LNX.4.33.0112041131460.28164-100000@blues.wcg.mcgill.ca>
Content-Type: text/plain; charset=ISO-8859-1
Date: 04 Dec 2001 19:37:23 +0100
Message-Id: <1007491043.21631.28.camel@pismo>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2001-12-04 at 17:35, Christopher Murtagh wrote:
>
>  Thanks for the replies.
>
> On 4 Dec 2001, Michel Dänzer wrote:
> >That used to be the case before kernel 2.2 IIRC. Nowadays the limit is
> >in the gigabytes. FWIW I'm using a 400 meg swap partition without
> >problems.
>
>  Ok, well that's good to hear.
>
> >Are you sure it only hit swap then? I can't remember ever seeing active
> >but completely unused swap space, even when RAM usage was low.
> >
> >The bottom line is yes, you likely have another problem.
>
>  This isn't though.. :-(
>
> Mem:  1024100K av,  774636K used,  249464K free,  0K shrd,  179708K  buff
> Swap:  524280K av,       0K used,  524280K free             490400K  cached
>
>  this is what my machine is like at the moment. So, from what you are
> saying, my problem lies elsewhere (ie. is not swap *size*), but is likely
> swap related?

Or maybe it's related to the huge amount of RAM you have, but others
will know better.


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
