To: "John W. Linville" <linville@lvl7.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux 2.4.17 bug, mmap of /dev/mem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 26 Feb 2002 09:43:58 EST."
             <3C7B9F2E.40BC7C46@lvl7.com>
Date: Tue, 26 Feb 2002 16:18:05 +0100
Message-Id: <20020226151810.2095D109E3@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


John,

in message <3C7B9F2E.40BC7C46@lvl7.com> you wrote:
>
> I've asked our hardware guys to take a look at the settings for the UPM
> we are using to control SDRAM.  Do you think we are on the right track?
> Can you provide any guidance?

Please be aware that UPM settings alone  are  NOT  sufficient  for  a
correct   initialization   of   most  SDRAM  chips.  Check  with  the
documentation for your SDRAM chips,  and  follow  the  initialization
sequence  TO THE LETTER. Pay special attention to minimum and maximum
delays, required dummy accesses, etc.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A committee is a life form with six or more legs and no brain.
                              -- Lazarus Long, "Time Enough For Love"

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
