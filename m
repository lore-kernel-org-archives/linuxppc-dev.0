Message-ID: <3ABA24B8.7694BF5B@mvista.com>
Date: Thu, 22 Mar 2001 11:13:44 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
Cc: frowand@mvista.com,
	Matthias Fuchs <matthias.fuchs@esd-electronics.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>,
	frank@esd-electronics.com
Subject: Re: possible problem in memory management
References: <3AB8B894.1C5FCD37@esd-electronics.com> <3AB9148A.7F25E9A0@mvista.com> <3AB9254E.FE13F585@mvista.com> <3AB9CAE4.F92F3A6B@inn.ericsson.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kenneth Johansson wrote:

> But I do think there is a memory bug inte the version of the kernel he is using.

There certainly could be, but the Rev.C errata can show up as this
kind of symptom.  We haven't found anything on the Rev. D with our
QA testing.

> Running emacs or simply login over telnet puts it into that state.

I know that login over telnet works for me.  That isn't much of test,
as it is nice to be able to debug memory problems with carefully
controlled tests so you know if you have really corrected problems.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
