To: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Compiling and using hhl's glibc 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 31 Jul 2001 14:28:18 EDT."
             <Pine.LNX.4.33.0107311414190.1947-100000@localhost.localdomain>
Date: Tue, 31 Jul 2001 16:50:06 +0200
Message-Id: <20010731145011.C5CE510CAC@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Pine.LNX.4.33.0107311414190.1947-100000@localhost.localdomain> you wrote:
>
> I am getting ready, at long last, to start using glibc on our 603e based
> embedded board. Hitherto, I have not used and of the HHL tools. It does,
> however, look like their glibc has the best patches, so I'd like to give

How did you define "best patches" ?

> My first big question is whether or not all of the needed patched are
> already applied? There are 10 obvious patch files in the directory created
> from the rpm.
...
> I should be able to handle the actual compile well enough- heaven knows
> I've built glibc enough times (sigh...) But, does anyone have
> recommendations for things to or not to do?

Why don't you just follow the build instructions in tyhe  .spec  file
that is included with the source RPM?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Remember that Beethoven wrote his first symphony in C ...

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
