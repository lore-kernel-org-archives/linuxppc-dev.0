From: Alan Mimms <alanm@unforgettable.com>
Date: Tue, 04 Jan 2000 03:16:51 GMT
Message-ID: <20000104.3165100@alanm.penguinpowered.com>
Subject: Re: cross-compiling & debugging embedded-linux apps
To: Brendan.Simon@ctam.com.au
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <38713F39.E72D77FF@ctam.com.au>
References: <386C3615.E14AE6DD@ctam.com.au> <19991231.6583200@alanm.penguinpowered.com> <386CD4AD.A0311DD9@mvista.com> <38713F39.E72D77FF@ctam.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You might want to use objdump -p on the file as suggested in an 
earlier post here today.  I think that's effectively like ldd's output 
only more so.

a

>>>>>>>>>>>>>>>>>> Original Message <<<<<<<<<<<<<<<<<<

On 1/3/00, 4:30:49 PM, Brendan J Simon <Brendan.Simon@ctam.com.au> wrote 
regarding Re: cross-compiling & debugging embedded-linux apps:


> Jim Lewis wrote:

> > Alan Mimms wrote:
> >
> > > You know about the ldd command?  Do 'ldd bjs1-shared' to see what
> > > libraries you need for your shared executable and make sure they're
> > > there and built with no floating point.  When you compile and link,

> Yep, but ldd doesn't seem to exist in my cross-tools.  Is it part of 
gcc,
> binutils or some other package ?


> > > you're using '-mcpu=860' or '-msoft-float', right?  That also could be
> > > a problem for you.

> I'm using -mcpu=860 but I am not specifying -msoft-float.  This 
shouldn't be a
> problem for a simple program that continuously prints out a string 
using puts().
> The static version runs so it is some kind of dynamic library loader 
problem I
> suspect.

> I've had some replies from the cross-gcc mailing list with some 
suggestions.
> I'll post any results worth mentioning.

> Thanks,
> Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
