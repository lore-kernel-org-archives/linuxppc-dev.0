Message-ID: <6B546A602AD2D211BFF00008C7A4288905844007@hrtades2.atea.be>
From: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
To: "'Owen Green '" <owenjinggreen@yahoo.com>,
	"'Christian Pellegrin '" <chri@infis.univ.trieste.it>
Cc: "'linuxppc-embedded@lists.linuxppc.org '" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: gdbserver ppc8xx
Date: Fri, 1 Mar 2002 11:07:53 +0100 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Did you try using strace? This can give you info about why gdbserver quits.

I also had a problem with gdbserver and this is the way I solved it...

Fred

-----Original Message-----
From: Owen Green
To: Christian Pellegrin
Cc: linuxppc-embedded@lists.linuxppc.org
Sent: 2/28/02 2:50 PM
Subject: Re: gdbserver ppc8xx


--- Christian Pellegrin <chri@infis.univ.trieste.it>
wrote:
> On Wed, 27 Feb 2002, Owen Green wrote:
>
> > edition but I got something like:
> > #gdbserver :7777 /bin/test
> > Process /bin/test created; pid = 48
> > getprotobyname:Sucess.
> > Exiting
> > #
> just copy /etc/protocols from whatever distro you
> like. Bye!
>

This did not work, I got the getprotobyname: Sucess,
what means my /etc/protocols have the entry for tcp.
Thanks anyway.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
