Date: Wed, 3 Sep 2003 16:14:55 +0200 (CEST)
From: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
To: linux-fbdev-devel@lists.sourceforge.net,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Atyfb with lcd support
Message-ID: <Pine.LNX.4.44.0309031605580.20201-100000@deadlock.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

The last years I've been doing a lot of work on making the Atyfb work with
LCD panels through the years and slowly but surely all laptops started
working. I thought it was time to share the work with the users and I
contacted Marcelo. Geert did a test if the driver still works on PPC and
he asked me if I could contact people for a few more portability tests.

To be clear, you won't be able to use LCD displays on PowerPC or any other
non x86 yet. The LCD parameters are read from the driver information table
in the graphics BIOS and this is of course x86 specific. Other than that
the code is portable and it should be easy to make work on PowerPC.

Without LCD support compiled in, the code is still very much as it was,
with one exception, the overclocking code. The old code does a few very
wrong things (by default if the user does not overclock) and crashed a lot
of chips. While hardware isn't easily damaged this way, 50% overclocks
make me a bit nervous.

So, while without LCD support the changes are small it's better to check
if nothing breaks. I don't want to send huge files to mailinglists, so
please e-mail me if you want the code.

My main question is if this this code break something that did work before.
I would also like to know if there are still boards that don't work at all.

Greetings,

Daniël


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
