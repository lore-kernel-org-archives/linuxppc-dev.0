Message-Id: <199902142110.WAA00523@piglet.cpu.lu>
Date: Sun, 14 Feb 1999 22:10:52 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Why is -msoft-float used in Kernel compilation?
To: u497w7n9@umail.furryterror.org
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <199902131436.JAA07672@linuxmaster.corel.eng>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  13 Feb, this message from Gavriel State echoed through cyberspace:
> 
> I can understand using -msoft-float if CONFIG__8xx is on,
> but why use it when compiling for 60x or 7x0 CPUs?

I've heard something about a 'no floiting point in kernel' rule, and
I've tried compiling without -msoft-float.... it does boot, but it's an
ugly sight... fp warning messages all over!

I have, however, never seen a clear explanation of why that rule
exists...

Any guru around?

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
