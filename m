To: Dan Malek <dan@embeddededge.com>
Cc: Eric.Oosterhof@radisys.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: I2C module problem on 8260 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 12 Feb 2002 18:10:36 EST."
             <3C69A0EC.2090400@embeddededge.com>
Date: Wed, 13 Feb 2002 00:18:08 +0100
Message-Id: <20020212231813.2D906109D7@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <3C69A0EC.2090400@embeddededge.com> you wrote:
>
> Finally, there isn't any deallocation function for CPM memory space.  I thought
> someone else was going to contribute this, and I apologize if I misplaced a patch,

I've sent such patches to Tom Rini many months ago (starting  29  Aug
2001),  and  in some iterations again and again. It's for 8xx only so
far, but adaption for 82xx is just a small exercise.

Unfortunately, this patch was always ignored (as some  others,  too),
so I finally gave up.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
See us @ Embedded Systems Nuremberg, Feb 19-21, Hall 12 K01 (with TQ)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
