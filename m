Date: Thu, 7 Feb 2002 07:27:18 -0500 (EST)
From: Christopher Murtagh <christopher.murtagh@mcgill.ca>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Highmem on PPC?
In-Reply-To: <20020205193316.19866@smtp.wanadoo.fr>
Message-ID: <Pine.LNX.4.33.0202070722270.7236-100000@blues.wcg.mcgill.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 5 Feb 2002, Benjamin Herrenschmidt wrote:
>Interesting. I have similar reports about dual 800s with 1.5G of RAM. I
>don't personally have a machine with that much RAM, so it makes things a
>bit difficult to debug.

 Hi Ben,

 When I get back from holidays I'm going to try those fixes you
recommended (using 2.4.18pre7 or later and with SUNGEM). I'm going to try
it on my Dual450 first because my Dual800 is currently in production and I
don't have another machine to replace it with at the moment. FWIW, the
Dual800 is very stable running 2.4.18pre1 (1GB) in single CPU mode, only
when I enable SMP does it lock up.

 If there is any particular thing you want me to do to test this thing
(run particular progs, etc.) let me know.

>And let me know if you find something ;)

 Will do.

Cheers,

Chris

--

Christopher Murtagh
Webmaster / Sysadmin
Web Communications Group
McGill University
Montreal, Quebec
Canada

Tel.: (514) 398-3122
Fax:  (514) 398-2017


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
