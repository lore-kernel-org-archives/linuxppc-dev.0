Date: Wed, 17 Nov 1999 22:45:36 -0800
From: "David N. Welton" <davidw@linuxcare.com>
To: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: again 2.3.28
Message-ID: <19991117224536.A5744@bassano.linuxcare.com>
References: <davidw@linuxcare.com> <9911180426.AA27310@marc.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9911180426.AA27310@marc.watson.ibm.com>; from David Edelsohn on Wed, Nov 17, 1999 at 11:26:39PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Nov 17, 1999 at 11:26:39PM -0500, David Edelsohn wrote:
 
> 	You're just messing with something.  Most likely you are
> disrupting the condition register bits being used by the "blt"
> branch.

Hmm... well, the 'davidw_debug' is supposed to crap out.  It's a
function that calls printk, which I have been told is not really
available at that point in the game.  I have noticed that I get a nice
'default catch' when it hits the printk, whereas, if I move the
function further down the list of things that happens, it apparently
isn't reached (or at least nothing is printed), as nothing crashes.

Maybe I should use a function that is guaranteed to crash?

Anyway, by moving this 'bomb' function around and rebooting way too
much, I narrowed down a region of code that I don't get the crash
after (meaning it hasn't reached my crash function or that it is
suddently ok to call it).  That's what I posted...

It's been quite time consuming, and not very elegant, but lacking
anything else, it's all I have really (supposedly, someone is getting
me a null modem cable tommorow so that I can try and connect to the
serial port).

Thanks,
-- 
David N. Welton, Developer, Linuxcare, Inc.
415.354.4878 x241 tel, 415.701.7457 fax
davidw@linuxcare.com, http://www.linuxcare.com/
Linuxcare. At the center of Linux.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
