In-Reply-To: <20040323160117.GN1446@smtp.barco.com>
References: <20040316114030.GB7133@smtp.barco.com> <1079455175.4184.25.camel@localhost.localdomain> <20040322074833.GY7133@smtp.barco.com> <20040323111736.GJ1446@smtp.barco.com> <20040323160117.GN1446@smtp.barco.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9F5DB278-7D37-11D8-B146-003065D401D8@acm.org>
Cc: linuxppc-dev@lists.linuxppc.org
From: "Michael R. Zucca" <mrz5149@acm.org>
Subject: Re: PCI Memory mapping
Date: Tue, 23 Mar 2004 21:04:45 -0500
To: Marc Leeman <marc.leeman@barco.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mar 23, 2004, at 11:01 AM, Marc Leeman wrote:

> The strange thing is that the second buffer is always corrupted with
> seemingly 'old' data, at an offset of 4 words (32 bit) and this for
> only
> 24 words, the rest of the buffer is fine.
>
> The common factor seems to be 'timing', but unfortunately, this does
> not
> yet pinpoint the problem to either the DSP or the PPC side. Any
> experienced insight or well educated guesses?

Are you putting in sync instructions where appropriate?

--
----------------------------------------------
  Michael Zucca - mrz5149@acm.org
----------------------------------------------
  "I'm too old to use Emacs." -- Rod MacDonald
----------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
