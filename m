Date: Tue, 29 Jan 2002 09:52:57 -0500 (EST)
From: Christopher Murtagh <christopher.murtagh@mcgill.ca>
To: <linuxppc-dev@lists.linuxppc.org>
Cc: Christopher Murtagh <christopher.murtagh@mcgill.ca>,
	<yellowdog-devel@lists.yellowdoglinux.com>
Subject: Re: Support for new Dual G4 1 Gig machines?
In-Reply-To: <20020129123955.29280@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.33.0201290949451.12240-100000@blues.wcg.mcgill.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 29 Jan 2002 benh@kernel.crashing.org wrote:
>I recently spotted a problem with >512Mb (CONFIG_HIGHMEM or not) & SMP
>that is fixed in the current bk _2_4 (2.4.18pre7). I also sent a fix to
>Marcelo that should hopefully be in the next 2.4.18preX release.

 Cool, thanks Ben! I'll give it a try soon.

>You should also use sungem preferably to the old gmac driver.

 Do you suspect that this is what is causing my crashes when the box is
exposed to moderately high network volume?

 Thanks again.

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
