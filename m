From: brian.auld@adic.com
Message-ID: <995FF289C9D69747A09E4299264459540C109863@penguin.adic.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Bare bones filesytem using Karim's book 
Date: Tue, 3 Jun 2003 08:28:23 -0700 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -----Original Message-----
> From: Wolfgang Denk [mailto:wd@denx.de]
> Sent: Tuesday, June 03, 2003 11:12 AM
> To: brian.auld@adic.com
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: Bare bones filesytem using Karim's book
>
> Dear Brian,
>
> in message <995FF289C9D69747A09E4299264459540C109862@penguin.adic.com> you
> wrote:
> >
> > Regarding the ELDK target filesytem, all I did was try to strip it
> > down using 'ppc_4xx-rpm -e package' as far as I could go. The
> > remaining packages below are there because the above command would
> > could not remove them because of package dependencies. So, the reason
>
> Such an approach makes little sense for building an embedded system.


Thanks for the feedback Wolfgang. My intention ultimately is to build my tgt filesytem from the ground up. The ELDK tinkering was an attempt to provide a comparison platform to try and help me understand why my bare bones filesytem wasn't working...


>
> Why do you care about packages and package dependencies? You will not
> use a package manager in hte target system, so you are free  to  copy
> or remove individual files as you like.
>
> Also, the approach to strip  down  a  general  purppose  distribution
> (even  an embedded one) does not make much sense - as I wrote before,
> you better design your system bottom up by  starting  with  an  empty
> filesystem  and  just  adding  the  really required components. Where
> "required" means "required to perform some task you defined  in  your
> project specification".

That's what I'm trying to do, building from the ground up that is. Just can't get my bare bones system (basic rootfs dir infrastructure with busybox) to boot yet :-(

-- Brian

>
>
> Best regards,
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> We're all sorry for the other guy when he loses his job to a machine.
> But when it comes to your job -- that's different. And it always will
> be different.
> 	-- McCoy, "The Ultimate Computer", stardate 4729.4

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
