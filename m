To: brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Bare bones filesytem using Karim's book 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 03 Jun 2003 06:55:07 PDT."
             <995FF289C9D69747A09E4299264459540C109862@penguin.adic.com>
Date: Tue, 03 Jun 2003 17:12:28 +0200
Message-Id: <20030603151233.92CABC5492@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Brian,

in message <995FF289C9D69747A09E4299264459540C109862@penguin.adic.com> you wrote:
>
> Regarding the ELDK target filesytem, all I did was try to strip it
> down using 'ppc_4xx-rpm -e package' as far as I could go. The
> remaining packages below are there because the above command would
> could not remove them because of package dependencies. So, the reason

Such an approach makes little sense for building an embedded system.

Why do you care about packages and package dependencies? You will not
use a package manager in hte target system, so you are free  to  copy
or remove individual files as you like.

Also, the approach to strip  down  a  general  purppose  distribution
(even  an embedded one) does not make much sense - as I wrote before,
you better design your system bottom up by  starting  with  an  empty
filesystem  and  just  adding  the  really required components. Where
"required" means "required to perform some task you defined  in  your
project specification".


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
We're all sorry for the other guy when he loses his job to a machine.
But when it comes to your job -- that's different. And it always will
be different.
	-- McCoy, "The Ultimate Computer", stardate 4729.4

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
