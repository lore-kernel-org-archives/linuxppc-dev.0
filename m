To: Gerrit Van de Velde <gvd@denayer.wenk.be>
Cc: Andrew Dennison <andrew.dennison@motec.com.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on MPC5200 - LITE5200EVAL 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "11 Feb 2004 10:19:01 +0100."
             <1076491141.4841.6.camel@nios>
Date: Wed, 11 Feb 2004 11:14:55 +0100
Message-Id: <20040211101500.E7339C1215@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <1076491141.4841.6.camel@nios> you wrote:
>
> I followed these instructions and it all worked out fine (left out the
> examples directory of U boot though) , but after the reboot in lowboot
> jumper configuration, i only see garbage on my minicom screen. I can
> figure out some characters that look familiar (like the countdown for
> the autostart) so I assume it's working correctly but doesn't get
> displayed right. I also can't interrupt the countdown so input doesn't
> work. Already tried to change the 115200 8N1 settings of the
> communications (but why would they change anyway..) and didn't help.

You are using the latest U-Boot (= top of CVS), aren't you?  If  not:
try  it  out.  There  were  some  rounding  errors  in  the  baudrate
calculation.


Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"The question of whether a computer can think is no more  interesting
than the question of whether a submarine can swim"
                                                - Edsgar W.  Dijkstra

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
