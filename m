Date: Wed, 4 Apr 2001 11:12:35 +1000
From: Steven Hanley <sjh@svana.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: External Monitor under Pismo
Message-ID: <20010404111235.A463@wibble.net>
Reply-To: Steven Hanley <sjh@wibble.net>
References: <87vgonhx7p.fsf@amadeus.openinformatics.com> <3AC9B2DC.1567BC90@netfall.com> <986310913.29215.0.camel@spectrolite>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <986310913.29215.0.camel@spectrolite>; from tigert@ximian.com on Tue, Apr 03, 2001 at 06:15:13PM +0300
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Apr 03, 2001 at 06:15:13PM +0300, Tuomas Kuosmanen wrote:
> "mirror" works fine for me even on kernel 2.4.3 on my Pismo. Weird. This
> kernel is from Ben's rsync and it contains the pismo sleep code as well.
>
>     rsync -avz --delete penguinppc.org::linux-2.4-benh linux-2.4-benh
>
> I got scared because I am going to GUADEC (a GNOME conference in
> Denmark) this weekend and it would have sucked badly if it didnt work,
> but so far it looks good :o)
>
> I originally had just a binary of "mirror" which worked, but I compiled
> the one which was attached to Jason's mail and it worked as well.

hmm, well Paul got mirror working on Hugh Blemmings slightly pre pismo
laptop at linux.conf.au, some 8 line hack or so he did with his usual
panache. At the time I assumed it would not work with my pismo as it was a
different machine. (as Paul has pointed out on occasion) But this is good
news if benh's kernesl will work with the mirror program, I am also running
one currently to use sleep (which works perfectly, hooray ben :), will give
it a try on my pismo if I get a free moment some time today.

Oh yeah I notice Paul was at that kernel hackers thing in the US that has
just happened, were there any other ppc hackers there? Cort? Ben? any of the
mvista people?

	See You
	    Steve

--
sjh@wibble.net http://wibble.net/~sjh/
Look Up In The Sky
   Is it a bird?  No
      Is it a plane?  No
         Is it a small blue banana?
YES

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
