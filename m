To: Gabriel Paubert <paubert@iram.es>
Cc: Dan Malek <dan@embeddededge.com>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: set_rtc_time() cleanup / normalization 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 15 May 2003 20:04:28 +0200."
             <20030515180427.GB20958@iram.es>
Date: Thu, 15 May 2003 20:21:24 +0200
Message-Id: <20030515182129.270C0C6092@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <20030515180427.GB20958@iram.es> Gabriel Paubert wrote:
>
> And to go against the existing documentation of hwclock(8) so that
> the behaviour depends on the architecture, the exact RTC chip model,
> the phase of the moon:

hwclock(8) does not correctly describe the current  situation.  There
are  already  several  boards where the documentation and the code do
not match. [Please note that I avoid writing  "the  documentation  is
wrong" - I think it is, but YMMV.]

> I personally believe that explicitly implementing something which goes
> against the existing documentation is one of the worst things that
> can happen, espcecially since (after a few years of experience with

If the documentation is wrong, or does not make sense,  it  would  be
even  worse  to  stick  with it just because it is "existing documen-
tation".


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A wise person makes his  own  decisions,  a  weak  one  obeys  public
opinion.                                           -- Chinese proverb

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
