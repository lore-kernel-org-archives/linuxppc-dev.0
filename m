Date: Thu, 23 Mar 2000 12:17:08 +0100
From: ce <cesli@ewetel.net>
To: DeRobertis <derobert@erols.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: stty crtscts < /dev/ttyS1 [603ev]
Message-ID: <20000323121707.B3929@olis.north.de>
Reply-To: cl.en@gmx.net
References: <l03130302b4fd80d3a908@[216.164.130.191]> <38D8EF56.17970FBC@astro.wisc.edu> <l03130300b4ff357b23e8@[216.164.129.33]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <l03130300b4ff357b23e8@[216.164.129.33]>; from DeRobertis on Wed, Mar 22, 2000 at 09:49:42PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 Matt Haffner }  >Try this syntax: "stty -F /dev/ttyS1 crtscts". There's a comment in the
 Matt Haffner }  >info doc for stty that letting the shell open the device may block in
 Matt Haffner }  >certain situations.
 DeRobertis }
 DeRobertis }  Does not help. Same problem. Let me clarify "freeze", though. I mean it
 DeRobertis }  takes out the machine -- the kernel does not run processes. The machine
 DeRobertis }  might as well be turned off; it'd do as much good.
 DeRobertis }
 DeRobertis }  Unfortunately, no oopses. No backtraces. No entries in
 DeRobertis }  /var/log/messages. Nothing. It just dies.
 DeRobertis }
 DeRobertis }  A rather serious kernel bug, IMO.
 DeRobertis }
 DeRobertis }  cc'd to l-k. It's 2.2.14 running on a ppp-603ev.

 same story on my pb3400_603ev, but an old one, even with 2.1.85 as far as I remember correctly. The second try to influence ttyS0 via stty [now 2.2.14] stops everything as you described, a little bit annoying. Perhaps a problem of our special RS?
People like Paul M. have been working with a pb3400, do you know others?

greetings Claus

--
>45. Id. at 50-51; Lewinsky 8/6/98 GJ at 21.
>On this occasion, the President ejaculated. Lewinsky 8/26/98 Depo. at 50-51.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
