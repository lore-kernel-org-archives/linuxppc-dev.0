Message-ID: <37D0F88E70D96C428C19EEB865701A38027D1105@buda902a.siemens.hu>
From: =?iso-8859-1?Q?M=E9sz=E1ros_Lajos?= <ludwigm@siemens.com>
To: Mark Chambers <markc@mail.com>,
	"Wells, Charles" <Charles.Wells@NielsenMedia.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Linux is not reliable enough?
Date: Tue, 27 Jul 2004 17:59:42 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> >   int a[100], b = 123;
> >   a[b] = 0;
> >
> > I guess I'm taking exception to your use of the phrase "all
> software".
> >
> >
>
> What I mean is, if &a = 0x10000, then a[b] will always write
> 0 to 0x101ec.
> That may not be smart, may not be what you intended to do,
> but the uP will
> always do the exact same thing.  (Does this mean 'C' is
> unreliable because
> it lets you do things like that?)

Yes, 'C' is unreliable because writing beyond the
"maxindex" lets you overwrite other's data, other's
code and DOES make backdoor for viruses.

On the other hand testing every index every time
for min and max slowes the executing.

So what?

    Ludwig

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
