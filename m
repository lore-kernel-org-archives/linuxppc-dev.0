To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Updated Mozilla M13 Release Build Available
In-reply-to: Your message of "Fri, 28 Jan 2000 12:56:33 EST."
             <3891D851.EDDCF3ED@erols.com>
References: <Pine.LNX.4.10.10001280907150.2865-100000@xpol.uchicago.edu>
 <E12EDU8-0002IT-00@puetz.penguinpowered.com>  <3891D851.EDDCF3ED@erols.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 Jan 2000 13:19:38 -0600
From: Kevin Puetz <puetzk@iastate.edu>
Message-Id: <E12EGvi-0002cv-00@puetz.penguinpowered.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Kevin Puetz wrote:
> Before I answer thes, are there any people with positive reports? I
> need to
> hear from you if it installed perfectly as well as if you had
> problems. Please
> be sure you include me directly in the replies to this message. I'm
> cc'ing the
> list in case anyone else is interested in simplebrowser.

> I have your original post of mozilla 13 (after getting the new
> libstdc++ and even the wierd libelf symlink fix..) There are some
> bugs, but it's working fine otherwise..

> --Nelson Abramson

OK people, please cut it out with the libelf hack :-). I statically linked
that one lib in (that's what the update last night was), as LinuxPPC appears
to not have it. I need to know that the updated version posted to
<http://www.public.iastate.edu/~puetzk> late last night now works on a vanilla
LinuxPPC system (+libstdc++-2.10) without any other messing around. Can anyone
give me a yes/no?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
