Subject: Re: ibook G4 Status Report
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Costantino Pistagna <cpistagna@vrlteam.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <27203D60-5B28-11D8-A96D-000A95B30208@vrlteam.org>
References: <27203D60-5B28-11D8-A96D-000A95B30208@vrlteam.org>
Content-Type: text/plain
Message-Id: <1076361029.763.13.camel@gaston>
Mime-Version: 1.0
Date: Tue, 10 Feb 2004 08:10:30 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Since my ibook is a 12" equipped, i really need to use the video output
> with my 17" LCD.
>
> Any clues ? and/or usefull start point ?. i've tried to look inside
> xfree drivers sources,
> but without any good results. Seems that radeon9200 does not provide,
> any type of
> multiple screen support.

You have a VGA or DVI output ? VGA I think ? It should work with
Michel Danzer packages but it will be an analog output, not as good
as a fully digital.

XFree doesn't drive properly a DVI output on a laptop yet, though
I got it to work with a small userland hack I use to "fix" the chip
after X configured it ;)

Note that you may also have a problem with XFree not setting the proper
divider for your internal panel when used without UseFBDev. Same issue,
I have a userland "fix" for that since fixing it in XFree itself isn't
quite simple at this point.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
