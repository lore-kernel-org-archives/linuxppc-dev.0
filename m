Date: Sat, 27 Jan 2001 20:25:00 -0500
From: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao mode
Message-ID: <20010127202500.A21618@allspice.cs.swarthmore.edu>
References: <20010126160441.B16573@allspice.cs.swarthmore.edu> <Pine.LNX.4.10.10101262206390.1670-100000@zirkon.biophys.uni-duesseldorf.de> <20010127163115.B2695@allspice.cs.swarthmore.edu> <20010127195924.A19744@allspice.cs.swarthmore.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010127195924.A19744@allspice.cs.swarthmore.edu>; from eisenbud@cs.swarthmore.edu on Sat, Jan 27, 2001 at 07:59:24PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jan 27, 2001 at 07:59:24PM -0500, Daniel Eisenbud <eisenbud@cs.swarthmore.edu> wrote:
>
> On Sat, Jan 27, 2001 at 04:31:15PM -0500, Daniel Eisenbud <eisenbud@cs.swarthmore.edu> wrote:
> > On Fri, Jan 26, 2001 at 10:32:35PM +0100, Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de> wrote:
> > > # same to a separate screen
> > > *.info;mail.none;authpriv.none;local0.none		/dev/tty7
> > >
> > > is what keeps a not-too-cluttered log (copy of /var/log/messages) on tty7
> > > of our server. kern.notice to some tty would probably be enough for you.
> > >
> > > > and not to any files so syslogd won't freeze when SCSI goes?  Is there
> > >
> > > So put just that one line redirecting log output to /dev/tty7 into
> > > syslog.conf temporarily and kill -1 syslogd before starting the test.
> >
> > I'll try this variation in a few minutes.
>
> This worked, but I didn't get any useful log output until I started
> getting error 600 from the SCSI midlevel and errors from ext2fs.  I'm
> going to try again, making sure that I have dmesg set as high as
> possible, and see if I can get anything else.  Otherwise, is it time to
> start scattering printk()'s around the mesh driver?

In fact, it looks like the mesh driver has significant debugging code.
My last attempt of this evening will be to turn that on and see if it
does anything.  If not, I'll look at this again tomorrow or the day
after.

-Daniel

--
Daniel E. Eisenbud
eisenbud@cs.swarthmore.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
